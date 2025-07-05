# E-commerce Chatbot - Production Grade Solution

A comprehensive, production-grade e-commerce chatbot built with LLM, RAG, and PostgreSQL. Features advanced intent detection, entity extraction, analytics tracking, and cost monitoring.

## 🚀 Features

- **Advanced LLM Integration**: Support for Groq, OpenAI, Anthropic, and Ollama
- **Intent & Entity Extraction**: Robust detection with confidence scoring
- **RAG (Retrieval Augmented Generation)**: For product descriptions and FAQs
- **PostgreSQL Database**: Structured data for products, orders, users, analytics
- **Redis Caching**: Fast session management and response caching
- **Analytics Engine**: Comprehensive tracking of interactions, costs, and performance
- **Cost Monitoring**: Real-time tracking of LLM API costs
- **Session Management**: Multi-turn conversation support
- **Modular Architecture**: Clean, maintainable, and extensible codebase

## 📋 Prerequisites

- Python 3.8+
- PostgreSQL 12+
- Redis 6+
- Docker (optional, for containerized deployment)

## 🛠️ Installation

### 1. Clone the Repository

```bash
git clone <repository-url>
cd chatbot-core
```

### 2. Create Virtual Environment

```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

### 3. Install Dependencies

```bash
pip install -r requirements.txt
```

### 4. Environment Configuration

Create a `.env` file in the root directory:

```bash
# Environment
ENV=development

# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_USER=postgres
DB_PASSWORD=your_password
DB_NAME=ecommerce_dev

# Redis Configuration
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=

# LLM Configuration
GROQ_API_KEY=gsk_your_groq_api_key_here
OPENAI_API_KEY=sk-your_openai_api_key_here
ANTHROPIC_API_KEY=sk-ant-your_anthropic_api_key_here

# Celery Configuration (for async tasks)
CELERY_BROKER_URL=redis://localhost:6379/0
CELERY_RESULT_BACKEND=redis://localhost:6379/0

# Optional: Vector Database (for RAG)
PINECONE_API_KEY=your_pinecone_api_key
PINECONE_ENVIRONMENT=your_pinecone_environment
```

### 5. Database Setup

```bash
# Create database
createdb ecommerce_dev

# Run database migrations
psql -d ecommerce_dev -f src/models/database_schema.sql
```

### 6. Redis Setup

```bash
# Start Redis server
redis-server

# Or using Docker
docker run -d -p 6379:6379 redis:6-alpine
```

## 📁 Project Structure

```
chatbot-core/
├── src/
│   ├── config.py                 # Configuration management
│   ├── models/
│   │   ├── __init__.py
│   │   ├── data_models.py        # Pydantic data models
│   │   ├── session_models.py     # Session management
│   │   └── database_schema.sql   # Database schema
│   ├── llm/
│   │   ├── enhanced_llm_core.py  # Advanced LLM engine
│   │   └── intent_extraction.py  # Intent/entity extraction
│   └── analytics/
│       ├── __init__.py
│       └── analytics_engine.py   # Analytics tracking
├── requirements.txt
├── .env.example
└── README.md
```

## 🔧 Configuration

### Environment-Specific Configs

The system supports three environments:

1. **Development** (`ENV=development`)
   - Local database and Redis
   - Debug mode enabled
   - Higher temperature for LLM responses

2. **Staging** (`ENV=staging`)
   - Staging database
   - Moderate temperature
   - Basic monitoring

3. **Production** (`ENV=production`)
   - Production database with connection pooling
   - Lower temperature for consistent responses
   - Full monitoring and cost tracking

### LLM Provider Configuration

```python
from src.config import config

# Access LLM configuration
llm_config = config.llm
print(f"Provider: {llm_config.provider}")
print(f"Model: {llm_config.model}")
print(f"Temperature: {llm_config.temperature}")
```

## 🚀 Usage Examples

### 1. Basic Chatbot Usage

```python
from src.llm.enhanced_llm_core import llm_engine
from src.llm.intent_extraction import extract_intent_entities
from src.analytics import analytics_engine

# Initialize analytics
analytics = analytics_engine

# Process user message
user_message = "I want to buy organic milk"
user_id = "user123"
session_id = "session456"

# Start tracking interaction
interaction_id = analytics.start_interaction(user_id, session_id, user_message)

try:
    # Extract intent and entities
    intent_data, clarification = extract_intent_entities(user_message, user_id)
    
    if clarification:
        response = f"I need more information: {clarification}"
    else:
        # Track intent detection
        analytics.track_intent_detection(interaction_id, intent_data)
        
        # Generate response based on intent
        if intent_data.intent_type.value == "product_search":
            response = "I found several organic milk options for you..."
        else:
            response = "I understand you're looking for organic milk. Let me help you with that."
    
    # Track response
    analytics.track_response_generated(interaction_id, response)
    
except Exception as e:
    analytics.track_error(interaction_id, str(e))
    response = "Sorry, I encountered an error. Please try again."

