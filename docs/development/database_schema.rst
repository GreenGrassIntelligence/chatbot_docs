Database Schema
==============

This document provides detailed information about the database schema, including table structures, relationships, and data models for the e-commerce chatbot.

Overview
--------

The e-commerce chatbot uses PostgreSQL as its primary database with a well-designed schema that supports all core functionalities including products, users, orders, sessions, and analytics.

**Database**: PostgreSQL 12+
**Location**: `src/database/` and `src/models/`

**Key Features**:
- Normalized schema design
- Proper indexing for performance
- Foreign key relationships
- Audit trails and timestamps
- Soft deletes for data integrity

Core Tables
-----------

**Products Table**

.. code-block:: sql

   CREATE TABLE products (
       id SERIAL PRIMARY KEY,
       name VARCHAR(255) NOT NULL,
       description TEXT,
       price DECIMAL(10,2) NOT NULL,
       category_id INTEGER REFERENCES categories(id),
       brand VARCHAR(100),
       sku VARCHAR(100) UNIQUE,
       stock_quantity INTEGER DEFAULT 0,
       image_url VARCHAR(500),
       specifications JSONB,
       is_active BOOLEAN DEFAULT true,
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );

**Categories Table**

.. code-block:: sql

   CREATE TABLE categories (
       id SERIAL PRIMARY KEY,
       name VARCHAR(100) NOT NULL,
       description TEXT,
       parent_id INTEGER REFERENCES categories(id),
       slug VARCHAR(100) UNIQUE,
       is_active BOOLEAN DEFAULT true,
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );

**Users Table**

.. code-block:: sql

   CREATE TABLE users (
       id SERIAL PRIMARY KEY,
       username VARCHAR(100) UNIQUE NOT NULL,
       email VARCHAR(255) UNIQUE NOT NULL,
       password_hash VARCHAR(255) NOT NULL,
       first_name VARCHAR(100),
       last_name VARCHAR(100),
       phone VARCHAR(20),
       is_active BOOLEAN DEFAULT true,
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );

**Orders Table**

.. code-block:: sql

   CREATE TABLE orders (
       id SERIAL PRIMARY KEY,
       user_id INTEGER REFERENCES users(id),
       order_number VARCHAR(50) UNIQUE NOT NULL,
       status VARCHAR(50) DEFAULT 'pending',
       total_amount DECIMAL(10,2) NOT NULL,
       tax_amount DECIMAL(10,2) DEFAULT 0,
       shipping_address JSONB,
       billing_address JSONB,
       payment_method VARCHAR(50),
       payment_status VARCHAR(50) DEFAULT 'pending',
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );

**Order Items Table**

.. code-block:: sql

   CREATE TABLE order_items (
       id SERIAL PRIMARY KEY,
       order_id INTEGER REFERENCES orders(id) ON DELETE CASCADE,
       product_id INTEGER REFERENCES products(id),
       quantity INTEGER NOT NULL,
       unit_price DECIMAL(10,2) NOT NULL,
       total_price DECIMAL(10,2) NOT NULL,
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );

**Sessions Table**

.. code-block:: sql

   CREATE TABLE sessions (
       id SERIAL PRIMARY KEY,
       session_id VARCHAR(255) UNIQUE NOT NULL,
       user_id INTEGER REFERENCES users(id),
       data JSONB,
       expires_at TIMESTAMP NOT NULL,
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );

**Cart Items Table**

.. code-block:: sql

   CREATE TABLE cart_items (
       id SERIAL PRIMARY KEY,
       session_id VARCHAR(255) NOT NULL,
       product_id INTEGER REFERENCES products(id),
       quantity INTEGER NOT NULL DEFAULT 1,
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );

**Analytics Table**

.. code-block:: sql

   CREATE TABLE analytics (
       id SERIAL PRIMARY KEY,
       event_type VARCHAR(100) NOT NULL,
       user_id INTEGER REFERENCES users(id),
       session_id VARCHAR(255),
       data JSONB,
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );

**Search Logs Table**

.. code-block:: sql

   CREATE TABLE search_logs (
       id SERIAL PRIMARY KEY,
       query TEXT NOT NULL,
       user_id INTEGER REFERENCES users(id),
       session_id VARCHAR(255),
       results_count INTEGER,
       search_type VARCHAR(50),
       response_time_ms INTEGER,
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );

Data Models
-----------

**Product Model**

