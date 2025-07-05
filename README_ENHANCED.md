# 🛒 Enhanced E-commerce Chatbot System

A comprehensive, production-ready e-commerce chatbot with database integration, cart management, order processing, and advanced features.

## 🚀 **New Features & Improvements**

### **✅ Database Integration (PostgreSQL)**
- **Real-time data persistence** with PostgreSQL
- **Connection pooling** for optimal performance
- **Comprehensive schema** with products, users, cart, orders, sessions
- **Stock management** with transaction tracking
- **Analytics and chat history** storage

### **✅ Cart Management**
- **Persistent shopping cart** with database storage
- **Real-time cart updates** and synchronization
- **Quantity management** with validation
- **Cart cleanup** and expiration handling
- **Multi-session cart support**

### **✅ Order Processing**
- **Complete order lifecycle** management
- **PDF invoice generation** with professional templates
- **Stock reservation** and automatic updates
- **Order status tracking** and updates
- **Payment status management**

### **✅ User Session Management**
- **Session persistence** with database storage
- **Conversation context** tracking
- **Session timeout** and cleanup
- **Multi-session support** per user
- **Context-aware responses**

### **✅ Real-time Stock Management**
- **Live stock tracking** with database updates
- **Stock reservation** for orders
- **Low stock alerts** and notifications
- **Stock transaction history**
- **Automatic stock updates**

### **✅ Enhanced Error Handling**
- **Comprehensive error categorization**
- **Retry mechanisms** with exponential backoff
- **User-friendly error messages**
- **Error logging** and monitoring
- **Graceful degradation**

### **✅ Input Validation & Security**
- **SQL injection protection**
- **XSS attack prevention**
- **Input sanitization** and validation
- **Rate limiting** support
- **Security event logging**

### **✅ Configuration Management**
- **YAML-based configuration** system
- **Environment-specific** settings
- **Dynamic configuration** loading
- **Environment variable** support
- **Centralized settings** management

### **✅ Enhanced Logging**
- **Structured logging** with JSON format
- **Log rotation** and file management
- **Performance metrics** tracking
- **Security event** logging
- **User interaction** logging

### **✅ Currency Standardization**
- **Indian Rupee (₹)** as default currency
- **Currency formatting** and display
- **Price validation** and calculations
- **Tax calculations** (10% GST)
- **Multi-currency** support ready

## 🏗️ **System Architecture**

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   User Input    │───▶│  Input Validator │───▶│  Session Manager │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                │                       │
                                ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  Error Handler  │◀───│  LLM Processor  │───▶│  Cart Manager   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                │                       │
                                ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│ Invoice Generator│    │ Database Manager│    │ Stock Manager   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                │
                                ▼
                       ┌─────────────────┐
                       │   PostgreSQL    │
                       │   Database      │
                       └─────────────────┘
```

## 📋 **Prerequisites**

### **System Requirements**
- Python 3.8+
- PostgreSQL 12+
- Redis (optional, for caching)
- 2GB RAM minimum
- 1GB disk space

### **Python Dependencies**
```bash
pip install -r requirements.txt
```

### **Database Setup**
1. **Install PostgreSQL**
   ```bash
   # Ubuntu/Debian
   sudo apt-get install postgresql postgresql-contrib
   
   # macOS
   brew install postgresql
   ```

2. **Create Database**
   ```sql
   CREATE DATABASE ecommerce_chatbot;
   CREATE USER chatbot_user WITH PASSWORD 'chatbot_password';
   GRANT ALL PRIVILEGES ON DATABASE ecommerce_chatbot TO chatbot_user;
   ```

3. **Initialize Schema**
   ```bash
   # The system will automatically create tables on first run
   python test_enhanced_system.py
   ```

## ⚙️ **Configuration**

### **Environment Variables**
Create a `.env` file:
```bash
# Database
DATABASE_HOST=localhost
DATABASE_PORT=5432
DATABASE_NAME=ecommerce_chatbot
DATABASE_USER=chatbot_user
DATABASE_PASSWORD=chatbot_password

# LLM
GROQ_API_KEY=your_groq_api_key_here

# Redis (optional)
REDIS_HOST=localhost
REDIS_PORT=6379
```

### **Configuration File**
The system uses `config/app_config.yaml` for all settings:
- Database configuration
- Session management
- Cart and order settings
- Logging configuration
- Security settings
- Currency settings

## 🚀 **Quick Start**

### **1. Setup Environment**
```bash
# Clone repository
git clone <repository-url>
cd Chatbot-Core

# Install dependencies
pip install -r requirements.txt

# Setup environment variables
cp env.example .env
# Edit .env with your settings
```

### **2. Initialize Database**
```bash
# Run the comprehensive test suite
python test_enhanced_system.py
```

### **3. Start the Chatbot**
```bash
# Run the main chatbot
python src/main.py
```

### **4. Test the System**
```bash
# Test specific features
python test_commands_only.py
python test_wildcards_and_fuzzy.py
```

## 📊 **Database Schema**

### **Core Tables**
- **`users`** - User information and preferences
- **`products`** - Product catalog with pricing and stock
- **`cart`** - Shopping cart items
- **`orders`** - Order information and status
- **`order_items`** - Individual items in orders
- **`user_sessions`** - User conversation sessions
- **`stock_transactions`** - Stock movement history
- **`chat_interactions`** - Conversation history
- **`analytics`** - Performance metrics

### **Key Features**
- **Foreign key constraints** for data integrity
- **Indexes** for optimal query performance
- **Triggers** for automatic timestamp updates
- **Functions** for stock management and invoice generation

## 🛒 **Cart Management**

### **Features**
- **Add items** to cart with quantity validation
- **Update quantities** with real-time validation
- **Remove items** from cart
- **Clear entire cart**
- **Cart persistence** across sessions
- **Automatic cleanup** of expired carts

### **Usage Examples**
```python
# Add item to cart
await cart_manager.add_to_cart(user_id, product_id, quantity)

