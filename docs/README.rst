E-commerce Chatbot Documentation
================================

This repository contains the complete documentation for the E-commerce Chatbot project, hosted on GitHub Pages.

📖 Live Documentation
--------------------

Visit the live documentation at: `https://greengrassintelligence.github.io/chatbot_docs/ <https://greengrassintelligence.github.io/chatbot_docs/>`_

🚀 Quick Start
--------------

Prerequisites
~~~~~~~~~~~~

- Python 3.7+
- pip
- Git

Installation
~~~~~~~~~~~

.. code-block:: bash

   # Clone this repository
   git clone https://github.com/GreenGrassIntelligence/chatbot_docs.git
   cd chatbot_docs

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

- **API Reference**: Complete API documentation with examples
- **Technical Architecture**: System design and component overview
- **Deployment Guide**: Step-by-step deployment instructions
- **Quick Reference**: Common commands and configurations
- **Validation Guide**: Testing and validation procedures
- **Implementation Status**: Current development status

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

- **Main Project**: `E-commerce Chatbot <https://github.com/yourusername/ecommerce-chatbot>`_
- **API Backend**: `Chatbot API <https://github.com/yourusername/chatbot-api>`_

📞 Support
---------

- **Documentation Issues**: Create an issue in this repository
- **Project Issues**: Use the main project repository
- **Questions**: Check the documentation or create a discussion

📄 License
----------

This documentation is licensed under the same license as the main project.

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
     name: "E-commerce Chatbot"
     version: "0.1.0"
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
   export LLM_PROVIDER=openai
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

**Note**: Remember to update the URLs in ``conf.py`` and this README with your actual GitHub username and repository name! 