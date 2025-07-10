Application Setup Guide
=======================

This guide covers setting up the e-commerce chatbot application, including database configuration, RAG system, and environment setup.

Overview
--------

The e-commerce chatbot requires several components to be properly configured:
- PostgreSQL database
- Redis cache
- ChromaDB vector database
- Environment variables
- Python dependencies

Prerequisites
------------

- Python 3.8+
- PostgreSQL 12+
- Redis 6+
- Docker (optional, for containerized setup)

Database Setup
--------------

**PostgreSQL Configuration**

1. **Install PostgreSQL**

   .. code-block:: bash

      # Ubuntu/Debian
      sudo apt-get install postgresql postgresql-contrib

      # macOS
      brew install postgresql

2. **Create Database and User**

   .. code-block:: bash

      sudo -u postgres psql
      CREATE DATABASE chatbot_db;
      CREATE USER chatbot_user WITH PASSWORD 'your_password';
      GRANT ALL PRIVILEGES ON DATABASE chatbot_db TO chatbot_user;
      \q

3. **Initialize Schema**

   .. code-block:: bash

      python setup_data_and_rag.py

**Redis Setup**

1. **Install Redis**

   .. code-block:: bash

      # Ubuntu/Debian
      sudo apt-get install redis-server

      # macOS
      brew install redis

2. **Start Redis Service**

   .. code-block:: bash

      sudo systemctl start redis-server
      # or
      redis-server

RAG System Setup
----------------

**ChromaDB Configuration**

1. **Install ChromaDB**

   .. code-block:: bash

      pip install chromadb

2. **Initialize Vector Database**

   The RAG system uses ChromaDB for storing product embeddings and enabling semantic search.

   .. code-block:: bash

      python setup_data_and_rag.py --init-rag

3. **Load Sample Data**

   .. code-block:: bash

      python setup_data_and_rag.py --load-sample-data

Environment Configuration
------------------------

**Environment Variables**

Create a `.env` file based on `env.example`:

.. code-block:: bash

   # Database Configuration
   DATABASE_URL=postgresql://chatbot_user:your_password@localhost:5432/chatbot_db
   
   # Redis Configuration
   REDIS_URL=redis://localhost:6379
   
   # LLM Configuration
   OPENAI_API_KEY=your_openai_api_key
   
   # Feature Toggles
   ENABLE_FUZZY_MATCHING=true
   ENABLE_PHONETIC_MATCHING=true
   ENABLE_PARTIAL_MATCHING=true
   ENABLE_ANALYTICS=true
   ENABLE_COMMANDS=true
   ENABLE_SEARCH=true
   ENABLE_SESSION_MANAGEMENT=true
   ENABLE_CACHING=true

**Configuration File**

The application uses a unified configuration system. Create `config/app_config.yaml`:

.. code-block:: yaml

   database:
     url: postgresql://chatbot_user:your_password@localhost:5432/chatbot_db
     pool_size: 10
     max_overflow: 20
   
   redis:
     url: redis://localhost:6379
     db: 0
   
   llm:
     provider: openai
     model: gpt-3.5-turbo
     api_key: ${OPENAI_API_KEY}
   
   features:
     fuzzy_matching: true
     phonetic_matching: true
     partial_matching: true
     analytics: true
     commands: true
     search: true
     session_management: true
     caching: true

Python Dependencies
------------------

**Install Requirements**

.. code-block:: bash

   pip install -r requirements.txt

**Key Dependencies**

- **FastAPI**: Web framework
- **SQLAlchemy**: Database ORM
- **Redis**: Caching
- **ChromaDB**: Vector database
- **OpenAI**: LLM integration
- **Pydantic**: Data validation

Verification
-----------

**Test Database Connection**

.. code-block:: bash

   python -c "from src.database.database_manager import DatabaseManager; db = DatabaseManager(); print('Database connected successfully')"

**Test RAG System**

.. code-block:: bash

   python -c "from src.search.search_engine import SearchEngine; se = SearchEngine(); print('RAG system initialized')"

**Run Application**

.. code-block:: bash

   python src/main.py

Troubleshooting
--------------

**Common Issues:**

- **Database Connection**: Verify PostgreSQL is running and credentials are correct
- **Redis Connection**: Check Redis service status
- **ChromaDB Issues**: Ensure sufficient disk space and permissions
- **Environment Variables**: Verify all required variables are set

**Useful Commands:**

.. code-block:: bash

   # Check database status
   sudo systemctl status postgresql
   
   # Check Redis status
   sudo systemctl status redis-server
   
   # Test database connection
   psql -h localhost -U chatbot_user -d chatbot_db
   
   # View application logs
   tail -f logs/chatbot.log

Next Steps
----------

After successful setup:

1. Review the :doc:`../usage/getting_started` guide
2. Explore :doc:`../usage/chatbot_capabilities`
3. Check :doc:`../development/technical_architecture` for system details
4. Run validation tests with :doc:`../usage/validation_guide` 