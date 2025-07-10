Performance Optimization Guide
==============================

This guide provides detailed information about optimizing the performance of the e-commerce chatbot system, including database optimization, caching strategies, and monitoring.

Overview
--------

Performance optimization is crucial for providing a responsive user experience. This guide covers various optimization techniques for different components of the system.

**Key Areas**:
- Database Performance
- Caching Strategies
- Search Optimization
- LLM Response Optimization
- Memory Management
- Monitoring and Profiling

Database Performance Optimization
--------------------------------

**Query Optimization**

**Index Optimization**

Ensure proper indexes are created for frequently queried columns:

.. code-block:: sql

   -- Products table indexes
   CREATE INDEX CONCURRENTLY idx_products_name ON products(name);
   CREATE INDEX CONCURRENTLY idx_products_category_price ON products(category_id, price);
   CREATE INDEX CONCURRENTLY idx_products_brand_active ON products(brand, is_active);
   
   -- Orders table indexes
   CREATE INDEX CONCURRENTLY idx_orders_user_status ON orders(user_id, status);
   CREATE INDEX CONCURRENTLY idx_orders_created_at ON orders(created_at);
   
   -- Search optimization indexes
   CREATE INDEX CONCURRENTLY idx_products_search ON products USING gin(to_tsvector('english', name || ' ' || COALESCE(description, '')));

**Query Optimization Techniques**

1. **Use EXPLAIN ANALYZE**
   - Analyze query execution plans
   - Identify bottlenecks
   - Optimize slow queries

.. code-block:: sql

   EXPLAIN ANALYZE 
   SELECT p.*, c.name as category_name
   FROM products p
   LEFT JOIN categories c ON p.category_id = c.id
   WHERE p.is_active = true AND p.price BETWEEN 100 AND 1000;

2. **Avoid N+1 Queries**
   - Use JOINs instead of multiple queries
   - Batch related queries
   - Use eager loading

.. code-block:: python

   # Bad: N+1 query problem
   products = await db.fetch("SELECT * FROM products WHERE category_id = $1", category_id)
   for product in products:
       category = await db.fetchrow("SELECT * FROM categories WHERE id = $1", product['category_id'])

   # Good: Single query with JOIN
   products = await db.fetch("""
       SELECT p.*, c.name as category_name
       FROM products p
       LEFT JOIN categories c ON p.category_id = c.id
       WHERE p.category_id = $1
   """, category_id)

3. **Use Connection Pooling**
   - Configure appropriate pool size
   - Monitor connection usage
   - Handle connection timeouts

.. code-block:: python

   # Optimize connection pool settings
   pool_config = {
       'min_size': 10,
       'max_size': 50,
       'command_timeout': 30,
       'server_settings': {
           'application_name': 'chatbot_app',
           'statement_timeout': '30000'  # 30 seconds
       }
   }

**Database Configuration Optimization**

.. code-block:: sql

   -- PostgreSQL configuration optimizations
   ALTER SYSTEM SET shared_buffers = '256MB';
   ALTER SYSTEM SET effective_cache_size = '1GB';
   ALTER SYSTEM SET work_mem = '4MB';
   ALTER SYSTEM SET maintenance_work_mem = '64MB';
   ALTER SYSTEM SET checkpoint_completion_target = 0.9;
   ALTER SYSTEM SET wal_buffers = '16MB';
   ALTER SYSTEM SET default_statistics_target = 100;
   ALTER SYSTEM SET random_page_cost = 1.1;
   ALTER SYSTEM SET effective_io_concurrency = 200;

Caching Strategies
-----------------

**Multi-Level Caching**

**Application-Level Caching**

.. code-block:: python

   from functools import lru_cache
   import asyncio
   from typing import Dict, Any

   class CacheManager:
       def __init__(self):
           self.memory_cache: Dict[str, Any] = {}
           self.cache_ttl: Dict[str, float] = {}

       @lru_cache(maxsize=1000)
       def get_cached_product(self, product_id: int):
           """Cache frequently accessed products"""
           return self.fetch_product_from_db(product_id)

       async def get_cached_search_results(self, query: str, filters: Dict):
           """Cache search results"""
           cache_key = f"search:{hash(str(query) + str(filters))}"
           
           if cache_key in self.memory_cache:
               cached_time = self.cache_ttl.get(cache_key, 0)
               if time.time() - cached_time < 300:  # 5 minutes TTL
                   return self.memory_cache[cache_key]
           
           # Fetch from database
           results = await self.search_products(query, filters)
           
           # Cache results
           self.memory_cache[cache_key] = results
           self.cache_ttl[cache_key] = time.time()
           
           return results

**Redis Caching**