.. code-block:: python

   from dataclasses import dataclass
   from datetime import datetime
   from typing import Optional, Dict, Any
   from decimal import Decimal

   @dataclass
   class Product:
       id: int
       name: str
       description: Optional[str]
       price: Decimal
       category_id: Optional[int]
       brand: Optional[str]
       sku: str
       stock_quantity: int
       image_url: Optional[str]
       specifications: Dict[str, Any]
       is_active: bool
       created_at: datetime
       updated_at: datetime

**Category Model**

.. code-block:: python

   @dataclass
   class Category:
       id: int
       name: str
       description: Optional[str]
       parent_id: Optional[int]
       slug: str
       is_active: bool
       created_at: datetime
       updated_at: datetime

**User Model**

.. code-block:: python

   @dataclass
   class User:
       id: int
       username: str
       email: str
       password_hash: str
       first_name: Optional[str]
       last_name: Optional[str]
       phone: Optional[str]
       is_active: bool
       created_at: datetime
       updated_at: datetime

**Order Model**

.. code-block:: python

   @dataclass
   class Order:
       id: int
       user_id: int
       order_number: str
       status: str
       total_amount: Decimal
       tax_amount: Decimal
       shipping_address: Dict[str, Any]
       billing_address: Dict[str, Any]
       payment_method: Optional[str]
       payment_status: str
       created_at: datetime
       updated_at: datetime

**Session Model**

.. code-block:: python

   @dataclass
   class Session:
       id: int
       session_id: str
       user_id: Optional[int]
       data: Dict[str, Any]
       expires_at: datetime
       created_at: datetime
       updated_at: datetime

Database Relationships
---------------------

**One-to-Many Relationships**

**Categories to Products**
   - One category can have many products
   - Products reference category_id

**Users to Orders**
   - One user can have many orders
   - Orders reference user_id

**Orders to Order Items**
   - One order can have many order items
   - Order items reference order_id

**Many-to-One Relationships**

**Products to Categories**
   - Many products can belong to one category
   - Products have category_id foreign key

**Order Items to Products**
   - Many order items can reference one product
   - Order items have product_id foreign key

**Self-Referencing Relationships**

**Categories Hierarchy**
   - Categories can have parent categories
   - Self-referencing parent_id foreign key

**Example Queries**

.. code-block:: sql

   -- Get products with category information
   SELECT p.*, c.name as category_name
   FROM products p
   LEFT JOIN categories c ON p.category_id = c.id
   WHERE p.is_active = true;

   -- Get order with items and product details
   SELECT o.*, oi.*, p.name as product_name
   FROM orders o
   JOIN order_items oi ON o.id = oi.order_id
   JOIN products p ON oi.product_id = p.id
   WHERE o.user_id = $1;

   -- Get category hierarchy
   WITH RECURSIVE category_tree AS (
       SELECT id, name, parent_id, 1 as level
       FROM categories
       WHERE parent_id IS NULL
       UNION ALL
       SELECT c.id, c.name, c.parent_id, ct.level + 1
       FROM categories c
       JOIN category_tree ct ON c.parent_id = ct.id
   )
   SELECT * FROM category_tree;

Indexes
-------

**Primary Indexes**

All tables have primary key indexes on their `id` columns.

**Foreign Key Indexes**

.. code-block:: sql

   -- Products table indexes
   CREATE INDEX idx_products_category_id ON products(category_id);
   CREATE INDEX idx_products_brand ON products(brand);
   CREATE INDEX idx_products_sku ON products(sku);
   CREATE INDEX idx_products_is_active ON products(is_active);

   -- Orders table indexes
   CREATE INDEX idx_orders_user_id ON orders(user_id);
   CREATE INDEX idx_orders_status ON orders(status);
   CREATE INDEX idx_orders_created_at ON orders(created_at);

   -- Order items table indexes
   CREATE INDEX idx_order_items_order_id ON order_items(order_id);
   CREATE INDEX idx_order_items_product_id ON order_items(product_id);

   -- Sessions table indexes
   CREATE INDEX idx_sessions_session_id ON sessions(session_id);
   CREATE INDEX idx_sessions_user_id ON sessions(user_id);
   CREATE INDEX idx_sessions_expires_at ON sessions(expires_at);

   -- Cart items table indexes
   CREATE INDEX idx_cart_items_session_id ON cart_items(session_id);
   CREATE INDEX idx_cart_items_product_id ON cart_items(product_id);

   -- Analytics table indexes
   CREATE INDEX idx_analytics_event_type ON analytics(event_type);
   CREATE INDEX idx_analytics_user_id ON analytics(user_id);
   CREATE INDEX idx_analytics_created_at ON analytics(created_at);

   -- Search logs table indexes
   CREATE INDEX idx_search_logs_user_id ON search_logs(user_id);
   CREATE INDEX idx_search_logs_created_at ON search_logs(created_at);
   CREATE INDEX idx_search_logs_search_type ON search_logs(search_type);

