# Documentation Repository Setup Guide

This guide will help you set up a dedicated GitHub repository for hosting your E-commerce Chatbot documentation on GitHub Pages.

## 🚀 Quick Setup

### 1. Create New Repository

1. Go to GitHub and create a new repository
2. Name it something like `ecommerce-chatbot-docs` or `chatbot-documentation`
3. Make it **public** (required for GitHub Pages)
4. Don't initialize with README, .gitignore, or license

### 2. Clone and Setup

```bash
# Clone your new repository
git clone https://github.com/yourusername/your-docs-repo-name.git
cd your-docs-repo-name

# Copy all documentation files from your main project
cp -r /path/to/your/main/project/docs/* .

# Initialize git and push
git add .
git commit -m "Initial documentation setup"
git push origin main
```

### 3. Configure Repository

Update the following files with your actual repository information:

#### Update `conf.py`
```python
# Change these lines in conf.py:
html_baseurl = 'https://yourusername.github.io/your-docs-repo-name/'
html_use_opensearch = 'https://yourusername.github.io/your-docs-repo-name'
```

#### Update `deploy.sh`
The deployment script will automatically use the correct repository.

### 4. Enable GitHub Pages

1. Go to your repository on GitHub
2. Navigate to **Settings** → **Pages**
3. Under **Source**, select **Deploy from a branch**
4. Choose **gh-pages** branch and **/(root)** folder
5. Click **Save**

### 5. Deploy Documentation

```bash
# Make the deployment script executable
chmod +x deploy.sh

# Deploy to GitHub Pages
./deploy.sh
```

## 📁 Repository Structure

Your documentation repository should look like this:

```
your-docs-repo-name/
├── conf.py                 # Sphinx configuration
├── index.rst              # Main documentation page
├── Makefile               # Build commands
├── deploy.sh              # Deployment script
├── requirements.txt       # Python dependencies
├── _static/               # Static files (CSS, images)
├── _templates/            # Custom templates
├── api/                   # API documentation
├── *.rst                  # Documentation source files
└── README.md              # Repository README
```

## 🔧 Configuration Files

### `.nojekyll` (Create this file)
Create an empty `.nojekyll` file in the root to tell GitHub Pages not to process with Jekyll:

```bash
touch .nojekyll
```

### `CNAME` (Optional)
If you have a custom domain, create a `CNAME` file:

```
yourdomain.com
```

## 🚀 Deployment Workflow

### First Time Setup
```bash
# Install dependencies
pip install -r requirements.txt

# Build documentation
make html

# Deploy
./deploy.sh
```

### Regular Updates
```bash
# Make changes to .rst files
# Build and deploy
make html && ./deploy.sh
```

## 📝 Important Notes

1. **Public Repository**: GitHub Pages requires the repository to be public
2. **Branch Name**: Documentation is deployed to the `gh-pages` branch
3. **Build Process**: Documentation is built locally and then pushed to GitHub
4. **Custom Domain**: You can add a custom domain in repository settings
5. **HTTPS**: GitHub Pages automatically provides HTTPS

## 🔍 Troubleshooting

### Build Errors
```bash
# Clean build directory
make clean

# Rebuild
make html
```

### Deployment Issues
```bash
# Check git status
git status

# Force push if needed
git push origin gh-pages --force
```

### GitHub Pages Not Updating
- Wait 5-10 minutes for changes to appear
- Check the Actions tab for deployment status
- Verify the gh-pages branch has the latest files

## 📚 Documentation Structure

The documentation includes:
- **API Reference**: Complete API documentation
- **Technical Architecture**: System design and architecture
- **Deployment Guide**: How to deploy the chatbot
- **Quick Reference**: Common commands and configurations
- **Validation Guide**: Testing and validation procedures

## 🔗 Links

- **GitHub Pages**: https://yourusername.github.io/your-docs-repo-name/
- **Repository**: https://github.com/yourusername/your-docs-repo-name
- **Issues**: Report documentation issues in the repository

## 📞 Support

For documentation issues:
1. Check the troubleshooting section above
2. Review the build logs
3. Create an issue in the documentation repository

---

**Remember**: Update all placeholder URLs (`yourusername`, `your-docs-repo-name`) with your actual GitHub username and repository name! 