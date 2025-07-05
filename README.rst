E-commerce Chatbot - Production Grade Solution
=============================================

A comprehensive, production-grade e-commerce chatbot built with LLM, RAG, and PostgreSQL. Features advanced intent detection, entity extraction, analytics tracking, cost monitoring, and feature toggles.

.. image:: https://img.shields.io/badge/Python-3.8+-blue.svg
   :target: https://python.org
   :alt: Python 3.8+

.. image:: https://img.shields.io/badge/License-MIT-green.svg
   :target: LICENSE
   :alt: MIT License

.. image:: https://img.shields.io/badge/Version-0.1.0-blue.svg
   :alt: Version 0.1.0

🚀 Features
-----------

Core Features
~~~~~~~~~~~~

- **Advanced LLM Integration**: Support for Groq, OpenAI, Anthropic, and Ollama
- **Intent & Entity Extraction**: Robust detection with confidence scoring
- **RAG (Retrieval Augmented Generation)**: For product descriptions and FAQs
- **PostgreSQL Database**: Structured data for products, orders, users, analytics
- **Redis Caching**: Fast session management and response caching
- **Analytics Engine**: Comprehensive tracking of interactions, costs, and performance
- **Cost Monitoring**: Real-time tracking of LLM API costs
- **Session Management**: Multi-turn conversation support
- **Modular Architecture**: Clean, maintainable, and extensible codebase

Enhanced Features
~~~~~~~~~~~~~~~~

- **Database Integration**: Real-time data persistence with PostgreSQL
- **Cart Management**: Persistent shopping cart with database storage
- **Order Processing**: Complete order lifecycle management with PDF invoices
- **Stock Management**: Live stock tracking with automatic updates
- **Input Validation**: SQL injection protection and XSS prevention
- **Configuration Management**: YAML-based with environment variable support
- **Currency Support**: Indian Rupee (₹) with tax calculations (10% GST)

Feature Toggles
~~~~~~~~~~~~~~

- **Fuzzy Matching**: Enable/disable fuzzy search functionality
- **Phonetic Matching**: Enable/disable phonetic search capabilities
- **Partial Matching**: Enable/disable partial text matching
- **Analytics**: Enable/disable user interaction tracking
- **Commands**: Enable/disable command system
- **Search**: Enable/disable search functionality
- **Session Management**: Enable/disable session handling
- **Caching**: Enable/disable caching features

📋 Prerequisites
---------------

System Requirements
~~~~~~~~~~~~~~~~~~

- Python 3.8+
- PostgreSQL 12+
- Redis 6+ (optional, for caching)
- 2GB RAM minimum
- 1GB disk space

🛠️ Installation
---------------

1. **Clone the Repository**

   .. code-block:: bash

      git clone <repository-url>
      cd chatbot-core

2. **Create Virtual Environment**

   .. code-block:: bash

      python -m venv venv
      source venv/bin/activate  # On Windows: venv\Scripts\activate

3. **Install Dependencies**

   .. code-block:: bash

      pip install -r requirements.txt

4. **Environment Configuration**

   Create a `.env` file in the root directory:

   .. code-block:: bash

      # Environment
      ENV=development

      # Database Configuration
      DATABASE_HOST=localhost
      DATABASE_PORT=5432
      DATABASE_USER=postgres
      DATABASE_PASSWORD=your_password
      DATABASE_NAME=ecommerce_dev

      # Redis Configuration
      REDIS_HOST=localhost
      REDIS_PORT=6379
      REDIS_PASSWORD=

      # LLM Configuration
      GROQ_API_KEY=gsk_your_groq_api_key_here
      OPENAI_API_KEY=sk-your_openai_api_key_here
      ANTHROPIC_API_KEY=sk-ant-your_anthropic_api_key_here

      # Feature Toggles
      ENABLE_FUZZY_MATCHING=true
      ENABLE_PHONETIC_MATCHING=true
      ENABLE_ANALYTICS=true
      ENABLE_COMMANDS=true

5. **Database Setup**

   .. code-block:: bash

      # Create database
      createdb ecommerce_dev

      # Run database migrations
      psql -d ecommerce_dev -f src/models/database_schema.sql

6. **Redis Setup**

   .. code-block:: bash

      # Start Redis server
      redis-server

      # Or using Docker
      docker run -d -p 6379:6379 redis:6-alpine

