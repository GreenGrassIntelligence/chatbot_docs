# E-commerce Chatbot Documentation

This repository contains the complete documentation for the E-commerce Chatbot project, hosted on GitHub Pages.

## 📖 Live Documentation

Visit the live documentation at: [https://greengrassintelligence.github.io/chatbot_docs/](https://greengrassintelligence.github.io/chatbot_docs/)

## 🚀 Quick Start

### Prerequisites

- Python 3.7+
- pip
- Git

### Installation

```bash
# Clone this repository
git clone https://github.com/GreenGrassIntelligence/chatbot_docs.git
cd chatbot_docs

# Install dependencies
pip install -r requirements.txt

# Build documentation locally
make html

# View locally (optional)
make serve
```

### Deployment

```bash
# Deploy to GitHub Pages
./deploy.sh
```

## 📚 Documentation Structure

- **API Reference**: Complete API documentation with examples
- **Technical Architecture**: System design and component overview
- **Deployment Guide**: Step-by-step deployment instructions
- **Quick Reference**: Common commands and configurations
- **Validation Guide**: Testing and validation procedures
- **Implementation Status**: Current development status

## 🔧 Development

### Building Documentation

```bash
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
```

### Local Development

```bash
# Start local server
make serve

# Watch for changes (in separate terminal)
make watch
```

## 📝 Contributing

1. Fork this repository
2. Create a feature branch
3. Make your changes
4. Test the build: `make html`
5. Submit a pull request

## 🔗 Related Repositories

- **Main Project**: [E-commerce Chatbot](https://github.com/yourusername/ecommerce-chatbot)
- **API Backend**: [Chatbot API](https://github.com/yourusername/chatbot-api)

## 📞 Support

- **Documentation Issues**: Create an issue in this repository
- **Project Issues**: Use the main project repository
- **Questions**: Check the documentation or create a discussion

## 📄 License

This documentation is licensed under the same license as the main project.

---

**Note**: Remember to update the URLs in `conf.py` and this README with your actual GitHub username and repository name! 