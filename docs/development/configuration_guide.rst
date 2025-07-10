Configuration Guide
==================

This guide provides detailed information about configuring the e-commerce chatbot system, including the unified configuration system, feature toggles, and environment-specific settings.

Overview
--------

The e-commerce chatbot uses a unified configuration system that supports multiple configuration sources with type safety, validation, and runtime updates.

**Location**: `src/config/`

**Key Features**:
- Type-safe configuration with dataclasses
- Environment variable support
- YAML configuration files
- Feature toggles
- Runtime configuration updates
- Validation and error checking

Unified Configuration System
---------------------------

**Configuration Structure**

The configuration is organized into logical sections:

.. code-block:: python

   from src.config.unified_config import AppConfig, get_config

   # Get the complete configuration
   config = get_config()

   # Access specific sections
   database_config = config.database
   llm_config = config.llm
   features_config = config.features
   search_config = config.search

**Configuration Sections**

**App Configuration**
   - Application name and version
   - Environment settings
   - Debug mode
   - Logging configuration

**Database Configuration**
   - Connection settings
   - Pool configuration
   - Schema settings
   - Migration settings

**LLM Configuration**
   - Provider selection
   - API keys and endpoints
   - Model parameters
   - Cost tracking settings

**Feature Toggles**
   - Search features (fuzzy, phonetic, partial)
   - System features (analytics, commands, caching)
   - Session management
   - Security features

**Search Configuration**
   - Matching thresholds
   - Result limits
   - Performance settings
   - Algorithm parameters

**Session Configuration**
   - Timeout settings
   - Cleanup intervals
   - Storage settings
   - Memory management

**Currency Configuration**
   - Currency code and symbol
   - Locale settings
   - Decimal places
   - Formatting options

**Logging Configuration**
   - Log levels
   - File paths
   - Rotation settings
   - Format options

**Security Configuration**
   - Input validation
   - Rate limiting
   - Protection settings
   - Authentication

**Performance Configuration**
   - Cache settings
   - Timeouts
   - Concurrent requests
   - Resource limits

**Monitoring Configuration**
   - Metrics collection
   - Health checks
   - Analytics settings
   - Alerting

Feature Toggles
--------------

**Search Features**

**Fuzzy Matching**
   - Enable/disable fuzzy search
   - Configure similarity threshold
   - Set maximum distance

.. code-block:: python

   # Check if fuzzy matching is enabled
   if config.features.fuzzy_matching:
       # Use fuzzy matching algorithm
       results = fuzzy_matcher.search(query, threshold=config.search.fuzzy_threshold)

**Phonetic Matching**
   - Enable/disable phonetic search
   - Select phonetic algorithm
   - Configure matching parameters

.. code-block:: python

   # Check if phonetic matching is enabled
   if config.features.phonetic_matching:
       # Use phonetic matching algorithm
       results = phonetic_matcher.search(query, algorithm=config.search.phonetic_algorithm)

**Partial Matching**
   - Enable/disable partial search
   - Set minimum length
   - Configure case sensitivity

.. code-block:: python

   # Check if partial matching is enabled
   if config.features.partial_matching:
       # Use partial matching algorithm
       results = partial_matcher.search(query, min_length=config.search.partial_min_length)

**System Features**

**Analytics**
   - Enable/disable analytics tracking
   - Configure tracking parameters
   - Set privacy options

.. code-block:: python

   # Check if analytics is enabled
   if config.features.analytics:
       # Track user interaction
       analytics.track_event('search', {'query': query, 'results_count': len(results)})

**Commands**
   - Enable/disable command processing
   - Configure available commands
   - Set command permissions

.. code-block:: python

   # Check if commands are enabled
   if config.features.commands:
       # Process command
       if message.startswith('/'):
           response = command_handler.process(message)

**Search**
   - Enable/disable search functionality
   - Configure search algorithms
   - Set performance parameters

.. code-block:: python

   # Check if search is enabled
   if config.features.search:
       # Perform search
       results = search_engine.search(query, filters=filters)

**Session Management**
   - Enable/disable session management
   - Configure session storage
   - Set timeout values

.. code-block:: python

   # Check if session management is enabled
   if config.features.session_management:
       # Manage session
       session = session_manager.get_session(user_id)

**Caching**
   - Enable/disable caching
   - Configure cache settings
   - Set TTL values

.. code-block:: python

   # Check if caching is enabled
   if config.features.caching:
       # Use cache
       cached_result = cache.get(key)
       if cached_result:
           return cached_result

Environment Variables
--------------------

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
   
   # LLM Provider
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

YAML Configuration
-----------------

**Configuration File Structure**

Create `config/app_config.yaml`:

.. code-block:: yaml

   # App Configuration
   app:
     name: "E-commerce Chatbot"
     version: "1.0.0"
     environment: "development"
     debug: true
   
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
     max_results: 50
   
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

1. **Default Values**
   - Hardcoded defaults in application code
   - Type-safe default values

2. **Environment Variables**
   - Override any config value
   - Highest priority for sensitive data

3. **YAML Configuration File**
   - Human-readable configuration
   - Environment-specific settings

4. **Runtime Configuration**
   - Dynamic updates during execution
   - Feature toggle changes

**Example Loading Process**

