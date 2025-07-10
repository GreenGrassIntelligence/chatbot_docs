#!/bin/bash

# Setup script for E-commerce Chatbot Documentation
# This script installs dependencies and sets up the documentation environment

set -e  # Exit on any error

echo "🚀 Setting up E-commerce Chatbot Documentation"
echo "=============================================="

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is not installed. Please install Python 3.8+ first."
    exit 1
fi

echo "✅ Python 3 found: $(python3 --version)"

# Check if pip is installed
if ! command -v pip3 &> /dev/null; then
    echo "❌ pip3 is not installed. Please install pip first."
    exit 1
fi

echo "✅ pip3 found: $(pip3 --version)"

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "📦 Creating virtual environment..."
    python3 -m venv venv
    echo "✅ Virtual environment created"
else
    echo "✅ Virtual environment already exists"
fi

# Activate virtual environment
echo "🔧 Activating virtual environment..."
source venv/bin/activate

# Upgrade pip
echo "⬆️  Upgrading pip..."
pip install --upgrade pip

# Install documentation dependencies
echo "📚 Installing documentation dependencies..."
pip install -r requirements.txt

# Create necessary directories
echo "📁 Creating necessary directories..."
mkdir -p _static _templates _build

# Check if conf.py exists
if [ ! -f "conf.py" ]; then
    echo "❌ conf.py not found. Please ensure you're in the docs directory."
    exit 1
fi

# Test the build
echo "🧪 Testing documentation build..."
python build_docs.py html

if [ $? -eq 0 ]; then
    echo ""
    echo "🎉 Documentation setup completed successfully!"
    echo ""
    echo "📖 Available commands:"
    echo "  make html          - Build HTML documentation"
    echo "  make pdf           - Build PDF documentation"
    echo "  make serve         - Serve documentation locally"
    echo "  python build_docs.py html    - Build HTML with dependency checking"
    echo "  python build_docs.py serve   - Serve with auto-reload"
    echo ""
    echo "🌐 To view the documentation:"
    echo "  open _build/html/index.html"
    echo "  or run: make serve"
    echo ""
    echo "📚 Documentation is now ready!"
else
    echo "❌ Documentation build failed. Please check the error messages above."
    exit 1
fi 