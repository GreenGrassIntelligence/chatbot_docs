Natural Language Understanding (NLU) System
===========================================

This document provides detailed information about the Natural Language Understanding system, including intent detection, entity extraction, and LLM integration.

Overview
--------

The NLU system provides advanced natural language understanding capabilities for the e-commerce chatbot, enabling it to understand user intents, extract entities, and process complex multi-intent requests.

**Location**: `src/llm/`

**Key Components**:
- Intent Detection and Classification
- Entity Extraction and Recognition
- Multi-Intent Processing
- Context Awareness
- LLM Integration with Multiple Providers

Intent Detection
---------------

**Supported Intents**

The system recognizes and processes the following intents:

**Product Information**
   - Detailed product descriptions and specifications
   - Feature comparisons
   - Technical specifications
   - Product reviews and ratings

**Product Search**
   - Flexible search with multiple filters and criteria
   - Category-based search
   - Brand-based search
   - Price range filtering
   - Feature-based search

**Add to Cart**
   - Smart cart management with quantity and variant selection
   - Multiple item addition
   - Quantity specification
   - Variant selection (size, color, etc.)

**View Cart**
   - Cart contents display
   - Total calculation
   - Quantity modification options
   - Item removal

**Order History**
   - Past orders retrieval
   - Order status tracking
   - Reordering capabilities
   - Order details

**Price Inquiry**
   - Price checking and comparison
   - Discount information
   - Tax calculation
   - Currency conversion

**Stock Inquiry**
   - Availability checking
   - Stock notifications
   - Low stock alerts
   - Restock information

**Multi-Intent Processing**

The system supports processing multiple intents in a single user message:

.. code-block:: text

   User: "Show me laptops under $1000 and add the cheapest one to my cart"
   
   Primary Intent: Product Search
   Secondary Intent: Add to Cart
   
   Entities:
   - Category: laptops
   - Price Range: < $1000
   - Action: add cheapest to cart

Entity Extraction
----------------

**Extracted Entities**

**Product Names**
   - Exact product names (e.g., "MacBook Pro")
   - Brand names (e.g., "Apple", "Samsung")
   - Generic product types (e.g., "laptop", "phone")

**Quantities**
   - Numeric quantities (e.g., "2 laptops", "5 pairs")
   - Relative quantities (e.g., "a few", "several")
   - Default quantities (e.g., "add to cart" = 1)

**Categories**
   - Product categories (e.g., "electronics", "clothing")
   - Subcategories (e.g., "gaming laptops", "wireless headphones")
   - Custom categories

**Brands**
   - Brand names (e.g., "Apple", "Samsung", "Nike")
   - Brand variations (e.g., "iPhone" implies "Apple")

**Prices**
   - Exact prices (e.g., "$999")
   - Price ranges (e.g., "under $1000", "between $500 and $1000")
   - Relative prices (e.g., "cheapest", "most expensive")

**User Context**
   - Previous search results
   - Cart contents
   - Order history
   - User preferences

**Entity Recognition Process**

1. **Text Preprocessing**
   - Tokenization
   - Normalization
   - Stop word removal

2. **Pattern Matching**
   - Regular expressions for prices, quantities
   - Dictionary lookups for brands, categories
   - Fuzzy matching for product names

3. **LLM-Based Extraction**
   - Structured output generation
   - Context-aware entity recognition
   - Confidence scoring

4. **Validation and Resolution**
   - Entity validation against database
   - Ambiguity resolution
   - Confidence threshold filtering

LLM Integration
--------------

**Multi-Provider Support**

The system supports multiple LLM providers for flexibility and cost optimization:

**OpenAI**
   - Models: GPT-3.5-turbo, GPT-4
   - Use case: General conversation and complex reasoning
   - Cost: Higher but more capable

**Groq**
   - Models: Llama-3.1-8B, Mixtral-8x7B
   - Use case: Fast inference and cost-effective processing
   - Cost: Lower with good performance

**Anthropic**
   - Models: Claude-3-Haiku, Claude-3-Sonnet
   - Use case: Detailed analysis and reasoning
   - Cost: Moderate with high quality

**Ollama**
   - Models: Local models (Llama, Mistral, etc.)
   - Use case: Privacy-sensitive applications
   - Cost: No API costs, local processing

**LLM Engine Features**

**Cost Tracking**
   - Real-time API cost monitoring
   - Token usage tracking
   - Cost optimization strategies
   - Budget management

**Response Caching**
   - Intelligent caching for repeated queries
   - Cache invalidation strategies
   - Performance optimization

**Retry Logic**
   - Automatic retry with exponential backoff
   - Fallback to alternative providers
   - Error handling and recovery

**Structured Output**
   - JSON schema-based response generation
   - Type-safe response parsing
   - Validation and error handling

**Performance Metrics**
   - Response time tracking
   - Token usage monitoring
   - Success rate tracking
   - Error rate monitoring

Context Awareness
----------------

**Conversation Context**

The NLU system maintains conversation context across multiple turns:

**Intent Continuity**
   - Primary intent tracking
   - Secondary intent management
   - Intent transition detection

