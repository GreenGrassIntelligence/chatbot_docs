E-commerce Chatbot Deployment Guide
==================================

This comprehensive guide provides step-by-step instructions for deploying the e-commerce chatbot in development, staging, and production environments.

Overview
--------

The Enhanced E-commerce Chatbot is designed for easy deployment across different environments. This guide covers everything from initial setup to production deployment with monitoring and scaling considerations.

Prerequisites
------------

System Requirements
~~~~~~~~~~~~~~~~~~

* **Operating System**: Linux (Ubuntu 20.04+), macOS, or Windows with WSL
* **Python**: 3.8 or higher
* **PostgreSQL**: 12 or higher
* **Redis**: 6.0 or higher
* **Memory**: Minimum 4GB RAM (8GB+ recommended)
* **Storage**: 10GB+ available disk space
* **Network**: Stable internet connection for API calls

Required Accounts & Services
~~~~~~~~~~~~~~~~~~~~~~~~~~~

* **Groq API**: Sign up at https://console.groq.com/
* **PostgreSQL**: Local installation or cloud service (AWS RDS, Google Cloud SQL, etc.)
* **Redis**: Local installation or cloud service (AWS ElastiCache, Redis Cloud, etc.)
* **Optional**: Monitoring services (DataDog, New Relic, etc.)

Environment Setup
----------------

1. Clone the Repository
~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

    git clone <repository-url>
    cd "Chatbot Core"

2. Python Environment Setup
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

    # Create virtual environment
    python -m venv venv
    
    # Activate virtual environment
    # On Linux/macOS:
    source venv/bin/activate
    # On Windows:
    venv\Scripts\activate
    
    # Install dependencies
    pip install -r requirements.txt

3. Environment Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

    # Copy environment template
    cp env.example .env
    
    # Edit .env file with your configuration
    nano .env

Required Environment Variables
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

    # Database Configuration
    DB_HOST=localhost
    DB_PORT=5432
    DB_USER=postgres
    DB_PASSWORD=your_secure_password
    DB_NAME=ecommerce_dev
    
    # Redis Configuration
    REDIS_HOST=localhost
    REDIS_PORT=6379
    REDIS_PASSWORD=your_redis_password
    
    # LLM Configuration
    GROQ_API_KEY=your_groq_api_key
    
    # Application Configuration
    ENVIRONMENT=development
    LOG_LEVEL=INFO
    SECRET_KEY=your_secret_key_here
    
    # Optional: Monitoring
    ENABLE_MONITORING=true
    MONITORING_API_KEY=your_monitoring_key

Database Setup
--------------

1. Install PostgreSQL
~~~~~~~~~~~~~~~~~~~~~

**Ubuntu/Debian**:
.. code-block:: bash

    sudo apt update
    sudo apt install postgresql postgresql-contrib
    
    # Start PostgreSQL service
    sudo systemctl start postgresql
    sudo systemctl enable postgresql

**macOS**:
.. code-block:: bash

    brew install postgresql
    brew services start postgresql

**Windows**: Download from https://www.postgresql.org/download/windows/

2. Create Database and User
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

    # Connect to PostgreSQL as superuser
    sudo -u postgres psql
    
    # Create database user
    CREATE USER ecommerce_user WITH PASSWORD 'your_secure_password';
    
    # Create database
    CREATE DATABASE ecommerce_dev OWNER ecommerce_user;
    
    # Grant privileges
    GRANT ALL PRIVILEGES ON DATABASE ecommerce_dev TO ecommerce_user;
    
    # Exit PostgreSQL
    \q

3. Run Database Schema
~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

    # Apply database schema
    psql -h localhost -U ecommerce_user -d ecommerce_dev -f src/models/database_schema.sql

Redis Setup
-----------

1. Install Redis
~~~~~~~~~~~~~~~~

**Ubuntu/Debian**:
.. code-block:: bash

    sudo apt update
    sudo apt install redis-server
    
    # Start Redis service
    sudo systemctl start redis-server
    sudo systemctl enable redis-server

**macOS**:
.. code-block:: bash

    brew install redis
    brew services start redis

**Windows**: Download from https://redis.io/download

2. Configure Redis
~~~~~~~~~~~~~~~~~

.. code-block:: bash

    # Edit Redis configuration
    sudo nano /etc/redis/redis.conf
    
    # Set password (optional but recommended)
    requirepass your_redis_password
    
    # Restart Redis
    sudo systemctl restart redis-server

