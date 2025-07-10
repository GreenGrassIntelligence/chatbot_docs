User Guide
==========

This comprehensive guide covers all aspects of using the e-commerce chatbot, from basic interactions to advanced features.

Table of Contents
----------------

1. :ref:`basic-interaction`
2. :ref:`product-search`
3. :ref:`cart-management`
4. :ref:`order-management`
5. :ref:`advanced-features`
6. :ref:`commands-reference`
7. :ref:`troubleshooting`

.. _basic-interaction:

Basic Interaction
----------------

**Starting a Conversation**

The chatbot responds to natural language. You can start with:

.. code-block:: text

   User: "Hello"
   Bot: "Hello! I'm your e-commerce assistant. How can I help you today?"

   User: "Hi, I'm looking for some products"
   Bot: "Great! I can help you find products, check prices, manage your cart, and more. What are you looking for?"

**Understanding Responses**

The chatbot provides structured responses:

.. code-block:: text

   User: "Show me laptops"
   Bot: "I found 15 laptops in our catalog:
   
   1. MacBook Pro - $1,299 (In Stock: 5)
   2. Dell XPS 13 - $999 (In Stock: 3)
   3. HP Pavilion - $799 (In Stock: 8)
   
   Would you like to see more details about any of these?"

**Asking for Help**

.. code-block:: text

   User: "What can you do?"
   Bot: "I can help you with:
   • Search for products by category, brand, price, or features
   • Get detailed product information and pricing
   • Add items to your cart and manage quantities
   • Check stock availability
   • View order history and status
   • Use special commands like /cart, /help, /clear
   
   What would you like to do?"

.. _product-search:

Product Search
-------------

**Search by Category**

.. code-block:: text

   User: "Show me electronics"
   Bot: "Here are our electronics categories:
   • Laptops & Computers
   • Smartphones & Tablets
   • Audio & Headphones
   • Cameras & Photography
   • Gaming & Accessories
   
   Which category interests you?"

   User: "I want laptops"
   Bot: "I found 15 laptops available. Here are some options..."

**Search by Brand**

.. code-block:: text

   User: "Show me Apple products"
   Bot: "Here are our Apple products:
   
   1. iPhone 15 Pro - $999
   2. MacBook Pro - $1,299
   3. iPad Air - $599
   4. Apple Watch - $399
   
   Which product would you like to know more about?"

**Search by Price Range**

.. code-block:: text

   User: "Show me products under $500"
   Bot: "I found 45 products under $500:
   
   1. Wireless Earbuds - $89
   2. Smart Watch - $199
   3. Bluetooth Speaker - $79
   4. Phone Case - $29
   
   Would you like to see more or filter by category?"

**Search by Features**

.. code-block:: text

   User: "I need a laptop with 16GB RAM"
   Bot: "I found 8 laptops with 16GB RAM:
   
   1. MacBook Pro - $1,299 (16GB RAM, 512GB SSD)
   2. Dell XPS 15 - $1,199 (16GB RAM, 1TB SSD)
   3. HP Envy - $999 (16GB RAM, 512GB SSD)
   
   Which one would you like to know more about?"

**Combined Search**

.. code-block:: text

   User: "Show me Apple laptops under $1500"
   Bot: "I found 2 Apple laptops under $1500:
   
   1. MacBook Air - $1,099 (8GB RAM, 256GB SSD)
   2. MacBook Pro - $1,299 (8GB RAM, 256GB SSD)
   
   Both are in stock and ready to ship!"

.. _cart-management:

Cart Management
--------------

**Adding Items**

.. code-block:: text

   User: "Add the MacBook Pro to my cart"
   Bot: "I've added the MacBook Pro ($1,299) to your cart. Your cart total is now $1,299."

   User: "I want 3 pairs of wireless headphones"
   Bot: "I've added 3 pairs of wireless headphones ($89 each) to your cart. Your cart total is now $1,566."

**Viewing Cart**

.. code-block:: text

   User: "What's in my cart?"
   Bot: "Your cart contains:
   
   1. MacBook Pro - $1,299 (Qty: 1)
   2. Wireless Headphones - $89 (Qty: 3)
   
   Cart Total: $1,566
   Items: 4
   
   Would you like to checkout or add more items?"

**Updating Quantities**

.. code-block:: text

   User: "Change the headphones quantity to 2"
   Bot: "I've updated the wireless headphones quantity from 3 to 2. Your cart total is now $1,477."

   User: "I want 5 laptops instead of 1"
   Bot: "I've updated the MacBook Pro quantity from 1 to 5. Your cart total is now $6,485."

**Removing Items**

.. code-block:: text

   User: "Remove the headphones from my cart"
   Bot: "I've removed the wireless headphones from your cart. Your cart total is now $1,299."

   User: "Take out the laptop"
   Bot: "I've removed the MacBook Pro from your cart. Your cart is now empty."

**Clearing Cart**

.. code-block:: text

   User: "Clear my cart"
   Bot: "I've cleared your cart. You can start shopping again!"

.. _order-management:

Order Management
---------------

**Checking Order Status**

.. code-block:: text

   User: "What's the status of my order?"
   Bot: "Your most recent order #12345 is currently 'In Transit' and expected to arrive on Friday, December 15th."

   User: "Check order #12345"
   Bot: "Order #12345 Details:
   • Status: In Transit
   • Order Date: December 10, 2024
   • Expected Delivery: December 15, 2024
   • Items: MacBook Pro, Wireless Headphones
   • Total: $1,388"