7. **Initialize System**

   .. code-block:: bash

      # Run full setup (database + data + RAG + search)
      python setup_data_and_rag.py --full-setup

🏗️ System Architecture
-----------------------

.. code-block:: text

   ┌─────────────────────────────────────────────────────────────────────────────┐
   │                              USER INTERFACE LAYER                           │
   └─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
   ┌─────────────────────────────────────────────────────────────────────────────┐
   │                              INPUT PROCESSING                               │
   │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────────────┐  │
   │  │   User Input    │─▶│ Input Validator │─▶│   Security & Sanitization   │  │
   │  │                 │  │                 │  │  • SQL Injection Protection │  │
   │  │                 │  │                 │  │  • XSS Prevention           │  │
   │  │                 │  │                 │  │  • Input Sanitization       │  │
   │  └─────────────────┘  └─────────────────┘  └─────────────────────────────┘  │
   └─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
   ┌─────────────────────────────────────────────────────────────────────────────┐
   │                              NATURAL LANGUAGE UNDERSTANDING (NLU)           │
   │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────────────┐  │
   │  │ Intent Detection│  │ Entity Extraction│  │   Multi-Intent Processing   │  │
   │  │                 │  │                 │  │  • Primary Intent           │  │
   │  │ • Product Info  │  │ • Product Names │  │  • Secondary Intents        │  │
   │  │ • Product Search│  │ • Quantities    │  │  • Intent Confidence        │  │
   │  │ • Add to Cart   │  │ • Categories    │  │  • Clarification Detection  │  │
   │  │ • View Cart     │  │ • Brands        │  │                             │  │
   │  │ • Order History │  │ • Prices        │  │                             │  │
   │  │ • Price Inquiry │  │ • User Context  │  │                             │  │
   │  │ • Stock Inquiry │  │                 │  │                             │  │
   │  └─────────────────┘  └─────────────────┘  └─────────────────────────────┘  │
   └─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
   ┌─────────────────────────────────────────────────────────────────────────────┐
   │                              SEARCH & MATCHING ENGINE                       │
   │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────────────┐  │
   │  │  Fuzzy Matcher  │  │ Phonetic Matcher│  │   Partial Matcher           │  │
   │  │                 │  │                 │  │                             │  │
   │  │ • Levenshtein   │  │ • Sound-based   │  │ • Substring Matching       │  │
   │  │ • Typo Tolerance│  │ • Brand Names   │  │ • Case-insensitive         │  │
   │  │ • Configurable  │  │ • Product Names │  │ • Configurable Threshold   │  │
   │  │   Distance      │  │ • Similar Words │  │                             │  │
   │  └─────────────────┘  └─────────────────┘  └─────────────────────────────┘  │
   │                                                                             │
   │  ┌─────────────────────────────────────────────────────────────────────────┐  │
   │  │                    RAG (Retrieval Augmented Generation)                 │  │
   │  │  • Vector Database (ChromaDB)                                          │  │
   │  │  • Embedding Model (text-embedding-3-small)                            │  │
   │  │  • Semantic Search & Similarity Matching                               │  │
   │  │  • Context-Aware Product Retrieval                                     │  │
   │  └─────────────────────────────────────────────────────────────────────────┘  │
   └─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
   ┌─────────────────────────────────────────────────────────────────────────────┐
   │                              CONTEXT & SESSION MANAGEMENT                   │
   │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────────────┐  │
   │  │ Session Manager │  │ Context Tracker │  │   Conversation Memory       │  │
   │  │                 │  │                 │  │                             │  │
   │  │ • Session Timeout│  │ • User History │  │ • Multi-turn Context        │  │
   │  │ • Auto Cleanup  │  │ • Preferences   │  │ • Intent Continuity         │  │
   │  │ • Multi-session │  │ • Cart State    │  │ • Entity Resolution         │  │
   │  │   Support       │  │ • Order History │  │ • Clarification Context     │  │
   │  └─────────────────┘  └─────────────────┘  └─────────────────────────────┘  │
   └─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
   ┌─────────────────────────────────────────────────────────────────────────────┐
   │                              ACTION EXECUTION LAYER                         │
   │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────────────┐  │
   │  │  Cart Manager   │  │  Order Manager  │  │   Stock Manager             │  │
   │  │                 │  │                 │  │                             │  │
   │  │ • Add Items     │  │ • Order Creation│  │ • Stock Checking            │  │
   │  │ • Remove Items  │  │ • Order Status  │  │ • Stock Reservation         │  │
   │  │ • Update Qty    │  │ • Order History │  │ • Low Stock Alerts          │  │
   │  │ • Cart Total    │  │ • Invoice Gen   │  │ • Auto Stock Updates        │  │
   │  │ • Cart Cleanup  │  │ • Payment Track │  │                             │  │
   │  └─────────────────┘  └─────────────────┘  └─────────────────────────────┘  │
   │                                                                             │
   │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────────────┐  │
   │  │ Command Handler │  │ Product Search  │  │   Price Calculator          │  │
   │  │                 │  │                 │  │                             │  │
   │  │ • /cart         │  │ • Field Search  │  │ • Price Calculation         │  │
   │  │ • /verbose      │  │ • Category Filter│  │ • Tax Calculation (10% GST)│  │
   │  │ • /help         │  │ • Price Range   │  │ • Discount Application      │  │
   │  │ • /clear        │  │ • Brand Filter  │  │ • Currency Formatting       │  │
   │  └─────────────────┘  └─────────────────┘  └─────────────────────────────┘  │
   └─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
   ┌─────────────────────────────────────────────────────────────────────────────┐
   │                              NATURAL LANGUAGE GENERATION (NLG)             │
   │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────────────┐  │
   │  │ Response Gen    │  │ Template Engine │  │   Context-Aware NLG         │  │
   │  │                 │  │                 │  │                             │  │
   │  │ • Intent-based  │  │ • Prompt Templates│  │ • Personalized Responses   │  │
   │  │ • Entity-aware  │  │ • System Prompts│  │ • Conversation Continuity   │  │
   │  │ • Context-aware │  │ • Dynamic Prompts│  │ • Multi-language Ready      │  │
   │  │ • Multi-format  │  │ • Response Cache│  │ • Tone Adaptation           │  │
   │  └─────────────────┘  └─────────────────┘  └─────────────────────────────┘  │
   └─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
   ┌─────────────────────────────────────────────────────────────────────────────┐
   │                              ANALYTICS & MONITORING                         │
   │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────────────┐  │
   │  │ Analytics Engine│  │ Cost Tracker    │  │   Performance Monitor       │  │
   │  │                 │  │                 │  │                             │  │
   │  │ • User Interactions│  │ • LLM API Costs│  │ • Response Time Tracking   │  │
   │  │ • Intent Tracking│  │ • Token Usage  │  │ • Success Rate Monitoring   │  │
   │  │ • Error Tracking │  │ • Cost per Call│  │ • Resource Usage Tracking   │  │
   │  │ • Conversion Rate│  │ • Daily/Monthly│  │ • Cache Hit Rate            │  │
   │  │ • User Journey   │  │   Cost Reports │  │ • Database Query Performance│  │
   │  └─────────────────┘  └─────────────────┘  └─────────────────────────────┘  │
   │                                                                             │
   │  ┌─────────────────────────────────────────────────────────────────────────┐  │
   │  │                    ERROR HANDLING & LOGGING                            │  │
   │  │  • Structured Logging (JSON)                                           │  │
   │  │  • Error Categorization & Classification                               │  │
   │  │  • Retry Mechanisms with Exponential Backoff                           │  │
   │  │  • User-Friendly Error Messages                                        │  │
   │  │  • Security Event Logging                                              │  │
   │  └─────────────────────────────────────────────────────────────────────────┘  │
   └─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
   ┌─────────────────────────────────────────────────────────────────────────────┐
   │                              DATA LAYER                                    │
   │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────────────┐  │
   │  │ PostgreSQL DB   │  │   Redis Cache   │  │   Vector Database           │  │
   │  │                 │  │                 │  │   (ChromaDB)                │  │
   │  │ • Products      │  │ • Session Cache │  │                             │  │
   │  │ • Categories    │  │ • Response Cache│  │ • Product Embeddings        │  │
   │  │ • Users         │  │ • Search Cache  │  │ • Semantic Search Index     │  │
   │  │ • Orders        │  │ • User Cache    │  │ • Similarity Matching       │  │
   │  │ • Cart Items    │  │ • Rate Limiting │  │ • Context Vectors           │  │
   │  │ • Sessions      │  │ • Analytics Cache│  │                             │  │
   │  │ • Analytics     │  │                 │  │                             │  │
   │  │ • Stock Data    │  │                 │  │                             │  │
   │  └─────────────────┘  └─────────────────┘  └─────────────────────────────┘  │
   └─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
   ┌─────────────────────────────────────────────────────────────────────────────┐
   │                              EXTERNAL INTEGRATIONS                         │
   │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────────────┐  │
   │  │ LLM Providers   │  │ Payment Gateway │  │   Notification Service      │  │
   │  │                 │  │                 │  │                             │  │
   │  │ • Groq          │  │ • Payment Proc  │  │ • Email Notifications       │  │
   │  │ • OpenAI        │  │ • Order Confirm │  │ • SMS Alerts                │  │
   │  │ • Anthropic     │  │ • Refund Proc   │  │ • Push Notifications        │  │
   │  │ • Ollama        │  │ • Tax Calc      │  │ • Stock Alerts              │  │
   │  └─────────────────┘  └─────────────────┘  └─────────────────────────────┘  │
   └─────────────────────────────────────────────────────────────────────────────┘

