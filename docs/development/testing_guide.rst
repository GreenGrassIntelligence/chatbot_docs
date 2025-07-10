Testing Guide
============

This guide provides comprehensive information about testing strategies, procedures, and best practices for the e-commerce chatbot system.

Overview
--------

The e-commerce chatbot implements a comprehensive testing strategy covering unit tests, integration tests, performance tests, and end-to-end validation.

**Testing Framework**: pytest
**Location**: `tests/`

**Test Categories**:
- Unit Tests
- Integration Tests
- Performance Tests
- Validation Tests
- End-to-End Tests

Unit Testing
------------

**Test Structure**

Unit tests are organized by module and follow a clear naming convention:

.. code-block:: python

   # tests/test_search_engine.py
   import pytest
   from src.search.search_engine import SearchEngine
   from src.config.unified_config import get_config

   class TestSearchEngine:
       @pytest.fixture
       def search_engine(self):
           """Create search engine instance for testing"""
           config = get_config()
           return SearchEngine(config)

       def test_fuzzy_matching(self, search_engine):
           """Test fuzzy matching functionality"""
           query = "laptp"  # Typo for "laptop"
           results = search_engine.fuzzy_search(query)
           
           assert len(results) > 0
           assert any("laptop" in result.name.lower() for result in results)

       def test_phonetic_matching(self, search_engine):
           """Test phonetic matching functionality"""
           query = "labtop"  # Phonetic variation of "laptop"
           results = search_engine.phonetic_search(query)
           
           assert len(results) > 0
           assert any("laptop" in result.name.lower() for result in results)

       def test_partial_matching(self, search_engine):
           """Test partial matching functionality"""
           query = "lap"  # Partial word
           results = search_engine.partial_search(query)
           
           assert len(results) > 0
           assert all("lap" in result.name.lower() for result in results)

**Test Configuration**

.. code-block:: python

   # tests/conftest.py
   import pytest
   import asyncio
   from src.config.unified_config import AppConfig
   from src.database.database_manager import DatabaseManager

   @pytest.fixture(scope="session")
   def event_loop():
       """Create event loop for async tests"""
       loop = asyncio.get_event_loop_policy().new_event_loop()
       yield loop
       loop.close()

   @pytest.fixture
   def test_config():
       """Create test configuration"""
       return AppConfig(
           database=DatabaseConfig(
               url="postgresql://test_user:test_pass@localhost:5432/test_db"
           ),
           features=FeatureConfig(
               fuzzy_matching=True,
               phonetic_matching=True,
               partial_matching=True,
               analytics=False
           )
       )

   @pytest.fixture
   async def test_db():
       """Create test database connection"""
       db = DatabaseManager()
       await db.initialize()
       yield db
       await db.close()

**Mocking and Stubbing**

.. code-block:: python

   from unittest.mock import Mock, patch
   import pytest

   class TestLLMIntegration:
       @patch('src.llm.enhanced_llm_core.OpenAI')
       def test_llm_response(self, mock_openai):
           """Test LLM integration with mocked API"""
           # Setup mock
           mock_client = Mock()
           mock_openai.return_value = mock_client
           mock_client.chat.completions.create.return_value = Mock(
               choices=[Mock(message=Mock(content='{"intent": "search", "entities": []}'))]
           )
           
           # Test
           llm = EnhancedLLMCore()
           response = llm.extract_intent("Show me laptops")
           
           assert response['intent'] == 'search'
           mock_client.chat.completions.create.assert_called_once()

Integration Testing
------------------

**Database Integration Tests**

.. code-block:: python

   # tests/integration/test_database.py
   import pytest
   from src.database.database_manager import DatabaseManager
   from src.models.data_models import Product

   class TestDatabaseIntegration:
       @pytest.fixture
       async def db_manager(self):
           """Create database manager for testing"""
           db = DatabaseManager()
           await db.initialize()
           yield db
           await db.close()

       async def test_product_crud(self, db_manager):
           """Test product create, read, update, delete operations"""
           # Create product
           product_data = {
               'name': 'Test Laptop',
               'price': 999.99,
               'category_id': 1,
               'sku': 'TEST001'
           }
           
           product_id = await db_manager.execute(
               "INSERT INTO products (name, price, category_id, sku) VALUES ($1, $2, $3, $4) RETURNING id",
               product_data['name'], product_data['price'], product_data['category_id'], product_data['sku']
           )
           
           # Read product
           product = await db_manager.fetchrow(
               "SELECT * FROM products WHERE id = $1",
               product_id
           )
           
           assert product['name'] == product_data['name']
           assert float(product['price']) == product_data['price']
           
           # Update product
           await db_manager.execute(
               "UPDATE products SET price = $1 WHERE id = $2",
               899.99, product_id
           )
           
           updated_product = await db_manager.fetchrow(
               "SELECT * FROM products WHERE id = $1",
               product_id
           )
           
           assert float(updated_product['price']) == 899.99
           
           # Delete product
           await db_manager.execute(
               "DELETE FROM products WHERE id = $1",
               product_id
           )
           
           deleted_product = await db_manager.fetchrow(
               "SELECT * FROM products WHERE id = $1",
               product_id
           )
           
           assert deleted_product is None

