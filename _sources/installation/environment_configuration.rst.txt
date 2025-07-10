Environment Configuration Guide
===============================

This guide provides detailed information about all environment variables and configuration options for the e-commerce chatbot.

Overview
--------

The application uses a unified configuration system that supports multiple configuration sources:
- Environment variables
- YAML configuration files
- Feature toggles
- Database and service configurations

Environment Variables Reference
------------------------------

**Database Configuration**

.. code-block:: bash

   # PostgreSQL Database URL
   DATABASE_URL=postgresql://username:password@host:port/database
   
   # Database connection pool settings
   DB_POOL_SIZE=10
   DB_MAX_OVERFLOW=20
   DB_POOL_TIMEOUT=30

**Redis Configuration**

.. code-block:: bash

   # Redis connection URL
   REDIS_URL=redis://localhost:6379
   
   # Redis database number
   REDIS_DB=0
   
   # Redis connection timeout
   REDIS_TIMEOUT=5

**LLM Configuration**

.. code-block:: bash

   # OpenAI API Key
   OPENAI_API_KEY=sk-your-api-key-here
   
   # LLM Model selection
   LLM_MODEL=gpt-3.5-turbo
   
   # LLM Provider (openai, anthropic, etc.)
   LLM_PROVIDER=openai
   
   # Maximum tokens for responses
   LLM_MAX_TOKENS=1000
   
   # Temperature for response generation
   LLM_TEMPERATURE=0.7

**Feature Toggles**

.. code-block:: bash

   # Search Features
   ENABLE_FUZZY_MATCHING=true
   ENABLE_PHONETIC_MATCHING=true
   ENABLE_PARTIAL_MATCHING=true
   
   # System Features
   ENABLE_ANALYTICS=true
   ENABLE_COMMANDS=true
   ENABLE_SEARCH=true
   ENABLE_SESSION_MANAGEMENT=true
   ENABLE_CACHING=true

**Search Configuration**

.. code-block:: bash

   # Fuzzy matching threshold
   FUZZY_THRESHOLD=0.8
   
   # Phonetic matching algorithm
   PHONETIC_ALGORITHM=metaphone
   
   # Partial matching minimum length
   PARTIAL_MIN_LENGTH=3

**Analytics Configuration**

.. code-block:: bash

   # Analytics tracking enabled
   ANALYTICS_ENABLED=true
   
   # Analytics database URL (if separate)
   ANALYTICS_DB_URL=postgresql://analytics_user:password@host:port/analytics_db
   
   # Cost tracking enabled
   COST_TRACKING_ENABLED=true

**Session Configuration**

.. code-block:: bash

   # Session timeout in seconds
   SESSION_TIMEOUT=3600
   
   # Session cleanup interval
   SESSION_CLEANUP_INTERVAL=300
   
   # Maximum sessions per user
   MAX_SESSIONS_PER_USER=5

**Caching Configuration**

.. code-block:: bash

   # Cache TTL in seconds
   CACHE_TTL=300
   
   # Cache max size
   CACHE_MAX_SIZE=1000
   
   # Cache eviction policy
   CACHE_EVICTION_POLICY=lru

**Logging Configuration**

.. code-block:: bash

   # Log level
   LOG_LEVEL=INFO
   
   # Log format
   LOG_FORMAT=json
   
   # Log file path
   LOG_FILE=logs/chatbot.log

**Security Configuration**

.. code-block:: bash

   # Secret key for sessions
   SECRET_KEY=your-secret-key-here
   
   # CORS origins
   CORS_ORIGINS=http://localhost:3000,https://yourdomain.com
   
   # Rate limiting
   RATE_LIMIT_REQUESTS=100
   RATE_LIMIT_WINDOW=3600

Configuration File Structure
---------------------------

**YAML Configuration Example**

