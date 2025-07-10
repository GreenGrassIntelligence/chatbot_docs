Getting Started Guide
====================

Welcome to the E-commerce Chatbot! This guide will help you get up and running quickly.

Overview
--------

The e-commerce chatbot is an intelligent assistant that helps users:
- Search for products
- Get product information
- Manage shopping carts
- Check order status
- Get pricing and availability

Quick Start
----------

**1. Start the Chatbot**

.. code-block:: bash

   python src/main.py

**2. Access the Interface**

Open your web browser and navigate to:
- **Local**: http://localhost:8000
- **API Documentation**: http://localhost:8000/docs

**3. Start a Conversation**

Send your first message to the chatbot:

.. code-block:: text

   User: "Hello, I'm looking for laptops"

First Steps
-----------

**Basic Interaction**

The chatbot understands natural language. Try these examples:

.. code-block:: text

   User: "Show me laptops under $1000"
   Bot: "I found several laptops under $1000. Here are some options..."

   User: "What's the price of the MacBook Pro?"
   Bot: "The MacBook Pro is priced at $1,299. Would you like to add it to your cart?"

   User: "Add 2 laptops to my cart"
   Bot: "I've added 2 laptops to your cart. Your cart total is $2,598."

**Using Commands**

The chatbot supports special commands:

.. code-block:: text

   /cart - View your current cart
   /help - Show available commands
   /clear - Clear your cart
   /verbose - Enable detailed responses

Product Search
-------------

**Search by Category**

.. code-block:: text

   User: "Show me electronics"
   User: "I want to see clothing"
   User: "What kitchen appliances do you have?"

**Search by Brand**

.. code-block:: text

   User: "Show me Apple products"
   User: "What Samsung phones do you have?"
   User: "I'm looking for Nike shoes"

**Search by Price Range**

.. code-block:: text

   User: "Show me products under $50"
   User: "What's available between $100 and $500?"
   User: "Show me expensive items over $1000"

**Search by Features**

.. code-block:: text

   User: "I need a laptop with 16GB RAM"
   User: "Show me wireless headphones"
   User: "I want a camera with 4K video"

Cart Management
--------------

**Adding Items**

.. code-block:: text

   User: "Add a laptop to my cart"
   User: "I want 3 pairs of shoes"
   User: "Add the iPhone to my cart"

**Viewing Cart**

.. code-block:: text

   User: "What's in my cart?"
   User: "Show me my cart"
   User: "/cart"

**Updating Quantities**

.. code-block:: text

   User: "Change the laptop quantity to 2"
   User: "I want 5 pairs of shoes instead"
   User: "Update the phone quantity to 1"

**Removing Items**

.. code-block:: text

   User: "Remove the laptop from my cart"
   User: "Take out the shoes"
   User: "Delete the phone"

**Clearing Cart**

.. code-block:: text

   User: "Clear my cart"
   User: "Empty my cart"
   User: "/clear"

Product Information
------------------

**Getting Details**

.. code-block:: text

   User: "Tell me about the MacBook Pro"
   User: "What are the specs of this laptop?"
   User: "Show me the features of the iPhone"

**Price Inquiries**

.. code-block:: text

   User: "How much does the laptop cost?"
   User: "What's the price of the iPhone?"
   User: "Tell me the cost of the shoes"

**Availability Check**

.. code-block:: text

   User: "Is the laptop in stock?"
   User: "Do you have the iPhone available?"
   User: "Check if the shoes are available"

**Stock Information**

.. code-block:: text

   User: "How many laptops do you have?"
   User: "What's the stock level of the iPhone?"
   User: "Tell me the inventory of shoes"

Order Management
---------------

**Checking Order Status**

.. code-block:: text

   User: "What's the status of my order?"
   User: "Check my order #12345"
   User: "Where is my package?"

**Order History**

.. code-block:: text

   User: "Show me my order history"
   User: "What have I ordered before?"
   User: "List my previous orders"

Advanced Features
----------------

**Fuzzy Search**

The chatbot can handle typos and similar words:

.. code-block:: text

   User: "Show me laptps" (typo for laptops)
   User: "I want a labtop" (similar word)
   User: "Show me phon" (partial word)

**Context Awareness**

The chatbot remembers previous conversation:

.. code-block:: text

   User: "Show me laptops"
   Bot: "Here are some laptops..."
   User: "What about the second one?"
   Bot: "The second laptop is the MacBook Air..."

**Multi-Intent Processing**

Handle complex requests:

.. code-block:: text

   User: "Show me laptops under $1000 and add the cheapest one to my cart"
   User: "I want to see phones, and tell me which one has the best camera"

Troubleshooting
--------------

**Common Issues:**

- **No response**: Check if the chatbot is running
- **Wrong products**: Try more specific search terms
- **Cart issues**: Use `/cart` to check current state
- **Slow responses**: Check your internet connection

**Getting Help:**

.. code-block:: text

   User: "/help"
   User: "What can you do?"
   User: "Show me available commands"

**Resetting Session:**

.. code-block:: text

   User: "/clear"
   User: "Start over"
   User: "Reset my session"

Best Practices
-------------

1. **Be specific**: "Show me gaming laptops" instead of "Show me computers"
2. **Use natural language**: "I want a laptop under $1000" works better than "laptop < $1000"
3. **Check your cart**: Use `/cart` regularly to see what you've added
4. **Ask for details**: Request specific information about products
5. **Use commands**: Leverage `/help`, `/cart`, and `/clear` for quick actions

Next Steps
----------

Now that you're familiar with the basics:

1. Explore :doc:`chatbot_capabilities` for advanced features
2. Check :doc:`quick_reference` for a quick command reference
3. Read :doc:`validation_guide` to test the system
4. Review :doc:`../development/technical_architecture` for technical details

Need Help?
----------

If you encounter issues:

1. Check the troubleshooting section above
2. Use the `/help` command
3. Review the validation guide
4. Check the technical documentation 