E-commerce Chatbot Validation & Testing Guide
============================================

This comprehensive guide explains how to validate, test, and benchmark the e-commerce chatbot system. It covers everything from basic functionality testing to advanced performance benchmarking and stress testing.

Quick Start
-----------

Setup Testing Environment
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

    # Install dependencies
    pip install -r requirements.txt

    # Setup environment
    cp env.example .env
    # Edit .env with your API keys

    # Load test data
    python tests/data/load_test_data.py

    # Run basic tests
    python run_tests.py

    # Run full validation suite
    python run_validation.py

Test Structure
--------------

.. code-block:: text

    tests/
    ├── __init__.py
    ├── data/
    │   ├── sample_products.json          # Sample product data
    │   ├── test_conversations.json       # Test conversation scenarios
    │   ├── performance_benchmarks.json   # Performance benchmarks
    │   └── load_test_data.py            # Data loader script
    ├── validation/
    │   ├── __init__.py
    │   └── test_validator.py            # Main validation engine
    └── benchmarking/
        ├── __init__.py
        └── performance_benchmark.py     # Performance testing

Test Data Overview
-----------------

Sample Products
~~~~~~~~~~~~~~~

Located in ``tests/data/sample_products.json``, contains 8 realistic e-commerce products:

.. code-block:: json

    {
      "product_id": 1,
      "name": "Amul Pure Ghee 1L",
      "description": "Pure cow ghee made from fresh cream...",
      "mrp": 550.00,
      "selling_price": 495.00,
      "stock_quantity": 50,
      "tags": ["ghee", "cooking", "pure", "cow", "indian"]
    }

**Product Categories:**
* Dairy Products (Milk, Ghee, Butter)
* Groceries (Rice, Sugar, Flour)
* Vegetables (Tomatoes, Onions)
* Organic Products (Organic variants)

Test Conversations
~~~~~~~~~~~~~~~~~

Located in ``tests/data/test_conversations.json``, contains 8 conversation scenarios:

1. **Product Information Query** - Basic product information requests
2. **Product Comparison** - Side-by-side product comparisons
3. **Cart Management** - Add, remove, update cart operations
4. **Incomplete Query Handling** - Missing information detection
5. **Order History and Status** - Order tracking and history
6. **Stock Inquiries** - Availability checking
7. **Complex Multi-Intent Queries** - Multiple requests in one message
8. **Help and Support** - General customer service queries

Example Test Conversation:

.. code-block:: json

    {
      "conversation_id": "conv_001",
      "scenario": "Product Information Query",
      "messages": [
        {
          "user_message": "Tell me about Amul ghee",
          "expected_intent": "product_info",
          "expected_confidence": 0.90,
          "expected_entities": [
            {
              "type": "product",
              "value": "Amul ghee",
              "confidence": 0.85
            }
          ],
          "expected_response_contains": ["Amul", "ghee", "price", "description"]
        }
      ]
    }

Performance Benchmarks
~~~~~~~~~~~~~~~~~~~~~

Located in ``tests/data/performance_benchmarks.json``, defines performance expectations:

.. code-block:: json

    {
      "response_time_limits": {
        "p50": 1000,
        "p90": 2000,
        "p95": 3000,
        "p99": 5000
      },
      "cost_limits": {
        "per_interaction": 0.01,
        "per_user_session": 0.10,
        "per_day": 1.00
      },
      "accuracy_benchmarks": {
        "intent_detection": 0.95,
        "entity_extraction": 0.90,
        "multi_intent_success": 0.85
      }
    }

Running Tests
-------------

Basic Functionality Tests
~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

    # Run simple functionality tests
    python run_tests.py

    # Run with verbose output
    python run_tests.py --verbose

    # Run specific test categories
    python run_tests.py --category intent_detection
    python run_tests.py --category entity_extraction
    python run_tests.py --category cart_operations

Comprehensive Validation
~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

    # Run full validation suite
    python run_validation.py

    # Run only tests (skip benchmarks)
    python run_validation.py --tests-only

    # Run only benchmarks (skip tests)
    python run_validation.py --benchmarks-only

    # Save results to file
    python run_validation.py --output results.json

    # Run with custom configuration
    python run_validation.py --config custom_config.json

Test Categories
--------------

Intent Detection Tests
~~~~~~~~~~~~~~~~~~~~~