.. code-block:: python

   import redis
   import json
   from typing import Optional, Any

   class RedisCache:
       def __init__(self, redis_url: str):
           self.redis = redis.from_url(redis_url)
           self.default_ttl = 300  # 5 minutes

       async def get(self, key: str) -> Optional[Any]:
           """Get value from cache"""
           try:
               value = self.redis.get(key)
               return json.loads(value) if value else None
           except Exception:
               return None

       async def set(self, key: str, value: Any, ttl: int = None):
           """Set value in cache"""
           try:
               ttl = ttl or self.default_ttl
               self.redis.setex(key, ttl, json.dumps(value))
           except Exception:
               pass  # Fail silently

       async def delete(self, key: str):
           """Delete value from cache"""
           try:
               self.redis.delete(key)
           except Exception:
               pass

   # Usage examples
   cache = RedisCache("redis://localhost:6379")

   # Cache product data
   async def get_product_with_cache(product_id: int):
       cache_key = f"product:{product_id}"
       
       # Try cache first
       cached_product = await cache.get(cache_key)
       if cached_product:
           return cached_product
       
       # Fetch from database
       product = await fetch_product_from_db(product_id)
       
       # Cache for 10 minutes
       await cache.set(cache_key, product, ttl=600)
       
       return product

**Cache Invalidation Strategies**

.. code-block:: python

   class CacheInvalidationManager:
       def __init__(self, cache: RedisCache):
           self.cache = cache

       async def invalidate_product_cache(self, product_id: int):
           """Invalidate product-related cache"""
           patterns = [
               f"product:{product_id}",
               f"search:*",  # Invalidate all search results
               f"category:*"  # Invalidate category-related cache
           ]
           
           for pattern in patterns:
               await self.cache.delete_pattern(pattern)

       async def invalidate_user_cache(self, user_id: int):
           """Invalidate user-related cache"""
           patterns = [
               f"user:{user_id}",
               f"cart:{user_id}",
               f"session:{user_id}"
           ]
           
           for pattern in patterns:
               await self.cache.delete_pattern(pattern)

Search Optimization
-------------------

**Search Algorithm Optimization**

**Fuzzy Search Optimization**

.. code-block:: python

   from difflib import SequenceMatcher
   import re

   class OptimizedFuzzyMatcher:
       def __init__(self, config):
           self.threshold = config.search.fuzzy_threshold
           self.max_distance = config.search.max_distance
           self.cache = {}

       def optimized_fuzzy_search(self, query: str, products: List[Product]) -> List[Product]:
           """Optimized fuzzy search with caching and early termination"""
           cache_key = f"fuzzy:{query.lower()}"
           
           if cache_key in self.cache:
               return self.cache[cache_key]
           
           results = []
           query_lower = query.lower()
           
           for product in products:
               # Early termination for exact matches
               if query_lower in product.name.lower():
                   results.append((product, 1.0))
                   continue
               
               # Calculate similarity
               similarity = self.calculate_similarity(query_lower, product.name.lower())
               
               if similarity >= self.threshold:
                   results.append((product, similarity))
           
           # Sort by similarity and limit results
           results.sort(key=lambda x: x[1], reverse=True)
           results = results[:self.max_results]
           
           # Cache results
           self.cache[cache_key] = [product for product, _ in results]
           
           return self.cache[cache_key]

       def calculate_similarity(self, query: str, target: str) -> float:
           """Optimized similarity calculation"""
           # Use faster similarity algorithms
           return SequenceMatcher(None, query, target).ratio()

**Vector Search Optimization**

.. code-block:: python

   import chromadb
   from chromadb.config import Settings

   class OptimizedVectorSearch:
       def __init__(self, config):
           self.client = chromadb.Client(Settings(
               chroma_db_impl="duckdb+parquet",
               persist_directory="./chroma_db"
           ))
           self.collection = self.client.get_or_create_collection("products")

       async def optimized_semantic_search(self, query: str, limit: int = 10):
           """Optimized semantic search with batching"""
           # Batch similar queries
           cache_key = f"semantic:{hash(query)}"
           
           if hasattr(self, '_cache') and cache_key in self._cache:
               return self._cache[cache_key]
           
           # Perform semantic search
           results = self.collection.query(
               query_texts=[query],
               n_results=limit,
               include=["metadatas", "distances"]
           )
           
           # Cache results
           if not hasattr(self, '_cache'):
               self._cache = {}
           self._cache[cache_key] = results
           
           return results

LLM Response Optimization
------------------------

**Response Caching**