📁 Project Structure
-------------------

.. code-block:: text

   chatbot-core/
   ├── config/
   │   └── app_config.yaml          # Main configuration with feature toggles
   ├── docs/                        # Documentation
   │   ├── README.rst              # Main documentation
   │   ├── deployment_guide.rst    # Deployment instructions
   │   └── ...
   ├── sample_data/
   │   └── products_sample.json     # Sample product data
   ├── setup_data_and_rag.py        # Automated setup script
   ├── src/
   │   ├── config/
   │   │   ├── __init__.py         # Unified configuration interface
   │   │   ├── unified_config.py   # Unified configuration system
   │   │   └── config_manager.py   # Legacy config manager
   │   ├── models/
   │   │   ├── data_models.py      # Pydantic data models
   │   │   ├── session_models.py   # Session management
   │   │   └── database_schema.sql # Database schema
   │   ├── llm/
   │   │   ├── enhanced_llm_core.py # Advanced LLM engine
   │   │   └── intent_extraction.py # Intent/entity extraction
   │   ├── search/
   │   │   └── search_engine.py    # Search with feature toggles
   │   ├── analytics/
   │   │   └── analytics_engine.py # Analytics tracking
   │   └── main.py                 # Main application
   ├── requirements.txt
   ├── .env.example
   └── README.rst                  # This file