# Get cart contents
cart = await cart_manager.get_cart(user_id)

# Update quantity
await cart_manager.update_cart_quantity(user_id, product_id, new_quantity)

# Remove item
await cart_manager.remove_from_cart(user_id, product_id)
```

## 📦 **Order Processing**

### **Features**
- **Order creation** from cart
- **Stock reservation** during order creation
- **PDF invoice generation** with professional templates
- **Order status tracking** (pending, confirmed, shipped, delivered)
- **Payment status management**
- **Order history** and retrieval

### **Order Lifecycle**
1. **Cart Review** → User confirms cart contents
2. **Order Creation** → Cart converted to order
3. **Stock Reservation** → Stock allocated for order
4. **Invoice Generation** → PDF invoice created
5. **Status Updates** → Order progresses through states

## 👤 **Session Management**

### **Features**
- **Session creation** with unique IDs
- **Conversation context** tracking
- **Session persistence** in database
- **Automatic cleanup** of expired sessions
- **Multi-session support** per user
- **Context-aware responses**

### **Session Data**
- Current intent and entities
- Cart items and search history
- Clarification needs and questions
- User preferences and settings

## 📈 **Stock Management**

### **Features**
- **Real-time stock tracking**
- **Stock reservation** for pending orders
- **Low stock alerts** and notifications
- **Stock transaction history**
- **Automatic stock updates**
- **Stock validation** during cart operations

### **Stock Operations**
```python
# Get current stock
stock = await stock_manager.get_stock(product_id)

# Update stock (decrease for orders)
await stock_manager.update_stock(product_id, quantity, 'decrease')

# Reserve stock for order
success = await stock_manager.reserve_stock(product_id, quantity)

# Check low stock items
low_stock = await stock_manager.check_low_stock()
```

## 🔒 **Security Features**

### **Input Validation**
- **SQL injection protection**
- **XSS attack prevention**
- **Input sanitization**
- **Type validation**
- **Length and format validation**

### **Error Handling**
- **Comprehensive error categorization**
- **User-friendly error messages**
- **Retry mechanisms**
- **Graceful degradation**
- **Security event logging**

## 📊 **Monitoring & Analytics**

### **Logging**
- **Structured logging** with JSON format
- **Log rotation** and file management
- **Performance metrics** tracking
- **User interaction** logging
- **Error tracking** and reporting

### **Analytics**
- **User interaction metrics**
- **Order and cart analytics**
- **Product performance** tracking
- **Session duration** analysis
- **Error rate** monitoring

## 🧪 **Testing**

### **Test Suite**
```bash
# Run comprehensive tests
python test_enhanced_system.py

# Test specific components
python test_commands_only.py
python test_wildcards_and_fuzzy.py
```

### **Test Coverage**
- ✅ Database operations
- ✅ Session management
- ✅ Cart management
- ✅ Order processing
- ✅ Stock management
- ✅ Input validation
- ✅ Error handling
- ✅ Invoice generation
- ✅ Currency handling

## 🔧 **Development**

### **Code Structure**
```
src/
├── config/           # Configuration management
├── database/         # Database operations
├── session/          # Session management
├── utils/            # Utilities and helpers
├── commands/         # Command processing
├── search/           # Search functionality
├── llm/              # LLM integration
└── analytics/        # Analytics and metrics
```

### **Adding New Features**
1. **Create feature module** in appropriate directory
2. **Add database schema** if needed
3. **Implement validation** and error handling
4. **Add tests** for new functionality
5. **Update documentation**

## 🚀 **Deployment**

### **Production Setup**
1. **Database**: Use production PostgreSQL instance
2. **Environment**: Set production configuration
3. **Logging**: Configure production logging
4. **Monitoring**: Set up monitoring and alerts
5. **Backup**: Configure database backups

### **Docker Support**
```dockerfile
FROM python:3.9-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
CMD ["python", "src/main.py"]
```

## 📈 **Performance**

### **Optimizations**
- **Database connection pooling**
- **Query optimization** with indexes
- **Caching** for frequently accessed data
- **Async operations** for better concurrency
- **Batch operations** for bulk updates

### **Monitoring**
- **Database performance** metrics
- **Response time** tracking
- **Error rate** monitoring
- **Resource usage** tracking
- **User activity** analytics

## 🤝 **Contributing**

1. **Fork** the repository
2. **Create** feature branch
3. **Implement** changes with tests
4. **Update** documentation
5. **Submit** pull request

## 📄 **License**

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 **Support**

For support and questions:
- **Issues**: Create GitHub issue
- **Documentation**: Check docs/ directory
- **Tests**: Run test suite for validation

---

**🎉 The enhanced e-commerce chatbot is now production-ready with comprehensive features for real-world deployment!** 