.. code-block:: python

   class LLMResponseCache:
       def __init__(self, cache: RedisCache):
           self.cache = cache
           self.ttl = 3600  # 1 hour

       async def get_cached_response(self, prompt: str, model: str) -> Optional[str]:
           """Get cached LLM response"""
           cache_key = f"llm:{hash(prompt + model)}"
           return await self.cache.get(cache_key)

       async def cache_response(self, prompt: str, model: str, response: str):
           """Cache LLM response"""
           cache_key = f"llm:{hash(prompt + model)}"
           await self.cache.set(cache_key, response, ttl=self.ttl)

   # Usage in LLM core
   class OptimizedLLMCore:
       def __init__(self, config, cache: LLMResponseCache):
           self.config = config
           self.cache = cache

       async def get_response(self, prompt: str) -> str:
           # Check cache first
           cached_response = await self.cache.get_cached_response(prompt, self.config.llm.model)
           if cached_response:
               return cached_response
           
           # Get response from LLM
           response = await self.call_llm_api(prompt)
           
           # Cache response
           await self.cache.cache_response(prompt, self.config.llm.model, response)
           
           return response

**Token Optimization**

.. code-block:: python

   class TokenOptimizer:
       def __init__(self, config):
           self.max_tokens = config.llm.max_tokens
           self.tokenizer = self.get_tokenizer()

       def optimize_prompt(self, prompt: str, context: Dict = None) -> str:
           """Optimize prompt to reduce token usage"""
           # Remove unnecessary context
           if context and len(prompt) > 1000:
               # Keep only essential context
               essential_context = {
                   'user_intent': context.get('intent'),
                   'current_products': context.get('products', [])[:3]
               }
               prompt = self.build_optimized_prompt(prompt, essential_context)
           
           # Truncate if still too long
           if len(prompt) > self.max_tokens * 4:  # Rough estimate
               prompt = prompt[:self.max_tokens * 4]
           
           return prompt

       def build_optimized_prompt(self, prompt: str, context: Dict) -> str:
           """Build optimized prompt with minimal context"""
           return f"""
           Context: {json.dumps(context, separators=(',', ':'))}
           Query: {prompt}
           Response:"""

Memory Management
-----------------

**Memory Optimization Techniques**

**Object Pooling**

.. code-block:: python

   from typing import Dict, Any
   import weakref

   class ObjectPool:
       def __init__(self, max_size: int = 100):
           self.max_size = max_size
           self.pool: Dict[str, Any] = {}
           self.usage_count: Dict[str, int] = {}

       def get_object(self, key: str, factory_func):
           """Get object from pool or create new one"""
           if key in self.pool:
               self.usage_count[key] += 1
               return self.pool[key]
           
           if len(self.pool) >= self.max_size:
               # Remove least used object
               least_used = min(self.usage_count.items(), key=lambda x: x[1])
               del self.pool[least_used[0]]
               del self.usage_count[least_used[0]]
           
           # Create new object
           obj = factory_func()
           self.pool[key] = obj
           self.usage_count[key] = 1
           
           return obj

   # Usage example
   search_engine_pool = ObjectPool(max_size=10)

   def get_search_engine():
       return search_engine_pool.get_object(
           "default",
           lambda: SearchEngine(get_config())
       )

**Garbage Collection Optimization**

.. code-block:: python

   import gc
   import psutil
   import asyncio

   class MemoryManager:
       def __init__(self):
           self.memory_threshold = 0.8  # 80% memory usage threshold
           self.gc_threshold = 1000  # Objects threshold

       async def monitor_memory(self):
           """Monitor memory usage and trigger cleanup"""
           while True:
               memory_percent = psutil.virtual_memory().percent / 100
               
               if memory_percent > self.memory_threshold:
                   await self.cleanup_memory()
               
               await asyncio.sleep(60)  # Check every minute

       async def cleanup_memory(self):
           """Perform memory cleanup"""
           # Force garbage collection
           collected = gc.collect()
           
           # Clear caches if needed
           if hasattr(self, 'cache'):
               self.cache.clear()
           
           print(f"Memory cleanup completed. Collected {collected} objects.")

**Resource Management**

.. code-block:: python

   import contextlib
   from typing import Generator

   @contextlib.contextmanager
   def resource_manager() -> Generator[None, None, None]:
       """Context manager for resource cleanup"""
       try:
           yield
       finally:
           # Cleanup resources
           gc.collect()

   # Usage
   with resource_manager():
       # Perform memory-intensive operations
       results = perform_heavy_computation()
       process_results(results)

Monitoring and Profiling
-----------------------

**Performance Monitoring**