.. code-block:: python

   # 1. Load defaults
   config = AppConfig()
   
   # 2. Override with environment variables
   config.database.url = os.getenv('DATABASE_URL', config.database.url)
   config.features.fuzzy_matching = os.getenv('ENABLE_FUZZY_MATCHING', 'true').lower() == 'true'
   
   # 3. Override with YAML file
   if os.path.exists('config/app_config.yaml'):
       yaml_config = load_yaml_config('config/app_config.yaml')
       config = merge_configs(config, yaml_config)
   
   # 4. Runtime updates
   config.features.analytics = False  # Disable analytics temporarily

Configuration Validation
-----------------------

**Type Checking**

The configuration system validates all settings:

.. code-block:: python

   from src.config.unified_config import validate_config, ConfigurationError

   try:
       validate_config(config)
       print("Configuration is valid")
   except ConfigurationError as e:
       print(f"Configuration error: {e}")

**Validation Rules**

**Database URL**
   - Must be valid PostgreSQL URL
   - Must include username, password, host, port, database

**API Keys**
   - Must be non-empty strings
   - Must match expected format

**Numeric Values**
   - Must be within valid ranges
   - Must be positive numbers where applicable

**Boolean Values**
   - Must be true/false or 1/0
   - Environment variables converted to boolean

**Example Validation Errors**

.. code-block:: text

   ConfigurationError: Invalid fuzzy_threshold value: 1.5 (must be between 0.0 and 1.0)
   ConfigurationError: Missing required setting: OPENAI_API_KEY
   ConfigurationError: Invalid database URL format
   ConfigurationError: Invalid session timeout: -1 (must be positive)

Environment-Specific Configurations
----------------------------------

**Development Environment**

.. code-block:: yaml

   app:
     environment: "development"
     debug: true
   
   logging:
     level: "DEBUG"
   
   features:
     analytics: false
   
   cache:
     ttl: 60

**Production Environment**

.. code-block:: yaml

   app:
     environment: "production"
     debug: false
   
   logging:
     level: "WARNING"
   
   features:
     analytics: true
   
   cache:
     ttl: 3600
   
   security:
     rate_limit_requests: 50

**Testing Environment**

.. code-block:: yaml

   app:
     environment: "testing"
     debug: true
   
   database:
     url: "postgresql://test_user:test_pass@localhost:5432/test_db"
   
   redis:
     url: "redis://localhost:6379/1"
   
   features:
     analytics: false
   
   logging:
     level: "ERROR"

Runtime Configuration Updates
----------------------------

**Feature Toggle Updates**

.. code-block:: python

   from src.config.unified_config import get_config, update_config

   # Get current configuration
   config = get_config()
   
   # Update feature toggles
   config.features.fuzzy_matching = False
   config.features.analytics = True
   
   # Apply updates
   update_config(config)

**Dynamic Configuration Changes**

.. code-block:: python

   # Update search parameters
   config.search.fuzzy_threshold = 0.9
   config.search.max_results = 100
   
   # Update session settings
   config.session.timeout = 7200
   
   # Update cache settings
   config.cache.ttl = 600

**Configuration Hot Reloading**

.. code-block:: python

   import asyncio
   from src.config.config_manager import ConfigManager

   async def watch_config_changes():
       config_manager = ConfigManager()
       
       while True:
           # Check for configuration file changes
           if config_manager.has_changes():
               # Reload configuration
               await config_manager.reload()
               print("Configuration reloaded")
           
           await asyncio.sleep(30)  # Check every 30 seconds

Configuration Best Practices
---------------------------

**Security**

1. **Use Environment Variables for Secrets**
   - Never hardcode API keys
   - Use environment variables for sensitive data
   - Use secret management systems in production

2. **Validate All Inputs**
   - Validate configuration values
   - Check for required settings
   - Validate data types and ranges

**Performance**

1. **Optimize Configuration Loading**
   - Cache configuration values
   - Minimize file I/O operations
   - Use efficient parsing

2. **Use Appropriate Defaults**
   - Set sensible default values
   - Provide fallback options
   - Document default behaviors

**Maintainability**

1. **Document Configuration Options**
   - Document all configuration parameters
   - Provide examples and usage
   - Include validation rules

2. **Use Type Safety**
   - Use dataclasses for configuration
   - Provide type hints
   - Validate configuration at startup

**Deployment**

1. **Environment-Specific Configurations**
   - Use different config files for different environments
   - Override with environment variables
   - Use configuration management tools

2. **Configuration Versioning**
   - Version configuration files
   - Track configuration changes
   - Provide migration scripts

Troubleshooting Configuration Issues
-----------------------------------

**Common Issues**

**Missing Environment Variables**
   - Check `.env` file
   - Verify environment variable names
   - Ensure variables are exported

**Invalid Configuration Values**
   - Check data types
   - Verify value ranges
   - Review validation rules

**Configuration File Not Found**
   - Check file path
   - Verify file permissions
   - Ensure file exists

**Type Conversion Errors**
   - Check data types in YAML
   - Verify environment variable formats
   - Review configuration schema

**Debugging Commands**

.. code-block:: bash

   # Print current configuration
   python -c "from src.config.unified_config import get_config; print(get_config())"
   
   # Validate configuration
   python -c "from src.config.unified_config import validate_config; validate_config()"
   
   # Test configuration loading
   python -c "from src.config.config_manager import ConfigManager; cm = ConfigManager(); print(cm.get_all_settings())"

For more information about related components, see:

- :doc:`database_schema` - Database structure and models
- :doc:`testing_guide` - Testing strategies and procedures
- :doc:`deployment_guide` - Deployment configuration 