**Order History**

.. code-block:: text

   User: "Show me my order history"
   Bot: "Here are your recent orders:
   
   1. Order #12345 (Dec 10) - $1,388 - In Transit
   2. Order #12340 (Dec 5) - $599 - Delivered
   3. Order #12335 (Nov 28) - $299 - Delivered
   
   Would you like details about any specific order?"

.. _advanced-features:

Advanced Features
----------------

**Fuzzy Search**

The chatbot handles typos and similar words:

.. code-block:: text

   User: "Show me laptps" (typo)
   Bot: "I assume you meant 'laptops'. Here are our laptops..."

   User: "I want a labtop" (similar word)
   Bot: "I found laptops that match your search. Here are some options..."

   User: "Show me phon" (partial word)
   Bot: "I found phones that match your search. Here are our smartphones..."

**Context Awareness**

The chatbot remembers conversation context:

.. code-block:: text

   User: "Show me laptops under $1000"
   Bot: "I found 8 laptops under $1000..."
   User: "What about the second one?"
   Bot: "The second laptop is the Dell XPS 13 at $999. It features..."

**Multi-Intent Processing**

Handle complex requests:

.. code-block:: text

   User: "Show me laptops and add the cheapest one to my cart"
   Bot: "I found 15 laptops. The cheapest is the HP Pavilion at $799. I've added it to your cart. Your cart total is now $799."

   User: "I want to see phones and tell me which has the best camera"
   Bot: "Here are our smartphones:
   
   1. iPhone 15 Pro - $999 (Best camera: 48MP main, 12MP ultra-wide)
   2. Samsung Galaxy S24 - $899 (Good camera: 50MP main)
   3. Google Pixel 8 - $699 (Excellent camera: 50MP main)
   
   The iPhone 15 Pro has the best camera with advanced features."

**Smart Recommendations**

.. code-block:: text

   User: "I'm looking for a laptop for gaming"
   Bot: "For gaming, I recommend laptops with dedicated graphics cards. Here are some options:
   
   1. ASUS ROG Strix - $1,299 (RTX 4060, 16GB RAM)
   2. MSI Katana - $1,199 (RTX 4050, 16GB RAM)
   3. Lenovo Legion - $1,399 (RTX 4070, 16GB RAM)
   
   These are optimized for gaming performance."

.. _commands-reference:

Commands Reference
-----------------

**Available Commands**

.. code-block:: text

   /cart - View your current cart contents and total
   /help - Show available commands and features
   /clear - Clear all items from your cart
   /verbose - Enable detailed responses with more information
   /status - Check your order status
   /history - View your order history

**Using Commands**

.. code-block:: text

   User: "/cart"
   Bot: "Your cart contains:
   1. MacBook Pro - $1,299 (Qty: 1)
   2. Wireless Headphones - $89 (Qty: 2)
   
   Cart Total: $1,477"

   User: "/help"
   Bot: "Available commands:
   • /cart - View your cart
   • /help - Show this help
   • /clear - Clear your cart
   • /verbose - Enable detailed responses
   • /status - Check order status
   • /history - View order history"

   User: "/clear"
   Bot: "I've cleared your cart. You can start shopping again!"

.. _troubleshooting:

Troubleshooting
--------------

**Common Issues and Solutions**

**No Response from Chatbot**

.. code-block:: text

   Problem: Chatbot doesn't respond
   Solution: 
   - Check if the application is running
   - Verify your internet connection
   - Try refreshing the page
   - Restart the application if needed

**Wrong Search Results**

.. code-block:: text

   Problem: Search returns irrelevant products
   Solution:
   - Use more specific search terms
   - Try different keywords
   - Use category-based search
   - Check spelling and try synonyms

**Cart Issues**

.. code-block:: text

   Problem: Items not adding to cart correctly
   Solution:
   - Use /cart to check current state
   - Try adding items one at a time
   - Use clear product names
   - Check if items are in stock

**Slow Performance**

.. code-block:: text

   Problem: Responses are slow
   Solution:
   - Check your internet connection
   - Try simpler queries
   - Avoid very broad searches
   - Contact support if persistent

**Getting Help**

.. code-block:: text

   User: "I'm having trouble with the search"
   Bot: "I'm here to help! Could you tell me:
   • What you're trying to search for?
   • What results you're getting?
   • What you expected to see?
   
   This will help me assist you better."

**Best Practices**

1. **Be Specific**: "Show me gaming laptops under $1000" instead of "Show me computers"
2. **Use Natural Language**: "I want a laptop for work" works better than "laptop work"
3. **Check Your Cart**: Use `/cart` regularly to verify items
4. **Ask for Details**: Request specific information about products
5. **Use Commands**: Leverage `/help`, `/cart`, and `/clear` for quick actions
6. **Provide Feedback**: Let the chatbot know if results aren't what you expected

**Advanced Tips**

1. **Combine Filters**: "Show me Apple laptops under $1500 with 16GB RAM"
2. **Use Context**: Reference previous products in conversation
3. **Ask for Recommendations**: "What's the best laptop for my needs?"
4. **Check Availability**: Always verify stock before adding to cart
5. **Use Commands Efficiently**: `/cart` and `/clear` for quick cart management

Need More Help?
--------------

If you need additional assistance:

1. Use the `/help` command for quick reference
2. Check the :doc:`getting_started` guide for basics
3. Review the :doc:`quick_reference` for commands
4. Run the :doc:`validation_guide` to test features
5. Contact support with specific issues 