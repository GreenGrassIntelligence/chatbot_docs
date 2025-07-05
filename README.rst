E-commerce Chatbot Documentation
===============================

Welcome to the documentation for the **E-commerce Chatbot** - an intelligent conversational AI system designed for e-commerce platforms. This chatbot handles product inquiries, cart operations, and provides shopping assistance through natural language conversations.

.. image:: https://img.shields.io/badge/Python-3.8+-blue.svg
   :target: https://python.org
   :alt: Python 3.8+

.. image:: https://img.shields.io/badge/License-MIT-green.svg
   :target: LICENSE
   :alt: MIT License

.. image:: https://img.shields.io/badge/Status-Development-orange.svg
   :alt: Development

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

Key Features (Implemented)
-------------------------

Multi-Intent Detection
~~~~~~~~~~~~~~~~~~~~~

The chatbot can understand and process multiple intents in a single message:

.. code-block:: text

    User: "Compare Amul and Patanjali ghee, then add the cheaper one to cart"
    
    Bot Response:
    "I'll help you compare and purchase!
    
    Comparison:
    • Amul Pure Ghee 1L - ₹495
    • Patanjali Pure Ghee 1L - ₹450
    
    Patanjali is cheaper by ₹45. Adding 1L Patanjali Pure Ghee to your cart!"

Missing Information Detection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Automatically detects when critical information is missing:

.. code-block:: text

    User: "I want to buy ghee"
    
    Bot: "Which brand of ghee would you prefer? We have:
    • Amul Pure Ghee
    • Patanjali Pure Ghee  
    • Mother Dairy Ghee
    
    Also, would you prefer cow ghee or buffalo ghee?"

Fuzzy Search and Pattern Matching
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Supports flexible product matching with fuzzy search and wildcards:

.. code-block:: text

    User: "Show me organic * under ₹500"
    
    Bot: "Here are organic products under ₹500:
    • Organic Milk 1L - ₹299
    • Organic Tomatoes 500g - ₹199"

Command System
~~~~~~~~~~~~~

Built-in commands for enhanced functionality:

.. code-block:: text

    /cart - Show current cart status
    /verbose - Toggle detailed processing information

Documentation Structure
----------------------

.. toctree::
   :maxdepth: 2
   :caption: Contents:

   quick_reference
   implementation_status
   chatbot_capabilities
   deployment_guide
   validation_guide
   analysis_and_improvements
   improvements_summary
   documentation_audit_summary

Core Capabilities (Implemented)
-----------------------------

Product Management
~~~~~~~~~~~~~~~~~

* **Product Information**: Detailed product descriptions, ingredients, nutritional info
* **Product Search**: Flexible search with filters, categories, and price ranges
* **Product Comparison**: Side-by-side comparison of products, prices, and features
* **Stock Inquiries**: Real-time stock availability

Cart Operations
~~~~~~~~~~~~~~

* **Add to Cart**: Smart product selection with variant and quantity specification
* **Cart Management**: View, update quantities, remove items, clear cart
* **Cart Calculations**: Automatic price calculations, discounts, and tax

Customer Support
~~~~~~~~~~~~~~~

* **General Queries**: Help with policies, delivery, returns, and account issues
* **Clarification Handling**: Intelligent follow-up questions for incomplete requests
* **Context Maintenance**: Remember user preferences and conversation history

Technical Architecture
---------------------

.. code-block:: text

    ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
    │   User Input    │───▶│  Intent Engine  │───▶│  Response Gen   │
    └─────────────────┘    └─────────────────┘    └─────────────────┘
           │                       │                       │
           ▼                       ▼                       ▼
    ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
    │  Multi-Intent   │    │  Entity Extract │    │  Context Mgmt   │
    │   Detection     │    │   & Validation  │    │   & Memory      │
    └─────────────────┘    └─────────────────┘    └─────────────────┘
           │                       │                       │
           ▼                       ▼                       ▼
    ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
    │  Missing Info   │    │  Fuzzy Search   │    │   Analytics     │
    │   Detection     │    │   Engine        │    │   & Monitoring  │
    └─────────────────┘    └─────────────────┘    └─────────────────┘

Performance Metrics
------------------

* **Response Time**: < 2 seconds for most queries
* **Intent Accuracy**: > 90% for common e-commerce intents
* **Entity Recognition**: > 85% accuracy for product names and quantities
* **Multi-Intent Success**: > 80% for complex multi-request messages
* **Clarification Success**: > 85% for incomplete queries

Supported Intents (Implemented)
-----------------------------

.. list-table:: Supported Intent Types
   :header-rows: 1
   :widths: 30 40 30

   * - Intent Type
     - Description
     - Example
   * - product_info
     - Get detailed product information
     - "Tell me about Amul ghee"
   * - product_search
     - Search for products with filters
     - "Find organic products under ₹500"
   * - product_comparison
     - Compare multiple products
     - "Compare Amul and Patanjali ghee"
   * - add_to_cart
     - Add products to shopping cart
     - "Add 2 liters of milk to cart"
   * - view_cart
     - View cart contents and total
     - "Show my cart"
   * - remove_from_cart
     - Remove items from cart
     - "Remove milk from cart"
   * - price_inquiry
     - Check product prices
     - "What's the price of ghee?"
   * - stock_inquiry
     - Check product availability
     - "Is milk in stock?"
   * - order_history
     - View past orders
     - "Show my order history"
   * - general_query
     - General customer service
     - "What's your return policy?"
   * - greeting
     - Handle greetings
     - "Hello", "Hi"
   * - goodbye
     - Handle farewells
     - "Goodbye", "Bye"

Planned Features (Not Yet Implemented)
-------------------------------------

Order Processing
~~~~~~~~~~~~~~~

* **Order Placement**: Streamlined checkout with delivery and payment options
* **Order Tracking**: Real-time order status and delivery tracking
* **Payment Processing**: Integration with payment gateways

Advanced Features
~~~~~~~~~~~~~~~~

* **Voice Input**: Voice processing capabilities
* **Image Recognition**: Product image analysis
* **Multi-language Support**: Support for multiple languages
* **Real-time Inventory**: Live stock updates
* **Long-term Memory**: Cross-session conversation memory

Getting Help
-----------

* **Documentation**: This comprehensive guide covers all implemented features
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