.. code-block:: yaml

   # Database Configuration
   database:
     url: ${DATABASE_URL}
     pool_size: ${DB_POOL_SIZE:10}
     max_overflow: ${DB_MAX_OVERFLOW:20}
     pool_timeout: ${DB_POOL_TIMEOUT:30}
   
   # Redis Configuration
   redis:
     url: ${REDIS_URL:redis://localhost:6379}
     db: ${REDIS_DB:0}
     timeout: ${REDIS_TIMEOUT:5}
   
   # LLM Configuration
   llm:
     provider: ${LLM_PROVIDER:openai}
     model: ${LLM_MODEL:gpt-3.5-turbo}
     api_key: ${OPENAI_API_KEY}
     max_tokens: ${LLM_MAX_TOKENS:1000}
     temperature: ${LLM_TEMPERATURE:0.7}
   
   # Feature Configuration
   features:
     fuzzy_matching: ${ENABLE_FUZZY_MATCHING:true}
     phonetic_matching: ${ENABLE_PHONETIC_MATCHING:true}
     partial_matching: ${ENABLE_PARTIAL_MATCHING:true}
     analytics: ${ENABLE_ANALYTICS:true}
     commands: ${ENABLE_COMMANDS:true}
     search: ${ENABLE_SEARCH:true}
     session_management: ${ENABLE_SESSION_MANAGEMENT:true}
     caching: ${ENABLE_CACHING:true}
   
   # Search Configuration
   search:
     fuzzy_threshold: ${FUZZY_THRESHOLD:0.8}
     phonetic_algorithm: ${PHONETIC_ALGORITHM:metaphone}
     partial_min_length: ${PARTIAL_MIN_LENGTH:3}
   
   # Analytics Configuration
   analytics:
     enabled: ${ANALYTICS_ENABLED:true}
     db_url: ${ANALYTICS_DB_URL}
     cost_tracking: ${COST_TRACKING_ENABLED:true}
   
   # Session Configuration
   session:
     timeout: ${SESSION_TIMEOUT:3600}
     cleanup_interval: ${SESSION_CLEANUP_INTERVAL:300}
     max_per_user: ${MAX_SESSIONS_PER_USER:5}
   
   # Caching Configuration
   cache:
     ttl: ${CACHE_TTL:300}
     max_size: ${CACHE_MAX_SIZE:1000}
     eviction_policy: ${CACHE_EVICTION_POLICY:lru}
   
   # Logging Configuration
   logging:
     level: ${LOG_LEVEL:INFO}
     format: ${LOG_FORMAT:json}
     file: ${LOG_FILE:logs/chatbot.log}
   
   # Security Configuration
   security:
     secret_key: ${SECRET_KEY}
     cors_origins: ${CORS_ORIGINS}
     rate_limit_requests: ${RATE_LIMIT_REQUESTS:100}
     rate_limit_window: ${RATE_LIMIT_WINDOW:3600}

Configuration Loading Order
--------------------------

The application loads configuration in the following order:

1. **Default values** (hardcoded in application)
2. **Environment variables** (override defaults)
3. **YAML configuration file** (override environment variables)
4. **Runtime configuration** (can be changed during execution)

Configuration Validation
-----------------------

The unified configuration system validates all settings:

- **Type checking**: Ensures correct data types
- **Range validation**: Validates numeric ranges
- **Required fields**: Checks for mandatory settings
- **Dependency validation**: Ensures related settings are consistent

Example Validation Errors:

.. code-block:: text

   ConfigurationError: Invalid fuzzy_threshold value: 1.5 (must be between 0.0 and 1.0)
   ConfigurationError: Missing required setting: OPENAI_API_KEY
   ConfigurationError: Invalid database URL format

Environment-Specific Configurations
----------------------------------

**Development Environment**

.. code-block:: bash

   # Development settings
   LOG_LEVEL=DEBUG
   ENABLE_ANALYTICS=false
   CACHE_TTL=60
   SESSION_TIMEOUT=1800

**Production Environment**

.. code-block:: bash

   # Production settings
   LOG_LEVEL=WARNING
   ENABLE_ANALYTICS=true
   CACHE_TTL=3600
   SESSION_TIMEOUT=7200
   RATE_LIMIT_REQUESTS=50

**Testing Environment**

.. code-block:: bash

   # Testing settings
   DATABASE_URL=postgresql://test_user:test_pass@localhost:5432/test_db
   REDIS_URL=redis://localhost:6379/1
   ENABLE_ANALYTICS=false
   LOG_LEVEL=ERROR

Configuration Management Best Practices
-------------------------------------

1. **Use environment variables for secrets**
2. **Keep configuration files in version control**
3. **Use different configuration files for different environments**
4. **Validate configuration on startup**
5. **Document all configuration options**
6. **Use meaningful default values**
7. **Implement configuration hot-reloading where appropriate**

Troubleshooting Configuration Issues
-----------------------------------

**Common Issues:**

- **Missing environment variables**: Check `.env` file and environment
- **Invalid configuration values**: Review validation error messages
- **Configuration file not found**: Verify file path and permissions
- **Type conversion errors**: Ensure correct data types in configuration

**Debugging Commands:**

.. code-block:: bash

   # Print current configuration
   python -c "from src.config.unified_config import get_config; print(get_config())"
   
   # Validate configuration
   python -c "from src.config.unified_config import validate_config; validate_config()"
   
   # Test configuration loading
   python -c "from src.config.config_manager import ConfigManager; cm = ConfigManager(); print(cm.get_all_settings())" 