**Search Engine Integration Tests**

.. code-block:: python

   # tests/integration/test_search_integration.py
   import pytest
   from src.search.search_engine import SearchEngine
   from src.database.database_manager import DatabaseManager

   class TestSearchIntegration:
       @pytest.fixture
       async def search_engine(self, test_db):
           """Create search engine with database integration"""
           return SearchEngine(test_db)

       async def test_search_with_database(self, search_engine):
           """Test search functionality with real database"""
           # Search for products
           results = await search_engine.search("laptop")
           
           assert len(results) > 0
           assert all(hasattr(result, 'name') for result in results)
           assert all(hasattr(result, 'price') for result in results)

       async def test_fuzzy_search_integration(self, search_engine):
           """Test fuzzy search with database"""
           results = await search_engine.fuzzy_search("laptp")
           
           assert len(results) > 0
           # Verify results contain laptops despite typo

**Session Management Integration Tests**

.. code-block:: python

   # tests/integration/test_session_integration.py
   import pytest
   from src.session.session_manager import SessionManager
   from src.database.database_manager import DatabaseManager

   class TestSessionIntegration:
       @pytest.fixture
       async def session_manager(self, test_db):
           """Create session manager for testing"""
           return SessionManager(test_db)

       async def test_session_creation_and_retrieval(self, session_manager):
           """Test session creation and retrieval"""
           # Create session
           session_id = await session_manager.create_session("test_user")
           
           # Store data
           await session_manager.update_conversation_context(session_id, {
               'current_intent': 'search',
               'search_query': 'laptops'
           })
           
           # Retrieve session
           session_data = await session_manager.get_session(session_id)
           
           assert session_data is not None
           assert session_data['current_intent'] == 'search'
           assert session_data['search_query'] == 'laptops'

Performance Testing
------------------

**Load Testing**

.. code-block:: python

   # tests/performance/test_load.py
   import asyncio
   import time
   import pytest
   from src.main import app
   from httpx import AsyncClient

   class TestLoadPerformance:
       @pytest.mark.asyncio
       async def test_concurrent_requests(self):
           """Test system performance under concurrent load"""
           async with AsyncClient(app=app, base_url="http://test") as client:
               # Create concurrent requests
               tasks = []
               for i in range(100):
                   task = client.post("/chat", json={
                       "message": f"Show me laptop {i}",
                       "session_id": f"session_{i}"
                   })
                   tasks.append(task)
               
               # Execute concurrent requests
               start_time = time.time()
               responses = await asyncio.gather(*tasks)
               end_time = time.time()
               
               # Verify all requests succeeded
               assert all(response.status_code == 200 for response in responses)
               
               # Check performance
               total_time = end_time - start_time
               avg_time = total_time / len(responses)
               
               assert avg_time < 1.0  # Average response time under 1 second
               assert total_time < 30.0  # Total time under 30 seconds

**Database Performance Tests**

.. code-block:: python

   # tests/performance/test_database_performance.py
   import pytest
   import time
   from src.database.database_manager import DatabaseManager

   class TestDatabasePerformance:
       @pytest.fixture
       async def db_manager(self):
           """Create database manager for performance testing"""
           db = DatabaseManager()
           await db.initialize()
           yield db
           await db.close()

       async def test_query_performance(self, db_manager):
           """Test database query performance"""
           # Test search query performance
           start_time = time.time()
           
           for i in range(100):
               await db_manager.fetch(
                   "SELECT * FROM products WHERE name ILIKE $1 LIMIT 10",
                   f"%laptop%"
               )
           
           end_time = time.time()
           avg_query_time = (end_time - start_time) / 100
           
           assert avg_query_time < 0.1  # Average query time under 100ms

       async def test_connection_pool_performance(self, db_manager):
           """Test connection pool performance"""
           # Test concurrent database operations
           async def db_operation():
               return await db_manager.fetch("SELECT 1")
           
           tasks = [db_operation() for _ in range(50)]
           start_time = time.time()
           
           results = await asyncio.gather(*tasks)
           end_time = time.time()
           
           assert len(results) == 50
           assert (end_time - start_time) < 5.0  # All operations complete under 5 seconds