**Composite Indexes**

.. code-block:: sql

   -- Products search index
   CREATE INDEX idx_products_search ON products(name, category_id, brand, is_active);

   -- Orders user status index
   CREATE INDEX idx_orders_user_status ON orders(user_id, status);

   -- Analytics event user index
   CREATE INDEX idx_analytics_event_user ON analytics(event_type, user_id, created_at);

**Full-Text Search Indexes**

.. code-block:: sql

   -- Products full-text search
   CREATE INDEX idx_products_fts ON products USING gin(to_tsvector('english', name || ' ' || COALESCE(description, '')));

   -- Categories full-text search
   CREATE INDEX idx_categories_fts ON categories USING gin(to_tsvector('english', name || ' ' || COALESCE(description, '')));

Database Manager
----------------

**Connection Management**

.. code-block:: python

   from src.database.database_manager import DatabaseManager

   class DatabaseManager:
       def __init__(self):
           self.pool = None
           self.config = get_config().database

       async def initialize(self):
           """Initialize database connection pool"""
           self.pool = await asyncpg.create_pool(
               self.config.url,
               min_size=self.config.pool_size,
               max_size=self.config.max_size,
               command_timeout=self.config.command_timeout
           )

       async def close(self):
           """Close database connection pool"""
           if self.pool:
               await self.pool.close()

**Query Execution**

.. code-block:: python

       async def fetch(self, query: str, *args):
           """Execute SELECT query and return results"""
           async with self.pool.acquire() as conn:
               return await conn.fetch(query, *args)

       async def fetchrow(self, query: str, *args):
           """Execute SELECT query and return single row"""
           async with self.pool.acquire() as conn:
               return await conn.fetchrow(query, *args)

       async def execute(self, query: str, *args):
           """Execute INSERT/UPDATE/DELETE query"""
           async with self.pool.acquire() as conn:
               return await conn.execute(query, *args)

       async def execute_transaction(self, queries: List[Tuple[str, List]]):
           """Execute multiple queries in a transaction"""
           async with self.pool.acquire() as conn:
               async with conn.transaction():
                   for query, args in queries:
                       await conn.execute(query, *args)

Data Access Layer
-----------------

**Product Manager**

.. code-block:: python

   class ProductManager:
       def __init__(self, db_manager: DatabaseManager):
           self.db = db_manager

       async def get_product(self, product_id: int) -> Optional[Product]:
           """Get product by ID"""
           query = "SELECT * FROM products WHERE id = $1 AND is_active = true"
           row = await self.db.fetchrow(query, product_id)
           return Product(**row) if row else None

       async def search_products(self, query: str, filters: Dict = None) -> List[Product]:
           """Search products with filters"""
           sql = "SELECT * FROM products WHERE is_active = true"
           params = []
           
           if query:
               sql += " AND to_tsvector('english', name || ' ' || COALESCE(description, '')) @@ plainto_tsquery('english', $1)"
               params.append(query)
           
           if filters:
               if filters.get('category_id'):
                   sql += f" AND category_id = ${len(params) + 1}"
                   params.append(filters['category_id'])
               
               if filters.get('min_price'):
                   sql += f" AND price >= ${len(params) + 1}"
                   params.append(filters['min_price'])
               
               if filters.get('max_price'):
                   sql += f" AND price <= ${len(params) + 1}"
                   params.append(filters['max_price'])
           
           rows = await self.db.fetch(sql, *params)
           return [Product(**row) for row in rows]

**Cart Manager**

.. code-block:: python

   class CartManager:
       def __init__(self, db_manager: DatabaseManager):
           self.db = db_manager

       async def add_to_cart(self, session_id: str, product_id: int, quantity: int = 1):
           """Add item to cart"""
           # Check if item already exists
           existing = await self.db.fetchrow(
               "SELECT * FROM cart_items WHERE session_id = $1 AND product_id = $2",
               session_id, product_id
           )
           
           if existing:
               # Update quantity
               await self.db.execute(
                   "UPDATE cart_items SET quantity = quantity + $1, updated_at = NOW() WHERE id = $2",
                   quantity, existing['id']
               )
           else:
               # Add new item
               await self.db.execute(
                   "INSERT INTO cart_items (session_id, product_id, quantity) VALUES ($1, $2, $3)",
                   session_id, product_id, quantity
               )

       async def get_cart(self, session_id: str) -> List[Dict]:
           """Get cart contents with product details"""
           query = """
               SELECT ci.*, p.name, p.price, p.image_url
               FROM cart_items ci
               JOIN products p ON ci.product_id = p.id
               WHERE ci.session_id = $1
           """
           return await self.db.fetch(query, session_id)