3. Test Redis Connection
~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

    redis-cli ping
    # Should return: PONG

API Key Setup
-------------

1. Groq API Key
~~~~~~~~~~~~~~~

* Sign up at https://console.groq.com/
* Navigate to API Keys section
* Create a new API key
* Copy the key to your .env file

2. Test API Connection
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

    # Test Groq API connection
    python -c "
    import os
    from groq import Groq
    
    client = Groq(api_key=os.getenv('GROQ_API_KEY'))
    try:
        response = client.chat.completions.create(
            messages=[{'role': 'user', 'content': 'Hello'}],
            model='llama3-8b-8192',
            max_tokens=10
        )
        print('API connection successful!')
    except Exception as e:
        print(f'API connection failed: {e}')
    "

Load Test Data
--------------

.. code-block:: bash

    # Load sample products and test data
    python tests/data/load_test_data.py

Configuration Files
------------------

Main Configuration (config.py)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The main configuration file supports three environments:

* **Development**: Local development with debug features
* **Staging**: Pre-production testing environment
* **Production**: Live production environment

Key Configuration Sections:

.. code-block:: python

    # Database Configuration
    database = DatabaseConfig(
        host="localhost",
        port=5432,
        user="postgres",
        password="password",
        database="ecommerce_dev"
    )
    
    # Redis Configuration
    redis = RedisConfig(
        host="localhost",
        port=6379,
        password="redis_password"
    )
    
    # LLM Configuration
    llm = LLMConfig(
        api_key="your_groq_api_key",
        model="llama3-8b-8192",
        max_tokens=1000
    )

Environment-Specific Configurations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Development Environment:**

.. code-block:: python

    ENVIRONMENT = "development"
    LOG_LEVEL = "DEBUG"
    ENABLE_DEBUG = True
    CACHE_TTL = 300  # 5 minutes

**Staging Environment:**

.. code-block:: python

    ENVIRONMENT = "staging"
    LOG_LEVEL = "INFO"
    ENABLE_DEBUG = False
    CACHE_TTL = 600  # 10 minutes

**Production Environment:**

.. code-block:: python

    ENVIRONMENT = "production"
    LOG_LEVEL = "WARNING"
    ENABLE_DEBUG = False
    CACHE_TTL = 1800  # 30 minutes

Running the Application
----------------------

Development Mode
~~~~~~~~~~~~~~~

.. code-block:: bash

    # Run in development mode
    python src/main.py

    # Run with debug logging
    python src/main.py --debug

    # Run with custom config
    python src/main.py --config custom_config.json

Production Mode
~~~~~~~~~~~~~~

.. code-block:: bash

    # Run in production mode
    ENVIRONMENT=production python src/main.py

    # Run with gunicorn (recommended for production)
    gunicorn -w 4 -b 0.0.0.0:8000 src.main:app

    # Run with uvicorn (for async support)
    uvicorn src.main:app --host 0.0.0.0 --port 8000 --workers 4

Docker Deployment
----------------

1. Create Dockerfile
~~~~~~~~~~~~~~~~~~~

