Deployment Guide
===============

This guide covers deployment options for the E-commerce Chatbot, including local development, production deployment, and documentation hosting.

Overview
--------

The E-commerce Chatbot can be deployed in multiple environments:

- **Local Development**: For testing and development
- **Production Server**: For live e-commerce platforms
- **Docker Container**: For containerized deployment
- **Cloud Platforms**: AWS, Google Cloud, Azure
- **Documentation**: GitHub Pages hosting

Local Development Setup
----------------------

Prerequisites
~~~~~~~~~~~~

- Python 3.8+
- PostgreSQL 12+
- Redis 6+
- Git

Installation Steps
~~~~~~~~~~~~~~~~~

1. **Clone the Repository**

   .. code-block:: bash

      git clone https://github.com/yourusername/ecommerce-chatbot.git
      cd ecommerce-chatbot

2. **Install Dependencies**

   .. code-block:: bash

      pip install -r requirements.txt

3. **Environment Configuration**

   .. code-block:: bash

      cp env.example .env
      # Edit .env with your configuration

4. **Database Setup**

   .. code-block:: bash

      # Create PostgreSQL database
      createdb ecommerce_chatbot
      
      # Run database migrations
      python setup_data_and_rag.py

5. **Start the Application**

   .. code-block:: bash

      python src/main.py

Configuration
-------------

Environment Variables
~~~~~~~~~~~~~~~~~~~~

Key environment variables for deployment:

.. code-block:: bash

   # Application
   APP_ENVIRONMENT=production
   APP_DEBUG=false
   APP_SECRET_KEY=your-secret-key

   # Database
   DATABASE_HOST=localhost
   DATABASE_PORT=5432
   DATABASE_USER=postgres
   DATABASE_PASSWORD=your-password
   DATABASE_NAME=ecommerce_chatbot

   # LLM Configuration
   LLM_PROVIDER=groq
   LLM_API_KEY=your-api-key
   LLM_MODEL=llama3-8b-8192

   # Feature Toggles
   FEATURES_FUZZY_MATCHING_ENABLED=true
   FEATURES_ANALYTICS_ENABLED=true
   FEATURES_COMMANDS_ENABLED=true

Production Deployment
--------------------

Docker Deployment
~~~~~~~~~~~~~~~~

1. **Create Dockerfile**

   .. code-block:: dockerfile

      FROM python:3.9-slim
      
      WORKDIR /app
      
      COPY requirements.txt .
      RUN pip install -r requirements.txt
      
      COPY . .
      
      EXPOSE 8000
      
      CMD ["python", "src/main.py"]

2. **Docker Compose Setup**

   .. code-block:: yaml

      version: '3.8'
      
      services:
        chatbot:
          build: .
          ports:
            - "8000:8000"
          environment:
            - DATABASE_HOST=postgres
            - REDIS_HOST=redis
          depends_on:
            - postgres
            - redis
          
        postgres:
          image: postgres:13
          environment:
            POSTGRES_DB: ecommerce_chatbot
            POSTGRES_USER: postgres
            POSTGRES_PASSWORD: password
          volumes:
            - postgres_data:/var/lib/postgresql/data
          
        redis:
          image: redis:6-alpine
          ports:
            - "6379:6379"
      
      volumes:
        postgres_data:

3. **Deploy with Docker Compose**

   .. code-block:: bash

      docker-compose up -d

Cloud Deployment
~~~~~~~~~~~~~~~

AWS Deployment
^^^^^^^^^^^^^

1. **EC2 Instance Setup**

   .. code-block:: bash

      # Launch EC2 instance
      # Install dependencies
      sudo apt update
      sudo apt install python3-pip postgresql redis-server
      
      # Clone and setup application
      git clone https://github.com/yourusername/ecommerce-chatbot.git
      cd ecommerce-chatbot
      pip install -r requirements.txt

2. **RDS Database Setup**

   - Create RDS PostgreSQL instance
   - Configure security groups
   - Update environment variables

