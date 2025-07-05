E-commerce Chatbot Documentation
===============================

Welcome to the comprehensive documentation for the **E-commerce Chatbot** - an intelligent conversational AI system designed for e-commerce platforms. This chatbot handles product inquiries, cart operations, and provides shopping assistance through natural language conversations.

.. image:: https://img.shields.io/badge/Python-3.8+-blue.svg
   :target: https://python.org
   :alt: Python 3.8+

.. image:: https://img.shields.io/badge/License-MIT-green.svg
   :target: LICENSE
   :alt: MIT License

.. image:: https://img.shields.io/badge/Status-Development-orange.svg
   :alt: Development

.. image:: https://img.shields.io/badge/Version-2.0.0-blue.svg
   :alt: Version 2.0.0

What This Chatbot Can Do
-----------------------

🎯 **Multi-Intent Processing**
   Handle multiple requests in a single message:
   
   *"I want to buy ghee and check milk prices"* → Processes both purchase and price inquiry

🤖 **Intelligent Clarification**
   Automatically detect missing information and ask for clarification:
   
   *"I want to buy ghee"* → *"Which brand? Amul, Patanjali, or Mother Dairy?"*

🛒 **E-commerce Operations**
   * Product information and search
   * Cart management (add, remove, update)
   * Price and stock inquiries
   * Product comparisons

🧠 **Context-Aware Conversations**
   Remember user preferences and maintain conversation context across interactions

📊 **Analytics and Monitoring**
   Track performance, costs, and user interactions

Quick Start
-----------

.. code-block:: bash

    # Clone the repository
    git clone <repository-url>
    cd "Chatbot Core"
    
    # Install dependencies
    pip install -r requirements.txt
    
    # Setup environment
    cp env.example .env
    # Edit .env with your API keys (GROQ_API_KEY required)
    
    # Run the chatbot
    python src/main.py

Documentation Structure
----------------------

.. toctree::
   :maxdepth: 2
   :caption: Getting Started:

   quick_reference
   implementation_status

.. toctree::
   :maxdepth: 2
   :caption: User Guide:

   chatbot_capabilities
   deployment_guide
   validation_guide

.. toctree::
   :maxdepth: 2
   :caption: Development:

   analysis_and_improvements
   improvements_summary

.. toctree::
   :maxdepth: 2
   :caption: Reference:

   documentation_audit_summary

.. toctree::
   :maxdepth: 1
   :caption: API Reference:

   api/index

Getting Help
-----------

* **Quick Reference**: Start with the :doc:`quick_reference` for immediate usage
* **Implementation Status**: Check :doc:`implementation_status` for feature availability
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