**Entity Resolution**
   - Entity reference resolution
   - Pronoun resolution (e.g., "the second one")
   - Contextual entity linking

**Clarification Context**
   - Missing information detection
   - Clarification question generation
   - Context preservation during clarification

**User Preferences**
   - Search history
   - Preferred categories
   - Price range preferences
   - Brand preferences

**Context Management**

.. code-block:: python

   # Example context structure
   conversation_context = {
       'current_intent': 'product_search',
       'search_filters': {
           'category': 'laptops',
           'price_range': {'min': 0, 'max': 1000},
           'brand': 'Apple'
       },
       'recent_products': ['MacBook Pro', 'MacBook Air'],
       'user_preferences': {
           'preferred_categories': ['electronics', 'computers'],
           'price_sensitivity': 'medium'
       },
       'conversation_history': [
           {'user': 'Show me laptops', 'bot': 'Here are some laptops...'},
           {'user': 'What about the second one?', 'bot': 'The second laptop is...'}
       ]
   }

Confidence Scoring
-----------------

**Intent Confidence**

The system provides confidence scores for intent detection:

- **High Confidence (0.8-1.0)**: Clear, unambiguous intent
- **Medium Confidence (0.6-0.8)**: Some ambiguity, may need clarification
- **Low Confidence (0.4-0.6)**: Unclear intent, clarification required
- **Very Low Confidence (<0.4)**: Unable to determine intent

**Entity Confidence**

Entity extraction also includes confidence scoring:

- **Exact Match (1.0)**: Perfect match found
- **Fuzzy Match (0.7-0.9)**: Similar match with high confidence
- **Partial Match (0.5-0.7)**: Partial match with moderate confidence
- **No Match (<0.5)**: No suitable match found

**Confidence-Based Actions**

Based on confidence levels, the system takes different actions:

**High Confidence**
   - Execute action immediately
   - Provide direct response
   - No clarification needed

**Medium Confidence**
   - Execute with confirmation
   - Provide options for clarification
   - Suggest alternatives

**Low Confidence**
   - Request clarification
   - Provide multiple interpretations
   - Ask for more specific information

**Very Low Confidence**
   - Ask for rephrasing
   - Provide help and examples
   - Suggest common intents

Clarification Detection
----------------------

**Missing Information Detection**

The system automatically detects when information is missing:

**Required Entities**
   - Product category for search
   - Quantity for cart operations
   - Product name for specific queries

**Optional Entities**
   - Price range for filtering
   - Brand preferences
   - Specific features

**Clarification Strategies**

**Direct Questions**
   - "Which category of products are you looking for?"
   - "How many would you like to add to your cart?"
   - "Which specific product do you mean?"

**Multiple Choice**
   - "Did you mean laptops, tablets, or phones?"
   - "Which brand: Apple, Samsung, or Dell?"
   - "What price range: under $500, $500-$1000, or over $1000?"

**Examples and Suggestions**
   - "Here are some popular categories: electronics, clothing, books..."
   - "Popular laptop brands include Apple, Dell, HP..."
   - "Price ranges: budget ($0-$500), mid-range ($500-$1000), premium ($1000+)"

Performance Optimization
-----------------------

**Caching Strategies**

**Intent Cache**
   - Cache common intent patterns
   - Reduce LLM API calls
   - Improve response time

**Entity Cache**
   - Cache entity recognition results
   - Store product name mappings
   - Optimize search performance

**Response Cache**
   - Cache similar query responses
   - Reduce processing time
   - Improve user experience

**Optimization Techniques**

**Batch Processing**
   - Process multiple entities together
   - Reduce API calls
   - Improve efficiency

**Parallel Processing**
   - Concurrent entity extraction
   - Parallel intent detection
   - Faster response times

**Lazy Loading**
   - Load context on demand
   - Reduce memory usage
   - Improve startup time

Error Handling
--------------

**Error Categories**

**Input Errors**
   - Malformed input
   - Unsupported languages
   - Invalid characters

**Processing Errors**
   - LLM API failures
   - Timeout errors
   - Rate limiting

**Entity Errors**
   - Entity not found
   - Ambiguous entities
   - Invalid entity types

**Error Recovery**

**Graceful Degradation**
   - Fallback to simpler processing
   - Use cached responses
   - Provide helpful error messages

**Retry Mechanisms**
   - Exponential backoff
   - Alternative provider fallback
   - Circuit breaker pattern

**User Communication**
   - Clear error messages
   - Suggested alternatives
   - Help and guidance

Integration Points
-----------------

**Search Engine Integration**
   - Pass extracted entities to search
   - Provide search context
   - Handle search results

**Session Management**
   - Store conversation context
   - Retrieve user preferences
   - Maintain session state

**Database Integration**
   - Validate entities against database
   - Retrieve product information
   - Update user preferences

**Analytics Integration**
   - Track intent patterns
   - Monitor entity extraction accuracy
   - Measure system performance

For more information about related components, see:

- :doc:`search_engine` - Search and matching algorithms
- :doc:`session_management` - Session handling and context
- :doc:`configuration_system` - Configuration management
- :doc:`analytics_monitoring` - Analytics and monitoring 