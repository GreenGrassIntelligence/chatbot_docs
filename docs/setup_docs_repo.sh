#!/bin/bash

# Setup script for new documentation repository
# This script helps configure the repository for GitHub Pages

set -e

echo "🚀 Setting up Documentation Repository"
echo "======================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Check if we're in the right directory
if [ ! -f "conf.py" ]; then
    print_error "conf.py not found. Please run this script from the docs directory."
    exit 1
fi

print_info "This script will help you configure your documentation repository."
echo ""

# Get repository information
read -p "Enter your GitHub username: " GITHUB_USERNAME
read -p "Enter your documentation repository name: " REPO_NAME

# Update conf.py
print_info "Updating conf.py with your repository information..."
sed -i "s/yourusername/$GITHUB_USERNAME/g" conf.py
sed -i "s/your-docs-repo-name/$REPO_NAME/g" conf.py

print_status "conf.py updated successfully"

# Update README.md
print_info "Updating README.md..."
sed -i "s/yourusername/$GITHUB_USERNAME/g" README.md
sed -i "s/your-docs-repo-name/$REPO_NAME/g" README.md

print_status "README.md updated successfully"

# Update deploy.sh
print_info "Updating deploy.sh..."
sed -i "s/yourusername/$GITHUB_USERNAME/g" deploy.sh
sed -i "s/your-docs-repo-name/$REPO_NAME/g" deploy.sh

print_status "deploy.sh updated successfully"

# Make scripts executable
print_info "Making scripts executable..."
chmod +x deploy.sh
chmod +x setup_docs_repo.sh

print_status "Scripts made executable"

# Create .nojekyll file if it doesn't exist
if [ ! -f ".nojekyll" ]; then
    print_info "Creating .nojekyll file..."
    touch .nojekyll
    print_status ".nojekyll file created"
fi

# Test build
print_info "Testing documentation build..."
if make html > /dev/null 2>&1; then
    print_status "Documentation builds successfully"
else
    print_warning "Build test failed. You may need to install dependencies:"
    echo "  pip install -r requirements.txt"
fi

echo ""
print_status "Setup completed successfully!"
echo ""
print_info "Next steps:"
echo "1. Push your changes to GitHub:"
echo "   git add ."
echo "   git commit -m 'Initial documentation setup'"
echo "   git push origin main"
echo ""
echo "2. Enable GitHub Pages:"
echo "   - Go to your repository on GitHub"
echo "   - Navigate to Settings → Pages"
echo "   - Select 'Deploy from a branch'"
echo "   - Choose 'gh-pages' branch and '/(root)' folder"
echo "   - Click Save"
echo ""
echo "3. Deploy documentation:"
echo "   ./deploy.sh"
echo ""
print_info "Your documentation will be available at:"
echo "https://$GITHUB_USERNAME.github.io/$REPO_NAME/"
echo ""
print_warning "Remember to update any remaining placeholder URLs in your documentation files!" 