Tests the chatbot's ability to correctly identify user intents:

.. code-block:: text

    Test Cases:
    • "Tell me about Amul ghee" → product_info
    • "Add milk to cart" → add_to_cart
    • "Show my cart" → view_cart
    • "Compare products" → product_comparison
    • "What's the price?" → price_inquiry

    Validation Criteria:
    • Intent accuracy > 95%
    • Confidence scores > 0.8 for clear intents
    • Proper handling of ambiguous queries

Entity Extraction Tests
~~~~~~~~~~~~~~~~~~~~~~

Tests the extraction of product names, quantities, brands, etc.:

.. code-block:: text

    Test Cases:
    • "Add 2 liters of organic milk" → [product: "organic milk", quantity: "2 liters"]
    • "Compare Amul and Patanjali ghee" → [product: "Amul ghee", product: "Patanjali ghee"]
    • "Show products under ₹500" → [price: "under ₹500"]

    Validation Criteria:
    • Entity accuracy > 90%
    • Proper handling of product variants
    • Quantity and unit recognition

Multi-Intent Processing Tests
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Tests handling of multiple requests in single messages:

.. code-block:: text

    Test Cases:
    • "I want to buy ghee and check milk prices" → [add_to_cart, price_inquiry]
    • "Compare products then add cheaper one" → [product_comparison, add_to_cart]
    • "Show organic products and delivery info" → [product_search, general_query]

    Validation Criteria:
    • All intents detected correctly
    • Proper processing order maintained
    • Comprehensive response generation

Clarification Flow Tests
~~~~~~~~~~~~~~~~~~~~~~~

Tests missing information detection and clarification:

.. code-block:: text

    Test Cases:
    • "I want to buy ghee" → Clarification for brand/variant
    • "Add milk to cart" → Clarification for quantity
    • "Place order" → Clarification for delivery method

    Validation Criteria:
    • Missing information detected correctly
    • Appropriate clarification questions asked
    • Context maintained during clarification

Cart Operations Tests
~~~~~~~~~~~~~~~~~~~~

Tests shopping cart functionality:

.. code-block:: text

    Test Cases:
    • Add products to cart
    • Remove products from cart
    • Update quantities
    • View cart contents
    • Calculate totals

    Validation Criteria:
    • Cart state maintained correctly
    • Price calculations accurate
    • Stock validation working

Performance Testing
------------------

Response Time Testing
~~~~~~~~~~~~~~~~~~~~

Measures response times under various conditions:

.. code-block:: bash

    # Run response time tests
    python run_validation.py --benchmarks-only --category response_time

    # Test with different load levels
    python run_validation.py --load-level low
    python run_validation.py --load-level medium
    python run_validation.py --load-level high

**Expected Response Times:**
* Simple queries: < 1 second
* Complex queries: 1-2 seconds
* Multi-intent queries: 2-3 seconds
* Clarification flows: 1-3 seconds

Cost Tracking
~~~~~~~~~~~~

Monitors API costs and token usage:

.. code-block:: bash

    # Run cost analysis
    python run_validation.py --benchmarks-only --category cost_analysis

**Cost Benchmarks:**
* Per interaction: < ₹0.75
* Per user session: < ₹7.50
* Per day: < ₹75.00

Load Testing
~~~~~~~~~~~

Tests system performance under various load conditions:

.. code-block:: bash

    # Run load tests
    python run_validation.py --benchmarks-only --category load_testing

    # Test concurrent users
    python run_validation.py --concurrent-users 10
    python run_validation.py --concurrent-users 50
    python run_validation.py --concurrent-users 100

**Load Test Scenarios:**
* Low load: 1-10 concurrent users
* Medium load: 10-50 concurrent users
* High load: 50-100 concurrent users
* Peak load: 100+ concurrent users

Stress Testing
~~~~~~~~~~~~~

Tests system behavior under extreme conditions:

.. code-block:: bash

    # Run stress tests
    python run_validation.py --benchmarks-only --category stress_testing

**Stress Test Scenarios:**
* Rapid fire requests (10+ requests/second)
* Long conversations (50+ messages)
* Complex multi-intent queries
* High token usage scenarios

Test Results & Analysis
----------------------

Test Output Format
~~~~~~~~~~~~~~~~~

Test results are generated in JSON format:

