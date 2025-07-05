#!/bin/bash

# Manual deployment script for GitHub Pages
# This script builds the documentation and deploys it to the gh-pages branch

set -e  # Exit on any error

echo "🚀 Deploying Documentation to GitHub Pages"
echo "=========================================="

# Check if we're in the docs directory
if [ ! -f "conf.py" ]; then
    echo "❌ Error: conf.py not found. Please run this script from the docs directory."
    exit 1
fi

# Build the documentation
echo "📚 Building documentation..."
make html

if [ $? -ne 0 ]; then
    echo "❌ Build failed. Please fix the errors and try again."
    exit 1
fi

echo "✅ Documentation built successfully"

# Check if gh-pages branch exists
if git show-ref --verify --quiet refs/remotes/origin/gh-pages; then
    echo "📝 Updating existing gh-pages branch..."
    git checkout gh-pages
    git pull origin gh-pages
else
    echo "📝 Creating new gh-pages branch..."
    git checkout --orphan gh-pages
fi

# Remove all files except .git
git rm -rf . || true

# Copy built documentation
echo "📋 Copying built documentation..."
cp -r _build/html/* .

# Copy GitHub Pages specific files
if [ -f ".nojekyll" ]; then
    cp .nojekyll .
fi

if [ -f "CNAME" ]; then
    cp CNAME .
fi

# Add all files
git add .

# Commit changes
echo "💾 Committing changes..."
git commit -m "Deploy documentation $(date)"

# Push to GitHub
echo "🚀 Pushing to GitHub..."
git push origin gh-pages

# Return to original branch
echo "🔄 Returning to original branch..."
git checkout -

echo ""
echo "🎉 Deployment completed successfully!"
echo ""
echo "📖 Your documentation should be available at:"
echo "   https://yourusername.github.io/your-repo-name/"
echo ""
echo "⏱️  It may take a few minutes for changes to appear."
echo ""
echo "🔧 To configure GitHub Pages:"
echo "   1. Go to your repository on GitHub"
echo "   2. Navigate to Settings → Pages"
echo "   3. Select 'Deploy from a branch'"
echo "   4. Choose 'gh-pages' branch and '/(root)' folder"
echo "   5. Click Save" 