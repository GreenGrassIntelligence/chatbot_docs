Architecture Overview
====================

This document provides a high-level overview of the e-commerce chatbot's technical architecture, including the system diagram, core principles, and architectural decisions.

System Architecture Diagram
---------------------------

The Enhanced E-commerce Chatbot follows a layered, modular architecture with clear separation of concerns:

.. code-block:: text

   ┌─────────────────────────────────────────────────────────────────────────────┐
   │                              USER INTERFACE LAYER                           │
   └─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
   ┌─────────────────────────────────────────────────────────────────────────────┐
   │                              INPUT PROCESSING                               │
   │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────────────┐  │
   │  │   User Input    │─▶│ Input Validator │─▶│   Security & Sanitization   │  │
   │  │                 │  │                 │  │  • SQL Injection Protection │  │
   │  │                 │  │                 │  │  • XSS Prevention           │  │
   │  │                 │  │                 │  │  • Input Sanitization       │  │
   │  └─────────────────┘  └─────────────────┘  └─────────────────────────────┘  │
   └─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
   ┌──────────────────────────────────────────────────────────────────────────────┐
   │                              NATURAL LANGUAGE UNDERSTANDING (NLU)            │
   │  ┌─────────────────┐  ┌──────────────────┐  ┌─────────────────────────────┐  │
   │  │ Intent Detection│  │ Entity Extraction│  │   Multi-Intent Processing   │  │
   │  │                 │  │                  │  │  • Primary Intent           │  │
   │  │ • Product Info  │  │ • Product Names  │  │  • Secondary Intents        │  │
   │  │ • Product Search│  │ • Quantities     │  │  • Intent Confidence        │  │
   │  │ • Add to Cart   │  │ • Categories     │  │  • Clarification Detection  │  │
   │  │ • View Cart     │  │ • Brands         │  │                             │  │
   │  │ • Order History │  │ • Prices         │  │                             │  │
   │  │ • Price Inquiry │  │ • User Context   │  │                             │  │
   │  │ • Stock Inquiry │  │                  │  │                             │  │
   │  └─────────────────┘  └──────────────────┘  └─────────────────────────────┘  │
   └──────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
   ┌─────────────────────────────────────────────────────────────────────────────┐
   │                              SEARCH & MATCHING ENGINE                       │
   │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────────────┐  │
   │  │  Fuzzy Matcher  │  │ Phonetic Matcher│  │   Partial Matcher           │  │
   │  │                 │  │                 │  │                             │  │
   │  │ • Levenshtein   │  │ • Sound-based   │  │ • Substring Matching        │  │
   │  │ • Typo Tolerance│  │ • Brand Names   │  │ • Case-insensitive          │  │
   │  │ • Configurable  │  │ • Product Names │  │ • Configurable Threshold    │  │
   │  │   Distance      │  │ • Similar Words │  │                             │  │
   │  └─────────────────┘  └─────────────────┘  └─────────────────────────────┘  │
   │                                                                             │
   │  ┌───────────────────────────────────────────────────────────────────────┐  │
   │  │                    RAG (Retrieval Augmented Generation)               │  │
   │  │  • Vector Database (ChromaDB)                                         │  │
   │  │  • Embedding Model (text-embedding-3-small)                           │  │
   │  │  • Semantic Search & Similarity Matching                              │  │
   │  │  • Context-Aware Product Retrieval                                    │  │
   │  └───────────────────────────────────────────────────────────────────────┘  │
   └─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
   ┌──────────────────────────────────────────────────────────────────────────────┐
   │                              CONTEXT & SESSION MANAGEMENT                    │
   │  ┌──────────────────┐  ┌─────────────────┐  ┌─────────────────────────────┐  │
   │  │ Session Manager  │  │ Context Tracker │  │   Conversation Memory       │  │
   │  │                  │  │                 │  │                             │  │
   │  │ • Session Timeout│  │ • User History  │  │ • Multi-turn Context        │  │
   │  │ • Auto Cleanup   │  │ • Preferences   │  │ • Intent Continuity         │  │
   │  │ • Multi-session  │  │ • Cart State    │  │ • Entity Resolution         │  │
   │  │   Support        │  │ • Order History │  │ • Clarification Context     │  │
   │  └──────────────────┘  └─────────────────┘  └─────────────────────────────┘  │
   └──────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
   ┌──────────────────────────────────────────────────────────────────────────────┐
   │                              ACTION EXECUTION LAYER                          │
   │  ┌─────────────────┐  ┌──────────────────┐  ┌─────────────────────────────┐  │
   │  │  Cart Manager   │  │  Order Manager   │  │   Stock Manager             │  │
   │  │                 │  │                  │  │                             │  │
   │  │ • Add Items     │  │ • Order Creation │  │ • Stock Checking            │  │
   │  │ • Remove Items  │  │ • Order Status   │  │ • Stock Reservation         │  │
   │  │ • Update Qty    │  │ • Order History  │  │ • Low Stock Alerts          │  │
   │  │ • Cart Total    │  │ • Invoice Gen    │  │ • Auto Stock Updates        │  │
   │  │ • Cart Cleanup  │  │ • Payment Track  │  │                             │  │
   │  └─────────────────┘  └──────────────────┘  └─────────────────────────────┘  │
   │                                                                              │
   │  ┌─────────────────┐  ┌──────────────────┐  ┌─────────────────────────────┐  │
   │  │ Command Handler │  │ Product Search   │  │   Price Calculator          │  │
   │  │                 │  │                  │  │                             │  │
   │  │ • /cart         │  │ • Field Search   │  │ • Price Calculation         │  │
   │  │ • /verbose      │  │ • Category Filter│  │ • Tax Calculation (10% GST) │  │
   │  │ • /help         │  │ • Price Range    │  │ • Discount Application      │  │
   │  │ • /clear        │  │ • Brand Filter   │  │ • Currency Formatting       │  │
   │  └─────────────────┘  └──────────────────┘  └─────────────────────────────┘  │
   └──────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
   ┌───────────────────────────────────────────────────────────────────────────────┐
   │                              NATURAL LANGUAGE GENERATION (NLG)                │
   │  ┌─────────────────┐  ┌───────────────────┐  ┌─────────────────────────────┐  │
   │  │ Response Gen    │  │ Template Engine   │  │   Context-Aware NLG         │  │
   │  │                 │  │                   │  │                             │  │
   │  │ • Intent-based  │  │ • Prompt Templates│  │ • Personalized Responses    │  │
   │  │ • Entity-aware  │  │ • System Prompts  │  │ • Conversation Continuity   │  │
   │  │ • Context-aware │  │ • Dynamic Prompts │  │ • Multi-language Ready      │  │
   │  │ • Multi-format  │  │ • Response Cache  │  │ • Tone Adaptation           │  │
   │  └─────────────────┘  └───────────────────┘  └─────────────────────────────┘  │
   └───────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
   ┌────────────────────────────────────────────────────────────────────────────────┐
   │                              ANALYTICS & MONITORING                            │
   │  ┌────────────────────┐  ┌─────────────────┐  ┌─────────────────────────────┐  │
   │  │ Analytics Engine   │  │ Cost Tracker    │  │   Performance Monitor       │  │
   │  │                    │  │                 │  │                             │  │
   │  │ • User Interactions│  │ • LLM API Costs │  │ • Response Time Tracking    │  │
   │  │ • Intent Tracking  │  │ • Token Usage   │  │ • Success Rate Monitoring   │  │
   │  │ • Error Tracking   │  │ • Cost per Call │  │ • Resource Usage Tracking   │  │
   │  │ • Conversion Rate  │  │ • Daily/Monthly │  │ • Cache Hit Rate            │  │
   │  │ • User Journey     │  │   Cost Reports  │  │ • Database Query Performance│  │
   │  └────────────────────┘  └─────────────────┘  └─────────────────────────────┘  │
   │                                                                                │
   │  ┌──────────────────────────────────────────────────────────────────────────┐  │
   │  │                    ERROR HANDLING & LOGGING                              │  │
   │  │  • Structured Logging (JSON)                                             │  │
   │  │  • Error Categorization & Classification                                 │  │
   │  │  • Retry Mechanisms with Exponential Backoff                             │  │
   │  │  • User-Friendly Error Messages                                          │  │
   │  │  • Security Event Logging                                                │  │
   │  └──────────────────────────────────────────────────────────────────────────┘  │
   └────────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
   ┌──────────────────────────────────────────────────────────────────────────────┐
   │                              DATA LAYER                                      │
   │  ┌─────────────────┐  ┌──────────────────┐  ┌─────────────────────────────┐  │
   │  │ PostgreSQL DB   │  │   Redis Cache    │  │   Vector Database           │  │
   │  │                 │  │                  │  │   (ChromaDB)                │  │
   │  │ • Products      │  │ • Session Cache  │  │                             │  │
   │  │ • Categories    │  │ • Response Cache │  │ • Product Embeddings        │  │
   │  │ • Users         │  │ • Search Cache   │  │ • Semantic Search Index     │  │
   │  │ • Orders        │  │ • User Cache     │  │ • Similarity Matching       │  │
   │  │ • Cart Items    │  │ • Rate Limiting  │  │ • Context Vectors           │  │
   │  │ • Sessions      │  │ • Analytics Cache│  │                             │  │
   │  │ • Analytics     │  │                  │  │                             │  │
   │  │ • Stock Data    │  │                  │  │                             │  │
   │  └─────────────────┘  └──────────────────┘  └─────────────────────────────┘  │
   └──────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
   ┌─────────────────────────────────────────────────────────────────────────────┐
   │                              EXTERNAL INTEGRATIONS                          │
   │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────────────┐  │
   │  │ LLM Providers   │  │ Payment Gateway │  │   Notification Service      │  │
   │  │                 │  │                 │  │                             │  │
   │  │ • Groq          │  │ • Payment Proc  │  │ • Email Notifications       │  │
   │  │ • OpenAI        │  │ • Order Confirm │  │ • SMS Alerts                │  │
   │  │ • Anthropic     │  │ • Refund Proc   │  │ • Push Notifications        │  │
   │  │ • Ollama        │  │ • Tax Calc      │  │ • Stock Alerts              │  │
   │  └─────────────────┘  └─────────────────┘  └─────────────────────────────┘  │
   └─────────────────────────────────────────────────────────────────────────────┘

