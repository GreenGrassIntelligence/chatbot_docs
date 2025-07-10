Chatbot Core Documentation
==========================

This repository contains the complete documentation for the Chatbot Core project, organized for easy navigation and maintenance.

📖 Live Documentation
--------------------

Visit the live documentation at: `https://greengrassintelligence.github.io/chatbot_core/ <https://greengrassintelligence.github.io/chatbot_core/>`_

🚀 Quick Start
--------------

Prerequisites
~~~~~~~~~~~~

- Python 3.8+
- pip
- Git

Installation
~~~~~~~~~~~

.. code-block:: bash

   # Clone this repository
   git clone https://github.com/GreenGrassIntelligence/chatbot_core.git
   cd chatbot_core

   # Install dependencies
   pip install -r requirements.txt

   # Build documentation locally
   make html

   # View locally (optional)
   make serve

Deployment
~~~~~~~~~~

.. code-block:: bash

   # Deploy to GitHub Pages
   ./deploy.sh

📚 Documentation Structure
-------------------------

The documentation is organized into four main sections:

**Installation**
- Documentation setup and configuration
- Application installation and setup
- Environment configuration

**Usage**
- Getting started guide
- Comprehensive user guide
- Troubleshooting and support

**Development**
- Architecture overview
- NLU system details
- Configuration guide
- Database schema
- Testing guide
- Performance optimization

**Maintenance**
- Monitoring and logging
- Analysis and improvements
- Improvements summary

🔧 Development
-------------

Building Documentation
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   # Build HTML documentation
   make html

   # Build PDF documentation
   make pdf

   # Build EPUB documentation
   make epub

   # Check links
   make linkcheck

   # Check spelling
   make spelling

Local Development
~~~~~~~~~~~~~~~~

.. code-block:: bash

   # Start local server
   make serve

   # Watch for changes (in separate terminal)
   make watch

📝 Contributing
--------------

1. Fork this repository
2. Create a feature branch
3. Make your changes
4. Test the build: ``make html``
5. Submit a pull request

🔗 Related Repositories
----------------------

- **Main Project**: `Chatbot Core <https://github.com/GreenGrassIntelligence/chatbot_core>`_

📞 Support
---------

- **Documentation Issues**: Create an issue in this repository
- **Project Issues**: Use the main project repository
- **Questions**: Check the documentation or create a discussion

📄 License
----------

This documentation is licensed under the same license as the main project.

System Overview
--------------

The Chatbot Core system is a comprehensive conversational AI platform designed for e-commerce applications. It features:

- **Advanced NLP**: Multi-intent processing and intelligent entity recognition
- **Flexible Search**: Fuzzy matching, phonetic matching, and wildcard support
- **Context Management**: Session-based conversation memory and state tracking
- **Analytics**: Comprehensive performance monitoring and user behavior analysis
- **Modular Architecture**: Extensible design with plugin support

Key Features
-----------

- **Multi-Intent Processing**: Handle multiple requests in single messages
- **Intelligent Clarification**: Automatic detection and resolution of missing information
- **Advanced Search**: Fuzzy, phonetic, and partial matching capabilities
- **Real-time Analytics**: Performance monitoring and user behavior tracking
- **Comprehensive Testing**: Automated validation and performance benchmarking
- **Extensive Documentation**: Complete guides for all user types

Configuration System
-------------------

The chatbot uses a unified configuration system that supports:

- **Environment Variables**: Override any config value via environment variables
- **YAML Configuration**: Centralized configuration file
- **Feature Toggles**: Enable/disable features dynamically
- **Type Safety**: Strongly typed configuration with dataclasses

Example Configuration
~~~~~~~~~~~~~~~~~~~~

.. code-block:: yaml

   app:
     name: "Chatbot Core"
     version: "2.0.0"
     environment: "development"
     debug: true

   features:
     fuzzy_matching:
       enabled: true
       max_distance: 2
       min_score: 0.6
     phonetic_matching:
       enabled: true
     partial_matching:
       enabled: true
     analytics:
       enabled: true
     commands:
       enabled: true
     search:
       enabled: true
       max_results: 10
     session_management:
       enabled: true
       auto_cleanup: true
     caching:
       enabled: true

Environment Variables
~~~~~~~~~~~~~~~~~~~~

You can override any configuration using environment variables:

.. code-block:: bash

   export APP_ENVIRONMENT=production
   export FEATURES_FUZZY_MATCHING_ENABLED=false
   export DATABASE_HOST=prod-db.example.com
   export LLM_PROVIDER=groq
   export LLM_API_KEY=your-api-key

Feature Toggles
~~~~~~~~~~~~~~

The system supports dynamic feature toggles:

.. code-block:: python

   from src.config import config

   # Check if a feature is enabled
   if config.features.fuzzy_matching:
       # Use fuzzy matching
       pass

   # Get feature configuration
   search_config = config.search
   max_results = search_config.max_results

---

**Note**: This documentation is automatically generated and deployed to GitHub Pages. For the latest updates, check the main repository. 