**Order Manager**

.. code-block:: python

   class OrderManager:
       def __init__(self, db_manager: DatabaseManager):
           self.db = db_manager

       async def create_order(self, user_id: int, cart_items: List[Dict]) -> Order:
           """Create new order from cart items"""
           async with self.db.pool.acquire() as conn:
               async with conn.transaction():
                   # Create order
                   order_number = self.generate_order_number()
                   order_query = """
                       INSERT INTO orders (user_id, order_number, total_amount)
                       VALUES ($1, $2, $3) RETURNING *
                   """
                   total_amount = sum(item['price'] * item['quantity'] for item in cart_items)
                   order_row = await conn.fetchrow(order_query, user_id, order_number, total_amount)
                   
                   # Create order items
                   for item in cart_items:
                       await conn.execute(
                           "INSERT INTO order_items (order_id, product_id, quantity, unit_price, total_price) VALUES ($1, $2, $3, $4, $5)",
                           order_row['id'], item['product_id'], item['quantity'], item['price'], item['price'] * item['quantity']
                       )
                   
                   return Order(**order_row)

Migration System
----------------

**Migration Files**

Migrations are stored in `src/models/migrations/` and follow a versioned naming convention:

.. code-block:: sql

   -- 001_initial_schema.sql
   CREATE TABLE products (
       id SERIAL PRIMARY KEY,
       name VARCHAR(255) NOT NULL,
       -- ... other columns
   );

   -- 002_add_categories.sql
   CREATE TABLE categories (
       id SERIAL PRIMARY KEY,
       name VARCHAR(100) NOT NULL,
       -- ... other columns
   );

   -- 003_add_foreign_keys.sql
   ALTER TABLE products ADD CONSTRAINT fk_products_category 
       FOREIGN KEY (category_id) REFERENCES categories(id);

**Migration Manager**

.. code-block:: python

   class MigrationManager:
       def __init__(self, db_manager: DatabaseManager):
           self.db = db_manager

       async def create_migrations_table(self):
           """Create migrations tracking table"""
           await self.db.execute("""
               CREATE TABLE IF NOT EXISTS migrations (
                   id SERIAL PRIMARY KEY,
                   version VARCHAR(50) UNIQUE NOT NULL,
                   applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
               )
           """)

       async def get_applied_migrations(self) -> List[str]:
           """Get list of applied migrations"""
           rows = await self.db.fetch("SELECT version FROM migrations ORDER BY version")
           return [row['version'] for row in rows]

       async def apply_migration(self, version: str, sql: str):
           """Apply a migration"""
           await self.db.execute(sql)
           await self.db.execute(
               "INSERT INTO migrations (version) VALUES ($1)",
               version
           )

       async def run_migrations(self):
           """Run all pending migrations"""
           await self.create_migrations_table()
           applied = await self.get_applied_migrations()
           
           # Get all migration files
           migration_files = self.get_migration_files()
           
           for migration_file in migration_files:
               version = migration_file.split('_')[0]
               if version not in applied:
                   sql = self.read_migration_file(migration_file)
                   await self.apply_migration(version, sql)

Performance Optimization
-----------------------

**Query Optimization**

1. **Use Indexes**: Ensure proper indexes on frequently queried columns
2. **Limit Results**: Use LIMIT clauses to prevent large result sets
3. **Avoid N+1 Queries**: Use JOINs and batch queries
4. **Use Prepared Statements**: Reuse query plans

**Connection Pooling**

.. code-block:: python

   # Configure connection pool
   pool_config = {
       'min_size': 5,
       'max_size': 20,
       'command_timeout': 30,
       'server_settings': {
           'application_name': 'chatbot_app'
       }
   }

**Caching Strategy**

1. **Query Result Caching**: Cache frequently accessed data
2. **Connection Pooling**: Reuse database connections
3. **Read Replicas**: Use read replicas for heavy read workloads

**Monitoring and Analytics**

.. code-block:: sql

   -- Monitor slow queries
   SELECT query, mean_time, calls
   FROM pg_stat_statements
   ORDER BY mean_time DESC
   LIMIT 10;

   -- Monitor table sizes
   SELECT schemaname, tablename, pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as size
   FROM pg_tables
   WHERE schemaname = 'public'
   ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;

For more information about related components, see:

- :doc:`configuration_guide` - Configuration management
- :doc:`testing_guide` - Testing strategies and procedures
- :doc:`performance_optimization` - Performance tuning 