# End interaction tracking
metrics = analytics.end_interaction(interaction_id)
print(f"Interaction completed in {metrics.total_processing_time_ms}ms")
```

### 2. Advanced LLM Usage

```python
from src.llm.enhanced_llm_core import llm_engine, prompt_manager

# Simple LLM call
response = llm_engine.invoke(
    "What are the health benefits of organic milk?",
    user_id="user123"
)

# Structured output
structured_response = llm_engine.invoke_structured(
    "Compare organic milk vs regular milk",
    output_schema={
        "type": "object",
        "properties": {
            "differences": {"type": "array"},
            "recommendation": {"type": "string"}
        }
    }
)

# Using prompt templates
response = llm_engine.invoke(
    prompt_manager.format_template(
        "product_info",
        product_name="Organic Milk",
        product_details="Fresh organic milk from local farms",
        user_question="What are the ingredients?"
    )
)
```

### 3. Analytics and Monitoring

```python
from src.analytics import analytics_engine

# Get user analytics
user_analytics = analytics_engine.get_user_analytics("user123", days=30)
print(f"User total cost: ${user_analytics['total_cost']:.4f}")

# Get system analytics
system_analytics = analytics_engine.get_system_analytics(days=7)
print(f"System total interactions: {system_analytics['total_interactions']}")

# Performance summary
from src.llm.enhanced_llm_core import llm_engine
performance = llm_engine.get_performance_summary()
print(f"Average response time: {performance['average_response_time']}ms")
```

## 📊 Analytics Dashboard

The analytics engine tracks:

- **User Interactions**: Message content, timestamps, processing time
- **Intent Detection**: Detected intents, confidence scores, entities
- **Actions Performed**: Business logic actions, parameters, results
- **Cost Tracking**: Token usage, API costs per user/session
- **Performance Metrics**: Response times, cache hits, error rates
- **Session Data**: Conversation flow, context management

## 🔍 Intent Types Supported

- `product_info`: Product information requests
- `product_search`: Product search queries
- `product_comparison`: Product comparison requests
- `add_to_cart`: Add items to shopping cart
- `remove_from_cart`: Remove items from cart
- `update_cart`: Update cart quantities
- `view_cart`: View current cart
- `place_order`: Place orders
- `order_history`: View order history
- `order_status`: Check order status
- `price_inquiry`: Price-related questions
- `stock_inquiry`: Stock availability questions
- `promotion_inquiry`: Promotion and discount questions
- `general_query`: General questions
- `greeting`: Greeting messages
- `goodbye`: Farewell messages
- `help`: Help requests
- `clarification`: Clarification requests
- `incomplete_query`: Incomplete or unclear queries

## 🛡️ Error Handling

The system includes comprehensive error handling:

- **LLM Failures**: Automatic retry with exponential backoff
- **Database Errors**: Graceful fallbacks and logging
- **Invalid Inputs**: Input validation and user-friendly error messages
- **Rate Limiting**: Built-in rate limiting for API calls
- **Session Timeouts**: Automatic session cleanup

## 🚀 Deployment

### Docker Deployment

```dockerfile
FROM python:3.9-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY src/ ./src/
COPY .env .

CMD ["python", "-m", "src.main"]
```

### Environment Variables for Production

```bash
# Production environment
ENV=production

# Database with connection pooling
DB_HOST=your_prod_db_host
DB_POOL_SIZE=50
DB_MAX_OVERFLOW=100

# Redis cluster
REDIS_HOST=your_redis_cluster
REDIS_PASSWORD=your_redis_password

# LLM with lower temperature for consistency
GROQ_API_KEY=your_prod_groq_key
LLM_TEMPERATURE=0.3

# Monitoring
ENABLE_COST_TRACKING=true
ENABLE_PERFORMANCE_MONITORING=true
```

## 📈 Performance Optimization

- **Response Caching**: Frequently asked questions cached in Redis
- **Connection Pooling**: Database connection pooling for high concurrency
- **Async Processing**: Non-blocking LLM calls for better responsiveness
- **Batch Processing**: Batch analytics updates for better performance
- **Memory Management**: Automatic cleanup of old sessions and cache entries

## 🔧 Development

### Running Tests

```bash
# Install test dependencies
pip install pytest pytest-asyncio

# Run tests
pytest tests/
```

### Code Quality

```bash
# Install development dependencies
pip install black flake8 mypy

# Format code
black src/

# Lint code
flake8 src/

# Type checking
mypy src/
```

### Adding New Intents

1. Add intent type to `IntentType` enum in `src/models/data_models.py`
2. Update system prompt in `src/llm/intent_extraction.py`
3. Implement handler in your action engine
4. Add tests for the new intent

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Check the documentation
- Review the example code

## 🔄 Changelog

### v1.0.0
- Initial release with core functionality
- LLM integration with multiple providers
- Intent and entity extraction
- Analytics and cost tracking
- Session management
- Database schema and models 