🔧 Configuration
---------------

Environment-Specific Configs
~~~~~~~~~~~~~~~~~~~~~~~~~~~

The system supports three environments:

1. **Development** (`ENV=development`)
   - Local database and Redis
   - Debug mode enabled
   - Higher temperature for LLM responses

2. **Staging** (`ENV=staging`)
   - Staging database
   - Moderate temperature
   - Basic monitoring

3. **Production** (`ENV=production`)
   - Production database with connection pooling
   - Lower temperature for consistent responses
   - Full monitoring and cost tracking

Feature Toggle Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Environment Variables
^^^^^^^^^^^^^^^^^^^^

Control features via environment variables:

.. code-block:: bash

   # Disable specific features
   export ENABLE_FUZZY_MATCHING=false
   export ENABLE_PHONETIC_MATCHING=false
   export ENABLE_ANALYTICS=false
   export ENABLE_COMMANDS=false
   export ENABLE_SEARCH=false
   export ENABLE_SESSION_MANAGEMENT=false
   export ENABLE_CACHING=false

Configuration File
^^^^^^^^^^^^^^^^^

Update `config/app_config.yaml`:

.. code-block:: yaml

   features:
     fuzzy_matching:
       enabled: true
       max_distance: 2
       min_score: 0.6
     phonetic_matching:
       enabled: true
       min_score: 0.7
     partial_matching:
       enabled: true
       min_score: 0.5
     analytics:
       enabled: true
       track_user_interactions: true
       track_performance_metrics: true
     commands:
       enabled: true
       allow_cart_commands: true
       allow_verbose_mode: true
     search:
       enabled: true
       max_results: 10
       enable_field_specific_search: true
     session_management:
       enabled: true
       auto_cleanup: true
     caching:
       enabled: true
       cache_search_results: true
       cache_user_sessions: true

LLM Provider Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: python

   from src.config import config

   # Access LLM configuration
   llm_config = config.llm
   print(f"Provider: {llm_config.provider}")
   print(f"Model: {llm_config.model}")
   print(f"Temperature: {llm_config.temperature}")

🚀 Usage Examples
-----------------

Basic Chatbot Usage
~~~~~~~~~~~~~~~~~~