Architecture Principles
----------------------

The system follows these key architectural principles:

**Layered Architecture**
   Clear separation between UI, business logic, and data layers for maintainability and testability.

**Modular Design**
   Loosely coupled components that can be developed and tested independently.

**Event-Driven Processing**
   Asynchronous processing for better performance and scalability.

**Configuration-Driven**
   Feature toggles and environment-specific configurations for flexibility.

**Database-First**
   PostgreSQL with connection pooling for reliable data persistence.

**Caching Strategy**
   Multi-level caching (Redis, in-memory) for performance optimization.

**Security by Design**
   Input validation, SQL injection protection, and XSS prevention.

**Observability**
   Comprehensive logging, monitoring, and analytics.

System Characteristics
---------------------

**Asynchronous Processing**
   All I/O operations are asynchronous for better performance and responsiveness.

**Modular Design**
   Components are loosely coupled and independently testable.

**Configuration-Driven**
   YAML-based configuration with environment variable support.

**Database-First**
   PostgreSQL with connection pooling for data persistence.

**Session Management**
   In-memory and database-backed session storage.

**Error Handling**
   Comprehensive error categorization and recovery mechanisms.

**Analytics**
   Real-time performance monitoring and cost tracking.

**Feature Toggles**
   Dynamic feature enablement/disablement.