3. **ElastiCache Redis Setup**

   - Create ElastiCache Redis cluster
   - Configure security groups
   - Update Redis configuration

4. **Load Balancer Configuration**

   - Create Application Load Balancer
   - Configure target groups
   - Set up SSL certificates

Google Cloud Platform
^^^^^^^^^^^^^^^^^^^^

1. **App Engine Deployment**

   .. code-block:: yaml

      # app.yaml
      runtime: python39
      
      env_variables:
        APP_ENVIRONMENT: production
        DATABASE_HOST: /cloudsql/project:region:instance
      
      beta_settings:
        cloud_sql_instances: project:region:instance

2. **Cloud SQL Setup**

   - Create Cloud SQL PostgreSQL instance
   - Configure connection settings
   - Set up database

3. **Deploy to App Engine**

   .. code-block:: bash

      gcloud app deploy

Azure Deployment
^^^^^^^^^^^^^^^

1. **Azure App Service**

   - Create App Service with Python runtime
   - Configure environment variables
   - Set up Azure Database for PostgreSQL

2. **Azure Container Instances**

   - Build and push Docker image
   - Deploy to Container Instances
   - Configure networking

Monitoring and Logging
---------------------

Application Monitoring
~~~~~~~~~~~~~~~~~~~~~

1. **Health Checks**

   .. code-block:: python

      @app.route('/health')
      def health_check():
          return {
              'status': 'healthy',
              'timestamp': datetime.now().isoformat(),
              'version': config.app.version
          }

2. **Metrics Collection**

   - Response time monitoring
   - Error rate tracking
   - Cost tracking for LLM calls
   - User interaction analytics

3. **Logging Configuration**

   .. code-block:: python

      # Configure structured logging
      logging.basicConfig(
          level=config.logging.level,
          format=config.logging.format,
          handlers=[
              RotatingFileHandler(
                  config.logging.file_path,
                  maxBytes=config.logging.max_file_size_mb * 1024 * 1024,
                  backupCount=config.logging.backup_count
              )
          ]
      )

Performance Optimization
-----------------------

Database Optimization
~~~~~~~~~~~~~~~~~~~~

1. **Connection Pooling**

   .. code-block:: python

      # Configure connection pool
      pool_size = config.database.pool_size
      max_overflow = config.database.max_overflow

2. **Query Optimization**

   - Use indexes on frequently queried columns
   - Implement query caching
   - Optimize search queries

Caching Strategy
~~~~~~~~~~~~~~~

1. **Redis Caching**

   - Cache search results
   - Cache user sessions
   - Cache product information

2. **Application Caching**

   - LLM response caching
   - Template caching
   - Configuration caching

Security Considerations
----------------------

1. **API Key Management**

   - Use environment variables for sensitive data
   - Rotate API keys regularly
   - Use secret management services

2. **Input Validation**

   - Validate all user inputs
   - Implement SQL injection protection
   - Use parameterized queries

3. **Rate Limiting**

   - Implement request rate limiting
   - Monitor for abuse
   - Set up alerts for unusual activity

Documentation Deployment
-----------------------

GitHub Pages Setup
~~~~~~~~~~~~~~~~~

1. **Enable GitHub Pages**

   - Go to repository Settings → Pages
   - Select "Deploy from a branch"
   - Choose gh-pages branch

2. **GitHub Actions Workflow**

   Create `.github/workflows/docs.yml`:

   .. code-block:: yaml

      name: Build and Deploy Documentation

      on:
        push:
          branches: [ main, master ]
        pull_request:
          branches: [ main, master ]

      jobs:
        build-docs:
          runs-on: ubuntu-latest
          
          steps:
          - name: Checkout repository
            uses: actions/checkout@v4
            
          - name: Set up Python
            uses: actions/setup-python@v4
            with:
              python-version: '3.9'
              
          - name: Install dependencies
            run: |
              cd docs
              python -m pip install --upgrade pip
              pip install -r requirements.txt
              
          - name: Build documentation
            run: |
              cd docs
              make html
              
          - name: Deploy to GitHub Pages
            if: github.ref == 'refs/heads/main' || github.ref == 'refs/heads/master'
            uses: peaceiris/actions-gh-pages@v3
            with:
              github_token: ${{ secrets.GITHUB_TOKEN }}
              publish_dir: ./docs/_build/html
              force_orphan: true