Validation Testing
-----------------

**End-to-End Validation**

.. code-block:: python

   # tests/validation/test_e2e_validation.py
   import pytest
   from src.main import app
   from httpx import AsyncClient

   class TestEndToEndValidation:
       @pytest.mark.asyncio
       async def test_complete_shopping_flow(self):
           """Test complete shopping flow from search to cart"""
           async with AsyncClient(app=app, base_url="http://test") as client:
               session_id = "test_session_123"
               
               # Step 1: Search for products
               search_response = await client.post("/chat", json={
                   "message": "Show me laptops under $1000",
                   "session_id": session_id
               })
               
               assert search_response.status_code == 200
               search_data = search_response.json()
               assert "laptops" in search_data['response'].lower()
               
               # Step 2: Add item to cart
               cart_response = await client.post("/chat", json={
                   "message": "Add the first laptop to my cart",
                   "session_id": session_id
               })
               
               assert cart_response.status_code == 200
               cart_data = cart_response.json()
               assert "added" in cart_data['response'].lower()
               
               # Step 3: View cart
               view_cart_response = await client.post("/chat", json={
                   "message": "Show me my cart",
                   "session_id": session_id
               })
               
               assert view_cart_response.status_code == 200
               cart_view_data = view_cart_response.json()
               assert "cart" in cart_view_data['response'].lower()

**Feature Validation Tests**

.. code-block:: python

   # tests/validation/test_feature_validation.py
   import pytest
   from src.search.search_engine import SearchEngine
   from src.config.unified_config import get_config

   class TestFeatureValidation:
       @pytest.fixture
       def search_engine(self):
           """Create search engine for feature validation"""
           config = get_config()
           return SearchEngine(config)

       def test_fuzzy_matching_validation(self, search_engine):
           """Validate fuzzy matching with known test cases"""
           test_cases = [
               ("laptp", "laptop"),  # Typo
               ("labtop", "laptop"),  # Phonetic variation
               ("phon", "phone"),     # Partial word
               ("macbok", "macbook"), # Brand typo
           ]
           
           for query, expected in test_cases:
               results = search_engine.fuzzy_search(query)
               assert len(results) > 0
               # Verify that expected results are found

       def test_phonetic_matching_validation(self, search_engine):
           """Validate phonetic matching with known test cases"""
           test_cases = [
               ("labtop", "laptop"),
               ("fone", "phone"),
               ("macbok", "macbook"),
           ]
           
           for query, expected in test_cases:
               results = search_engine.phonetic_search(query)
               assert len(results) > 0

**Configuration Validation Tests**

.. code-block:: python

   # tests/validation/test_config_validation.py
   import pytest
   from src.config.unified_config import validate_config, ConfigurationError

   class TestConfigurationValidation:
       def test_valid_configuration(self):
           """Test that valid configuration passes validation"""
           config = get_config()
           validate_config(config)  # Should not raise exception

       def test_invalid_fuzzy_threshold(self):
           """Test validation of fuzzy threshold values"""
           config = get_config()
           config.search.fuzzy_threshold = 1.5  # Invalid value
           
           with pytest.raises(ConfigurationError):
               validate_config(config)

       def test_missing_required_settings(self):
           """Test validation of required settings"""
           config = get_config()
           config.llm.api_key = None  # Missing required setting
           
           with pytest.raises(ConfigurationError):
               validate_config(config)

Test Data Management
-------------------

**Test Data Setup**

.. code-block:: python

   # tests/data/test_data_setup.py
   import pytest
   from src.database.database_manager import DatabaseManager

   class TestDataSetup:
       @pytest.fixture
       async def setup_test_data(self, test_db):
           """Setup test data for all tests"""
           # Create test categories
           await test_db.execute(
               "INSERT INTO categories (name, slug) VALUES ($1, $2)",
               "Electronics", "electronics"
           )
           
           # Create test products
           await test_db.execute("""
               INSERT INTO products (name, price, category_id, sku, stock_quantity)
               VALUES ($1, $2, $3, $4, $5)
           """, "Test Laptop", 999.99, 1, "TEST001", 10)
           
           await test_db.execute("""
               INSERT INTO products (name, price, category_id, sku, stock_quantity)
               VALUES ($1, $2, $3, $4, $5)
           """, "Test Phone", 599.99, 1, "TEST002", 15)
           
           yield
           
           # Cleanup test data
           await test_db.execute("DELETE FROM products WHERE sku LIKE 'TEST%'")
           await test_db.execute("DELETE FROM categories WHERE name = 'Electronics'")