.. code-block:: dockerfile

    FROM python:3.8-slim
    
    WORKDIR /app
    
    # Install system dependencies
    RUN apt-get update && apt-get install -y \
        postgresql-client \
        && rm -rf /var/lib/apt/lists/*
    
    # Copy requirements and install Python dependencies
    COPY requirements.txt .
    RUN pip install --no-cache-dir -r requirements.txt
    
    # Copy application code
    COPY . .
    
    # Create non-root user
    RUN useradd -m -u 1000 chatbot && chown -R chatbot:chatbot /app
    USER chatbot
    
    # Expose port
    EXPOSE 8000
    
    # Run the application
    CMD ["python", "src/main.py"]

2. Create Docker Compose
~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: yaml

    version: '3.8'
    
    services:
      chatbot:
        build: .
        ports:
          - "8000:8000"
        environment:
          - ENVIRONMENT=production
          - DB_HOST=postgres
          - REDIS_HOST=redis
        depends_on:
          - postgres
          - redis
        restart: unless-stopped
    
      postgres:
        image: postgres:13
        environment:
          - POSTGRES_DB=ecommerce_prod
          - POSTGRES_USER=postgres
          - POSTGRES_PASSWORD=secure_password
        volumes:
          - postgres_data:/var/lib/postgresql/data
        restart: unless-stopped
    
      redis:
        image: redis:6-alpine
        command: redis-server --requirepass redis_password
        volumes:
          - redis_data:/data
        restart: unless-stopped
    
    volumes:
      postgres_data:
      redis_data:

3. Deploy with Docker
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

    # Build and run with Docker Compose
    docker-compose up -d
    
    # View logs
    docker-compose logs -f chatbot
    
    # Scale the application
    docker-compose up -d --scale chatbot=3

Cloud Deployment
---------------

AWS Deployment
~~~~~~~~~~~~~~

**EC2 Setup:**

.. code-block:: bash

    # Launch EC2 instance
    aws ec2 run-instances \
        --image-id ami-0c02fb55956c7d316 \
        --instance-type t3.medium \
        --key-name your-key-pair \
        --security-group-ids sg-12345678

    # Install dependencies
    sudo apt update
    sudo apt install python3-pip postgresql redis-server

    # Deploy application
    git clone <repository-url>
    cd "Chatbot Core"
    pip3 install -r requirements.txt

    # Setup systemd service
    sudo nano /etc/systemd/system/chatbot.service
```

[Unit]
Description=E-commerce Chatbot
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu/Chatbot Core
Environment=PATH=/home/ubuntu/Chatbot Core/venv/bin
ExecStart=/home/ubuntu/Chatbot Core/venv/bin/python src/main.py
Restart=always

[Install]
WantedBy=multi-user.target
```

    # Start service
    sudo systemctl enable chatbot
    sudo systemctl start chatbot
```

**RDS Setup:**

.. code-block:: bash

    # Create RDS instance
    aws rds create-db-instance \
        --db-instance-identifier chatbot-db \
        --db-instance-class db.t3.micro \
        --engine postgres \
        --master-username postgres \
        --master-user-password secure_password \
        --allocated-storage 20

**ElastiCache Setup:**

.. code-block:: bash

    # Create ElastiCache cluster
    aws elasticache create-cache-cluster \
        --cache-cluster-id chatbot-cache \
        --cache-node-type cache.t3.micro \
        --engine redis \
        --num-cache-nodes 1

Google Cloud Deployment
~~~~~~~~~~~~~~~~~~~~~~

**App Engine Setup:**

.. code-block:: yaml

    # app.yaml
    runtime: python38
    
    env_variables:
      ENVIRONMENT: production
      DB_HOST: /cloudsql/project:region:instance
      REDIS_HOST: redis-ip
    
    automatic_scaling:
      target_cpu_utilization: 0.6
      min_instances: 1
      max_instances: 10

**Cloud SQL Setup:**

.. code-block:: bash

    # Create Cloud SQL instance
    gcloud sql instances create chatbot-db \
        --database-version=POSTGRES_13 \
        --tier=db-f1-micro \
        --region=us-central1

**Cloud Memorystore Setup:**

.. code-block:: bash

    # Create Redis instance
    gcloud redis instances create chatbot-cache \
        --size=1 \
        --region=us-central1

Monitoring & Logging
-------------------

Application Monitoring
~~~~~~~~~~~~~~~~~~~~~

**Health Checks:**

.. code-block:: python

    # Add health check endpoint
    @app.get("/health")
    async def health_check():
        return {
            "status": "healthy",
            "timestamp": datetime.now().isoformat(),
            "version": "1.0.0"
        }

**Metrics Collection:**

.. code-block:: python

    # Track key metrics
    metrics = {
        "requests_per_minute": 0,
        "average_response_time": 0,
        "error_rate": 0,
        "api_cost_per_hour": 0
    }

Logging Configuration
~~~~~~~~~~~~~~~~~~~~

**Structured Logging:**

.. code-block:: python

    import logging
    import json
    
    class JSONFormatter(logging.Formatter):
        def format(self, record):
            log_entry = {
                "timestamp": self.formatTime(record),
                "level": record.levelname,
                "message": record.getMessage(),
                "module": record.module,
                "function": record.funcName
            }
            return json.dumps(log_entry)
    
    # Configure logging
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
        handlers=[
            logging.FileHandler('chatbot.log'),
            logging.StreamHandler()
        ]
    )

Performance Optimization
-----------------------

Caching Strategy
~~~~~~~~~~~~~~~

**Redis Caching:**

.. code-block:: python

    import redis
    import json
    
    # Cache frequently accessed data
    def cache_product_info(product_id, data, ttl=3600):
        redis_client.setex(f"product:{product_id}", ttl, json.dumps(data))
    
    def get_cached_product(product_id):
        data = redis_client.get(f"product:{product_id}")
        return json.loads(data) if data else None

**Response Caching:**

.. code-block:: python

    # Cache common responses
    def cache_response(query_hash, response, ttl=1800):
        redis_client.setex(f"response:{query_hash}", ttl, response)

Load Balancing
~~~~~~~~~~~~~

**Nginx Configuration:**

.. code-block:: nginx

    upstream chatbot_backend {
        server 127.0.0.1:8001;
        server 127.0.0.1:8002;
        server 127.0.0.1:8003;
    }
    
    server {
        listen 80;
        server_name chatbot.example.com;
        
        location / {
            proxy_pass http://chatbot_backend;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
        }
    }

Scaling Considerations
---------------------

Horizontal Scaling
~~~~~~~~~~~~~~~~~

* **Multiple Instances**: Run multiple chatbot instances behind a load balancer
* **Database Connection Pooling**: Use connection pooling for database connections
* **Redis Clustering**: Use Redis cluster for high availability
* **Auto-scaling**: Implement auto-scaling based on CPU/memory usage

Vertical Scaling
~~~~~~~~~~~~~~~

* **Resource Allocation**: Increase CPU and memory for single instances
* **Database Optimization**: Optimize database queries and indexes
* **Caching**: Implement aggressive caching for frequently accessed data
* **CDN**: Use CDN for static assets and responses

Security Considerations
----------------------

API Security
~~~~~~~~~~~

* **Rate Limiting**: Implement rate limiting to prevent abuse
* **Authentication**: Add API key authentication for external access
* **Input Validation**: Validate all user inputs
* **SQL Injection Prevention**: Use parameterized queries

Data Security
~~~~~~~~~~~~

* **Encryption**: Encrypt sensitive data at rest and in transit
* **Access Control**: Implement proper access controls for database
* **Audit Logging**: Log all access and modifications
* **Backup Strategy**: Regular backups with encryption

Troubleshooting
--------------

Common Issues
~~~~~~~~~~~~

**Database Connection Issues:**

.. code-block:: text

    Issue: Cannot connect to PostgreSQL
    Solution:
    • Check database service is running
    • Verify connection credentials
    • Check firewall settings
    • Test connection manually

**Redis Connection Issues:**

.. code-block:: text

    Issue: Cannot connect to Redis
    Solution:
    • Check Redis service is running
    • Verify password configuration
    • Check port accessibility
    • Test connection manually

**API Key Issues:**

.. code-block:: text

    Issue: Groq API calls failing
    Solution:
    • Verify API key is correct
    • Check API key permissions
    • Verify account has sufficient credits
    • Test API connection manually

**Performance Issues:**

.. code-block:: text

    Issue: Slow response times
    Solution:
    • Check database query performance
    • Monitor API response times
    • Review caching implementation
    • Check system resources

Debugging Tools
~~~~~~~~~~~~~~

**Log Analysis:**

.. code-block:: bash

    # View application logs
    tail -f chatbot.log
    
    # Search for errors
    grep "ERROR" chatbot.log
    
    # Monitor performance
    grep "response_time" chatbot.log

**Database Debugging:**

.. code-block:: bash

    # Connect to database
    psql -h localhost -U postgres -d ecommerce_dev
    
    # Check slow queries
    SELECT query, mean_time FROM pg_stat_statements ORDER BY mean_time DESC LIMIT 10;

**Redis Debugging:**

.. code-block:: bash

    # Connect to Redis
    redis-cli
    
    # Monitor commands
    MONITOR
    
    # Check memory usage
    INFO memory

Maintenance & Updates
--------------------

Regular Maintenance
~~~~~~~~~~~~~~~~~~

* **Database Maintenance**: Regular vacuum and analyze operations
* **Log Rotation**: Implement log rotation to manage disk space
* **Backup Verification**: Regularly test backup restoration
* **Security Updates**: Keep dependencies updated

Update Procedures
~~~~~~~~~~~~~~~~

* **Zero-downtime Deployment**: Use blue-green deployment strategy
* **Database Migrations**: Test migrations in staging first
* **Configuration Updates**: Use configuration management tools
* **Rollback Procedures**: Maintain rollback capabilities

The deployment guide provides comprehensive instructions for deploying the chatbot in various environments while ensuring security, performance, and maintainability. 