.. code-block:: python

   import time
   import psutil
   from typing import Dict, Any
   from dataclasses import dataclass

   @dataclass
   class PerformanceMetrics:
       response_time: float
       memory_usage: float
       cpu_usage: float
       database_queries: int
       cache_hits: int
       cache_misses: int

   class PerformanceMonitor:
       def __init__(self):
           self.metrics: Dict[str, PerformanceMetrics] = {}

       def start_monitoring(self, operation: str):
           """Start monitoring an operation"""
           self.metrics[operation] = PerformanceMetrics(
               response_time=time.time(),
               memory_usage=psutil.virtual_memory().percent,
               cpu_usage=psutil.cpu_percent(),
               database_queries=0,
               cache_hits=0,
               cache_misses=0
           )

       def end_monitoring(self, operation: str):
           """End monitoring and record metrics"""
           if operation in self.metrics:
               start_metrics = self.metrics[operation]
               end_time = time.time()
               
               metrics = PerformanceMetrics(
                   response_time=end_time - start_metrics.response_time,
                   memory_usage=psutil.virtual_memory().percent,
                   cpu_usage=psutil.cpu_percent(),
                   database_queries=start_metrics.database_queries,
                   cache_hits=start_metrics.cache_hits,
                   cache_misses=start_metrics.cache_misses
               )
               
               self.record_metrics(operation, metrics)

       def record_metrics(self, operation: str, metrics: PerformanceMetrics):
           """Record performance metrics"""
           # Log metrics
           print(f"Operation: {operation}")
           print(f"Response Time: {metrics.response_time:.3f}s")
           print(f"Memory Usage: {metrics.memory_usage:.1f}%")
           print(f"CPU Usage: {metrics.cpu_usage:.1f}%")
           print(f"Database Queries: {metrics.database_queries}")
           print(f"Cache Hit Rate: {metrics.cache_hits/(metrics.cache_hits+metrics.cache_misses)*100:.1f}%")

**Database Performance Monitoring**

.. code-block:: sql

   -- Monitor slow queries
   SELECT query, mean_time, calls, total_time
   FROM pg_stat_statements
   ORDER BY mean_time DESC
   LIMIT 10;

   -- Monitor table sizes
   SELECT schemaname, tablename, 
          pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as size
   FROM pg_tables
   WHERE schemaname = 'public'
   ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;

   -- Monitor index usage
   SELECT schemaname, tablename, indexname, idx_scan, idx_tup_read, idx_tup_fetch
   FROM pg_stat_user_indexes
   ORDER BY idx_scan DESC;

**Application Performance Monitoring**

.. code-block:: python

   import logging
   from functools import wraps
   import time

   def performance_logger(func):
       """Decorator to log function performance"""
       @wraps(func)
       async def wrapper(*args, **kwargs):
           start_time = time.time()
           start_memory = psutil.virtual_memory().percent
           
           try:
               result = await func(*args, **kwargs)
               return result
           finally:
               end_time = time.time()
               end_memory = psutil.virtual_memory().percent
               
               logging.info(f"Function: {func.__name__}")
               logging.info(f"Execution Time: {end_time - start_time:.3f}s")
               logging.info(f"Memory Delta: {end_memory - start_memory:.1f}%")

       return wrapper

   # Usage
   @performance_logger
   async def search_products(query: str, filters: Dict):
       # Search implementation
       pass

Performance Best Practices
-------------------------

**General Optimization Tips**

1. **Profile First**: Always profile before optimizing
2. **Measure Impact**: Measure the impact of optimizations
3. **Optimize Hot Paths**: Focus on frequently executed code
4. **Use Appropriate Data Structures**: Choose the right data structures for the task
5. **Avoid Premature Optimization**: Don't optimize code that doesn't need it

**Database Optimization**

1. **Use Indexes Wisely**: Create indexes for frequently queried columns
2. **Optimize Queries**: Use EXPLAIN ANALYZE to optimize slow queries
3. **Use Connection Pooling**: Configure appropriate pool sizes
4. **Monitor Performance**: Regularly monitor database performance

**Caching Strategies**

1. **Cache Frequently Accessed Data**: Cache data that is accessed frequently
2. **Use Appropriate TTL**: Set appropriate time-to-live values
3. **Invalidate Cache Properly**: Implement proper cache invalidation
4. **Monitor Cache Hit Rates**: Monitor cache effectiveness

**Memory Management**

1. **Use Object Pooling**: Reuse objects when possible
2. **Implement Proper Cleanup**: Clean up resources properly
3. **Monitor Memory Usage**: Monitor memory usage and garbage collection
4. **Use Weak References**: Use weak references for caches

**Monitoring and Alerting**

1. **Set Up Monitoring**: Set up comprehensive monitoring
2. **Define Alerts**: Define alerts for performance issues
3. **Track Metrics**: Track key performance metrics
4. **Regular Reviews**: Regularly review performance data

For more information about related components, see:

- :doc:`database_schema` - Database structure and models
- :doc:`configuration_guide` - Configuration management
- :doc:`testing_guide` - Testing strategies and procedures 