**Sample Data Loading**

.. code-block:: python

   # tests/data/load_test_data.py
   import json
   import pytest
   from src.database.database_manager import DatabaseManager

   def load_sample_products():
       """Load sample products from JSON file"""
       with open('tests/data/sample_products.json', 'r') as f:
           return json.load(f)

   @pytest.fixture
   async def load_sample_data(self, test_db):
       """Load sample data for testing"""
       products = load_sample_products()
       
       for product in products:
           await test_db.execute("""
               INSERT INTO products (name, price, category_id, sku, stock_quantity)
               VALUES ($1, $2, $3, $4, $5)
           """, product['name'], product['price'], product['category_id'], 
                product['sku'], product['stock_quantity'])
       
       yield
       
       # Cleanup
       await test_db.execute("DELETE FROM products WHERE sku LIKE 'SAMPLE%'")

Test Execution
--------------

**Running Tests**

.. code-block:: bash

   # Run all tests
   pytest tests/

   # Run specific test category
   pytest tests/unit/
   pytest tests/integration/
   pytest tests/performance/
   pytest tests/validation/

   # Run specific test file
   pytest tests/unit/test_search_engine.py

   # Run with coverage
   pytest --cov=src tests/

   # Run with verbose output
   pytest -v tests/

   # Run with parallel execution
   pytest -n auto tests/

**Test Configuration**

.. code-block:: ini

   # pytest.ini
   [tool:pytest]
   testpaths = tests
   python_files = test_*.py
   python_classes = Test*
   python_functions = test_*
   addopts = 
       --strict-markers
       --strict-config
       --verbose
       --tb=short
   markers =
       unit: Unit tests
       integration: Integration tests
       performance: Performance tests
       validation: Validation tests
       slow: Slow running tests

**Continuous Integration**

.. code-block:: yaml

   # .github/workflows/test.yml
   name: Tests
   on: [push, pull_request]
   
   jobs:
     test:
       runs-on: ubuntu-latest
       services:
         postgres:
           image: postgres:12
           env:
             POSTGRES_PASSWORD: test_pass
             POSTGRES_USER: test_user
             POSTGRES_DB: test_db
           options: >-
             --health-cmd pg_isready
             --health-interval 10s
             --health-timeout 5s
             --health-retries 5
       
       steps:
       - uses: actions/checkout@v2
       
       - name: Set up Python
         uses: actions/setup-python@v2
         with:
           python-version: 3.9
       
       - name: Install dependencies
         run: |
           pip install -r requirements.txt
           pip install pytest pytest-asyncio pytest-cov
       
       - name: Run tests
         run: |
           pytest --cov=src --cov-report=xml tests/
       
       - name: Upload coverage
         uses: codecov/codecov-action@v1

Test Best Practices
------------------

**Test Organization**

1. **Clear Naming**: Use descriptive test names that explain what is being tested
2. **Arrange-Act-Assert**: Structure tests with clear setup, execution, and verification
3. **Single Responsibility**: Each test should verify one specific behavior
4. **Independence**: Tests should not depend on each other

**Test Data Management**

1. **Use Fixtures**: Create reusable test data with pytest fixtures
2. **Cleanup**: Always clean up test data to avoid interference
3. **Isolation**: Use separate test databases or transactions
4. **Realistic Data**: Use realistic test data that matches production

**Performance Considerations**

1. **Mock External Services**: Mock API calls and external dependencies
2. **Use Test Databases**: Use separate test databases for integration tests
3. **Optimize Setup**: Minimize setup time for frequently run tests
4. **Parallel Execution**: Use pytest-xdist for parallel test execution

**Coverage and Quality**

1. **Aim for High Coverage**: Target 80%+ code coverage
2. **Test Edge Cases**: Include tests for error conditions and edge cases
3. **Test Configuration**: Test different configuration combinations
4. **Test Documentation**: Keep tests as documentation for code behavior

For more information about related components, see:

- :doc:`configuration_guide` - Configuration management
- :doc:`database_schema` - Database structure and models
- :doc:`performance_optimization` - Performance tuning 