3. **Sphinx Configuration**

   Update `docs/conf.py`:

   .. code-block:: python

      # GitHub Pages configuration
      html_baseurl = 'https://yourusername.github.io/your-repo-name/'

      # Theme options
      html_theme_options = {
          'navigation_depth': 4,
          'collapse_navigation': False,
          'sticky_navigation': True,
          'includehidden': True,
          'titles_only': False,
          'logo_only': False,
          'display_version': True,
          'prev_next_buttons_location': 'bottom',
          'style_external_links': True,
          'style_nav_header_background': '#2980B9',
      }

Custom Domain Setup
~~~~~~~~~~~~~~~~~~

1. **Configure CNAME**

   Edit `docs/CNAME`:

   .. code-block:: text

      docs.yourdomain.com

2. **DNS Configuration**

   Add CNAME record:

   .. code-block:: text

      Type: CNAME
      Name: docs
      Value: yourusername.github.io

3. **Update Sphinx Configuration**

   .. code-block:: python

      html_baseurl = 'https://docs.yourdomain.com/'

Local Documentation Development
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. **Build Documentation**

   .. code-block:: bash

      cd docs
      make html

2. **Serve Locally**

   .. code-block:: bash

      make serve
      # Visit http://localhost:8000

3. **Watch for Changes**

   .. code-block:: bash

      make watch

Troubleshooting
--------------

Common Issues
~~~~~~~~~~~~

1. **Build Failures**

   .. code-block:: bash

      # Check dependencies
      pip install -r requirements.txt
      
      # Clean and rebuild
      make clean
      make html

2. **Database Connection Issues**

   - Verify database credentials
   - Check network connectivity
   - Ensure database is running

3. **LLM API Issues**

   - Verify API key is valid
   - Check API rate limits
   - Monitor API costs

4. **GitHub Pages Not Updating**

   - Check GitHub Actions tab
   - Verify gh-pages branch exists
   - Check repository settings

Performance Monitoring
~~~~~~~~~~~~~~~~~~~~~

1. **Response Time Monitoring**

   - Monitor average response times
   - Set up alerts for slow responses
   - Track LLM API response times

2. **Error Rate Monitoring**

   - Monitor error rates
   - Set up error alerts
   - Track specific error types

3. **Cost Monitoring**

   - Monitor LLM API costs
   - Set up cost alerts
   - Track usage patterns

Backup and Recovery
-------------------

1. **Database Backups**

   .. code-block:: bash

      # PostgreSQL backup
      pg_dump ecommerce_chatbot > backup.sql
      
      # Restore
      psql ecommerce_chatbot < backup.sql

2. **Configuration Backups**

   - Backup configuration files
   - Version control configuration
   - Document configuration changes

3. **Disaster Recovery**

   - Document recovery procedures
   - Test recovery processes
   - Maintain backup schedules

Scaling Considerations
---------------------

1. **Horizontal Scaling**

   - Use load balancers
   - Implement session sharing
   - Use shared databases

2. **Vertical Scaling**

   - Increase server resources
   - Optimize application performance
   - Use caching strategies

3. **Database Scaling**

   - Implement read replicas
   - Use connection pooling
   - Optimize queries

4. **LLM API Scaling**

   - Implement retry logic
   - Use multiple providers
   - Monitor rate limits

This deployment guide provides comprehensive instructions for deploying the E-commerce Chatbot in various environments. Follow the sections relevant to your deployment strategy and ensure all security and performance considerations are addressed. 