**RAG Integration**
   Vector database for semantic search and context-aware responses.

Core Components Overview
------------------------

**Natural Language Understanding (NLU)**
   - Intent detection and entity extraction
   - Multi-intent processing
   - Context awareness
   - LLM integration with multiple providers

**Search & Matching Engine**
   - Fuzzy matching with Levenshtein distance
   - Phonetic matching for brand names
   - Partial matching for substrings
   - RAG system with ChromaDB

**Configuration Management**
   - Unified configuration system
   - Type-safe configuration with dataclasses
   - Environment variable support
   - Feature toggles

**Database Management**
   - Connection pooling
   - Async operations
   - Transaction support
   - Error recovery

**Session Management**
   - Multi-session support
   - Context persistence
   - Automatic cleanup
   - Memory optimization

**Action Execution**
   - Cart management
   - Order processing
   - Stock management
   - Command handling

**Analytics & Monitoring**
   - User interaction tracking
   - Cost monitoring
   - Performance metrics
   - Error tracking

Data Flow
---------

1. **User Input**: Natural language input from users
2. **Input Processing**: Validation and sanitization
3. **NLU Processing**: Intent detection and entity extraction
4. **Search & Matching**: Product search using multiple algorithms
5. **Context Management**: Session and conversation state
6. **Action Execution**: Business logic execution
7. **Response Generation**: Natural language response creation
8. **Analytics**: Performance and usage tracking

Technology Stack
---------------

**Backend Framework**
   - FastAPI for high-performance web API
   - Pydantic for data validation
   - SQLAlchemy for database ORM

**Database & Storage**
   - PostgreSQL for relational data
   - Redis for caching and sessions
   - ChromaDB for vector storage

**LLM Integration**
   - OpenAI GPT models
   - Groq for fast inference
   - Anthropic Claude models
   - Ollama for local models

**Search & Matching**
   - Fuzzy matching algorithms
   - Phonetic matching
   - Vector similarity search

**Monitoring & Analytics**
   - Structured logging
   - Performance metrics
   - Cost tracking
   - Error monitoring

**Configuration**
   - YAML configuration files
   - Environment variables
   - Feature toggles
   - Type-safe configuration

For detailed information about specific components, see:

- :doc:`nlu_system` - Natural Language Understanding details
- :doc:`search_engine` - Search and matching algorithms
- :doc:`database_system` - Database architecture and models
- :doc:`session_management` - Session handling and context
- :doc:`configuration_system` - Configuration management
- :doc:`analytics_monitoring` - Analytics and monitoring 