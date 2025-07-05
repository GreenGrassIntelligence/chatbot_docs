Quick Reference Guide
====================

.. _quick-reference:

This quick reference guide provides a concise overview of what's actually implemented and working in the e-commerce chatbot.

This quick reference guide provides a concise overview of what's actually implemented and working in the e-commerce chatbot.

What Works Right Now
-------------------

✅ **Core Functionality**
   - Multi-intent message processing
   - Intent and entity extraction
   - Missing information detection
   - Conversation context management

✅ **Product Operations**
   - Product information queries
   - Product search with filters
   - Product comparisons
   - Price and stock inquiries

✅ **Cart Management**
   - Add items to cart
   - View cart contents
   - Remove items from cart
   - Update quantities

✅ **Search & Matching**
   - Fuzzy search for product names
   - Phonetic matching
   - Pattern matching with wildcards
   - Multi-field search

✅ **Commands**
   - `/cart` - Show current cart status
   - `/verbose` - Toggle detailed processing info

✅ **Analytics**
   - Interaction tracking
   - Performance monitoring
   - Cost tracking for LLM calls

What Doesn't Work Yet
--------------------

❌ **Order Processing**
   - Cannot actually place orders
   - No payment processing
   - No order tracking

❌ **Real Data**
   - Uses sample products only
   - No live inventory
   - No real database connection

❌ **Advanced Features**
   - No voice input
   - No image recognition
   - No multi-language support

Quick Start Commands
-------------------

.. code-block:: bash

    # Install dependencies
    pip install -r requirements.txt
    
    # Set up environment
    cp env.example .env
    # Add your GROQ_API_KEY to .env
    
    # Run the chatbot
    python src/main.py
    
    # Test the system
    python test_chatbot.py

Example Conversations
--------------------

**Product Information:**
.. code-block:: text

    User: "Tell me about Amul ghee"
    Bot: [Provides detailed product information]

**Product Search:**
.. code-block:: text

    User: "Find organic products under ₹500"
    Bot: [Lists matching products with prices]

**Multi-Intent:**
.. code-block:: text

    User: "Compare Amul and Patanjali ghee, then add the cheaper one to cart"
    Bot: [Compares products and adds to cart]

**Cart Operations:**
.. code-block:: text

    User: "Add 2 liters of organic milk to cart"
    Bot: [Adds to cart and shows updated total]

**Clarification:**
.. code-block:: text

    User: "I want to buy ghee"
    Bot: "Which brand? Amul, Patanjali, or Mother Dairy?"

**Commands:**
.. code-block:: text

    User: "/cart"
    Bot: [Shows current cart status]

    User: "/verbose"
    Bot: [Enables detailed processing information]

Supported Intents
----------------

✅ **Implemented:**
- `product_info` - Get product details
- `product_search` - Search for products
- `product_comparison` - Compare products
- `add_to_cart` - Add to shopping cart
- `view_cart` - View cart contents
- `remove_from_cart` - Remove from cart
- `price_inquiry` - Check prices
- `stock_inquiry` - Check availability
- `order_history` - View past orders
- `general_query` - General questions
- `greeting` - Handle greetings
- `goodbye` - Handle farewells

❌ **Not Implemented:**
- `place_order` - Order placement
- `order_status` - Order tracking
- `payment_processing` - Payment handling

Configuration
-------------

**Required Environment Variables:**
.. code-block:: text

    GROQ_API_KEY=your_groq_api_key_here

**Optional Configuration:**
- Database settings (PostgreSQL)
- Redis settings (for caching)
- Logging configuration
- Performance settings

File Structure
-------------

.. code-block:: text

    src/
    ├── main.py                 # Main chatbot application
    ├── llm/                    # LLM integration
    ├── search/                 # Search engine
    ├── commands/               # Command system
    ├── analytics/              # Analytics engine
    ├── session/                # Session management
    ├── database/               # Database operations
    ├── models/                 # Data models
    └── utils/                  # Utilities

    tests/
    ├── data/                   # Test data
    ├── validation/             # Validation tests
    └── benchmarking/           # Performance tests

    docs/                       # Documentation
    config/                     # Configuration files

Troubleshooting
--------------

**Common Issues:**

1. **API Key Missing**
   - Ensure GROQ_API_KEY is set in .env file
   - Verify API key is valid and has credits

2. **Import Errors**
   - Install all dependencies: `pip install -r requirements.txt`
   - Check Python version (3.8+ required)

3. **Database Connection**
   - Database manager exists but uses sample data
   - No real database connection required for basic functionality

4. **Performance Issues**
   - System is in development, not optimized for production
   - Use `/verbose` command to see processing details

**Getting Help:**
- Check `docs/implementation_status.rst` for detailed feature status
- Review `docs/documentation_audit_summary.rst` for known limitations
- Run `python test_chatbot.py` to test functionality

Development Status
-----------------

**Current Phase:** Development/Testing
**Next Phase:** Order Processing Implementation
**Production Ready:** No (uses sample data)

**Key Limitations:**
- Sample data only (no real products)
- No actual order processing
- No payment integration
- Development environment only

**Strengths:**
- Solid multi-intent processing
- Good fuzzy search capabilities
- Comprehensive analytics
- Extensible architecture

This quick reference provides the essential information needed to understand and use the chatbot in its current state. For detailed information, refer to the full documentation. 