.. code-block:: json

    {
      "test_summary": {
        "total_tests": 50,
        "passed": 48,
        "failed": 2,
        "success_rate": 0.96
      },
      "performance_metrics": {
        "average_response_time_ms": 1200,
        "p95_response_time_ms": 2800,
        "total_cost_usd": 0.45,
        "total_tokens_used": 15000
      },
      "accuracy_metrics": {
        "intent_detection_accuracy": 0.96,
        "entity_extraction_accuracy": 0.92,
        "multi_intent_success_rate": 0.88
      },
      "failed_tests": [
        {
          "test_id": "conv_007_message_003",
          "expected": "product_comparison",
          "actual": "product_search",
          "confidence": 0.65
        }
      ]
    }

Interpreting Results
~~~~~~~~~~~~~~~~~~~

**Success Criteria:**
* Overall success rate > 95%
* Intent detection accuracy > 95%
* Entity extraction accuracy > 90%
* Response times within benchmarks
* Costs within budget limits

**Common Issues:**
* Low confidence scores → May need prompt tuning
* High response times → Check API performance
* High costs → Optimize token usage
* Failed multi-intent tests → Review intent detection logic

Troubleshooting
--------------

Common Test Failures
~~~~~~~~~~~~~~~~~~~

**Intent Detection Failures:**

.. code-block:: text

    Issue: "Add milk" detected as product_search instead of add_to_cart
    Solution: 
    • Review training data for add_to_cart examples
    • Check prompt engineering for intent detection
    • Verify entity extraction is working correctly

**Entity Extraction Failures:**

.. code-block:: text

    Issue: "2 liters of organic milk" not extracting quantity correctly
    Solution:
    • Check quantity recognition patterns
    • Verify unit normalization
    • Review entity extraction prompts

**Performance Issues:**

.. code-block:: text

    Issue: Response times > 3 seconds
    Solution:
    • Check API response times
    • Optimize prompt length
    • Review caching implementation
    • Check database query performance

**Cost Issues:**

.. code-block:: text

    Issue: Costs exceeding ₹0.75 per interaction
    Solution:
    • Reduce prompt length
    • Implement response caching
    • Optimize token usage
    • Use cheaper models where appropriate

Debugging Tools
~~~~~~~~~~~~~~

**Verbose Logging:**

.. code-block:: bash

    # Enable detailed logging
    python run_validation.py --verbose --log-level DEBUG

**Individual Test Debugging:**

.. code-block:: bash

    # Run single test with debug output
    python run_validation.py --test-id conv_001_message_002 --debug

**Performance Profiling:**

.. code-block:: bash

    # Profile performance bottlenecks
    python run_validation.py --profile --output profile_results.json

Continuous Integration
---------------------

Automated Testing Setup
~~~~~~~~~~~~~~~~~~~~~~

**GitHub Actions Example:**

.. code-block:: yaml

    name: Chatbot Validation
    on: [push, pull_request]
    
    jobs:
      test:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v2
          - name: Set up Python
            uses: actions/setup-python@v2
            with:
              python-version: 3.8
          - name: Install dependencies
            run: pip install -r requirements.txt
          - name: Run validation
            run: python run_validation.py --output test_results.json
          - name: Upload results
            uses: actions/upload-artifact@v2
            with:
              name: test-results
              path: test_results.json

**Pre-commit Hooks:**

.. code-block:: bash

    # Install pre-commit hooks
    pre-commit install

    # Run validation before commit
    pre-commit run --all-files

Best Practices
-------------

Test Data Management
~~~~~~~~~~~~~~~~~~~

* **Keep test data realistic**: Use actual product names and prices
* **Maintain data consistency**: Ensure test data matches production schema
* **Version control test data**: Track changes to test scenarios
* **Regular updates**: Update test data as product catalog changes

Test Execution
~~~~~~~~~~~~~

* **Run tests regularly**: Daily automated testing
* **Monitor trends**: Track performance over time
* **Document failures**: Maintain detailed failure logs
* **Update benchmarks**: Adjust performance expectations as needed

Performance Monitoring
~~~~~~~~~~~~~~~~~~~~~

* **Set up alerts**: Monitor for performance degradation
* **Track costs**: Monitor API usage and costs
* **Analyze patterns**: Identify performance bottlenecks
* **Optimize continuously**: Regular performance improvements

The validation framework provides comprehensive testing capabilities to ensure the chatbot meets quality standards and performs reliably in production environments. 