.. code-block:: python

   from src.llm.enhanced_llm_core import llm_engine
   from src.llm.intent_extraction import extract_intent_entities
   from src.analytics import analytics_engine

   # Initialize analytics
   analytics = analytics_engine

   # Process user message
   user_message = "I want to buy organic milk"
   user_id = "user123"
   session_id = "session456"

   # Start tracking interaction
   interaction_id = analytics.start_interaction(user_id, session_id, user_message)

   try:
       # Extract intent and entities
       intent_data, clarification = extract_intent_entities(user_message, user_id)
       
       if clarification:
           response = f"I need more information: {clarification}"
       else:
           # Track intent detection
           analytics.track_intent_detection(interaction_id, intent_data)
           
           # Generate response based on intent
           if intent_data.intent_type.value == "product_search":
               response = "I found several organic milk options for you..."
           else:
               response = "I understand you're looking for organic milk. Let me help you with that."
       
       # Track response
       analytics.track_response_generated(interaction_id, response)
       
   except Exception as e:
       analytics.track_error(interaction_id, str(e))
       response = "Sorry, I encountered an error. Please try again."

   # End interaction tracking
   metrics = analytics.end_interaction(interaction_id)
   print(f"Interaction completed in {metrics.total_processing_time_ms}ms")

Feature Toggle Usage
~~~~~~~~~~~~~~~~~~~

.. code-block:: python

   from src.config import config

   # Check if features are enabled
   if config.features.fuzzy_matching:
       # Use fuzzy matching
       pass

   if config.features.analytics:
       # Track analytics
       pass

   # Get feature configuration
   search_config = config.search
   max_results = search_config.max_results

🔍 Search Features
-----------------

Fuzzy Matching
~~~~~~~~~~~~~

- Levenshtein distance-based typo tolerance
- Configurable maximum distance (default: 2)
- Minimum similarity score threshold

Phonetic Matching
~~~~~~~~~~~~~~~~

- Sound-based matching for similar-sounding words
- Useful for brand names and product names
- Configurable similarity threshold

Partial Matching
~~~~~~~~~~~~~~~

- Substring matching within product names/descriptions
- Configurable minimum score threshold
- Case-insensitive matching

📊 Analytics Features
--------------------

User Interaction Tracking
~~~~~~~~~~~~~~~~~~~~~~~

- Intent detection tracking
- Response generation metrics
- Error tracking and reporting
- Performance monitoring

Performance Metrics
~~~~~~~~~~~~~~~~~~

- Processing time measurement
- Token usage tracking
- Cost calculation
- Success rate monitoring

🗄️ Database Schema
------------------

Core Tables
~~~~~~~~~~

- `products` - Product catalog
- `categories` - Product categories
- `users` - User information
- `orders` - Order history
- `cart_items` - Shopping cart
- `sessions` - User sessions
- `analytics_events` - Analytics data

Sample Data
~~~~~~~~~~

The system includes comprehensive sample data with:
- 8 products across 5 categories
- Multiple variants per product
- Nutritional information
- Product tags and ingredients
- Pricing and stock information

🧪 Testing
----------

Test Commands
~~~~~~~~~~~

.. code-block:: bash

   # Run basic tests
   python test_chatbot.py

   # Run enhanced system tests
   python test_enhanced_system.py

   # Run search tests
   python test_wildcards_and_fuzzy.py

   # Run command tests
   python test_commands_only.py

📚 Documentation
---------------

- **Quick Reference**: Start with the quick reference for immediate usage
- **Implementation Status**: Check implementation status for feature availability
- **Deployment Guide**: Comprehensive deployment instructions
- **API Reference**: Complete API documentation
- **Technical Architecture**: System design and component overview

Getting Help
-----------

* **Quick Reference**: Start with the quick reference for immediate usage
* **Implementation Status**: Check implementation status for feature availability
* **Examples**: See `tests/data/test_conversations.json` for usage examples
* **Validation**: Run `python run_validation.py` to test the system
* **Issues**: Check the analysis documents for known limitations

Contributing
-----------

1. Read the documentation thoroughly
2. Run the validation suite: `python run_validation.py`
3. Test your changes with the provided test data
4. Update documentation for any new features
5. Ensure all tests pass before submitting

License
-------

This project is licensed under the MIT License - see the LICENSE file for details.

Support
-------

For technical support or questions about the chatbot capabilities, please refer to the detailed documentation in the sections below.

Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search` 