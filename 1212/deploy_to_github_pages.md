# Deploying Sphinx Documentation to GitHub Pages

This guide explains how to deploy the E-commerce Chatbot documentation to GitHub Pages using GitHub Actions.

## Overview

GitHub Pages is a static site hosting service that can serve Sphinx documentation. The setup includes:

- **Automatic builds** on every push to main/master branch
- **GitHub Actions workflow** for CI/CD
- **Custom domain support** (optional)
- **Version control** for documentation changes

## Quick Setup

### 1. Enable GitHub Pages

1. Go to your repository on GitHub
2. Navigate to **Settings** → **Pages**
3. Under **Source**, select **Deploy from a branch**
4. Choose **gh-pages** branch and **/(root)** folder
5. Click **Save**

### 2. Configure GitHub Actions

The workflow file `.github/workflows/docs.yml` is already configured. It will:

- Build the documentation on every push
- Deploy to GitHub Pages automatically
- Handle dependencies and build process

### 3. Manual Deployment (Alternative)

If you prefer manual deployment:

```bash
# Build the documentation
cd docs
make html

# Create gh-pages branch (first time only)
git checkout --orphan gh-pages
git rm -rf .
cp -r _build/html/* .
git add .
git commit -m "Deploy documentation"
git push origin gh-pages

# Return to main branch
git checkout main
```

## Configuration Files

### GitHub Actions Workflow (`.github/workflows/docs.yml`)

```yaml
name: Build and Deploy Documentation

on:
  push:
    branches: [ main, master ]
  pull_request:
    branches: [ main, master ]

jobs:
  build-docs:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout repository
      uses: actions/checkout@v4
      
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.9'
        
    - name: Install dependencies
      run: |
        cd docs
        python -m pip install --upgrade pip
        pip install -r requirements.txt
        
    - name: Build documentation
      run: |
        cd docs
        make html
        
    - name: Deploy to GitHub Pages
      if: github.ref == 'refs/heads/main' || github.ref == 'refs/heads/master'
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./docs/_build/html
        force_orphan: true
```

### Sphinx Configuration Updates

Add these settings to `conf.py` for GitHub Pages:

```python
# GitHub Pages configuration
html_baseurl = 'https://yourusername.github.io/your-repo-name/'

# Theme options for GitHub Pages
html_theme_options = {
    'navigation_depth': 4,
    'collapse_navigation': False,
    'sticky_navigation': True,
    'includehidden': True,
    'titles_only': False,
    'logo_only': False,
    'display_version': True,
    'prev_next_buttons_location': 'bottom',
    'style_external_links': True,
    'style_nav_header_background': '#2980B9',
}

# GitHub Pages specific settings
html_use_index = True
html_add_permalinks = True
html_permalinks_icon = "¶"
```

## Custom Domain Setup

### 1. Configure CNAME

Edit `docs/CNAME` and add your domain:

```
docs.yourdomain.com
```

### 2. DNS Configuration

Add a CNAME record in your DNS provider:

```
Type: CNAME
Name: docs
Value: yourusername.github.io
```

### 3. Update Sphinx Configuration

Update `conf.py` with your custom domain:

```python
html_baseurl = 'https://docs.yourdomain.com/'
```

## Local Development

### Build and Test Locally

```bash
# Setup documentation environment
cd docs
./setup_docs.sh

# Build documentation
make html

# Serve locally
make serve
# Visit http://localhost:8000
```

### Preview Changes

```bash
# Watch for changes and rebuild
make watch

# Or use the Python script
python build_docs.py serve
```

## Troubleshooting

### Common Issues

1. **Build Failures**
   ```bash
   # Check dependencies
   pip install -r requirements.txt
   
   # Clean and rebuild
   make clean
   make html
   ```

2. **GitHub Pages Not Updating**
   - Check GitHub Actions tab for build status
   - Verify gh-pages branch exists
   - Check repository settings

3. **Missing Dependencies**
   ```bash
   # Install missing packages
   pip install sphinx sphinx-rtd-theme
   ```

4. **Custom Domain Issues**
   - Verify DNS settings
   - Check CNAME file in gh-pages branch
   - Wait for DNS propagation (up to 24 hours)

### Debugging GitHub Actions

1. Go to **Actions** tab in your repository
2. Click on the failed workflow
3. Check the build logs for errors
4. Common issues:
   - Missing dependencies
   - Python version conflicts
   - File path issues

## Advanced Configuration

### Multiple Versions

To support multiple documentation versions:

```yaml
# In .github/workflows/docs.yml
- name: Deploy to GitHub Pages
  uses: peaceiris/actions-gh-pages@v3
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
    publish_dir: ./docs/_build/html
    force_orphan: true
    destination_dir: ./docs/${{ github.ref_name }}
```

### Custom Build Scripts

Create custom build scripts for different environments:

```bash
# docs/build_production.sh
#!/bin/bash
export SPHINXOPTS="-D html_theme_options.navigation_depth=4"
make html
```

### SEO Optimization

Add meta tags and SEO settings to `conf.py`:

```python
# SEO settings
html_use_opensearch = 'https://yourusername.github.io/your-repo-name'
html_short_title = 'E-commerce Chatbot Docs'

# Open Graph
extensions.append('sphinxext.opengraph')
ogp_site_url = 'https://yourusername.github.io/your-repo-name/'
ogp_image = 'https://yourusername.github.io/your-repo-name/_static/logo.png'
```

## Best Practices

### 1. Version Control

- Keep documentation in the same repository as code
- Use meaningful commit messages
- Tag releases for documentation versions

### 2. Content Organization

- Use clear navigation structure
- Include search functionality
- Provide quick reference guides

### 3. Maintenance

- Regular link checking
- Update dependencies
- Monitor build status

### 4. Performance

- Optimize images
- Minimize CSS/JS
- Use CDN for static assets

## Monitoring and Analytics

### GitHub Pages Analytics

GitHub Pages provides basic analytics:

1. Go to **Settings** → **Pages**
2. Scroll down to **GitHub Pages site**
3. Click **View site analytics**

### Google Analytics

Add Google Analytics to your documentation:

```python
# In conf.py
html_theme_options = {
    'analytics_id': 'G-XXXXXXXXXX',  # Google Analytics ID
}
```

## Security Considerations

### GitHub Token

The workflow uses `GITHUB_TOKEN` which is automatically provided by GitHub Actions. For custom domains, you might need a Personal Access Token:

1. Create a Personal Access Token
2. Add it as a repository secret
3. Update the workflow to use the secret

### Content Security

- Review all external links
- Validate user-generated content
- Keep dependencies updated

## Conclusion

GitHub Pages provides an excellent platform for hosting Sphinx documentation with:

- ✅ Automatic deployment
- ✅ Version control integration
- ✅ Custom domain support
- ✅ Free hosting
- ✅ SSL certificates
- ✅ CDN distribution

The setup is straightforward and provides a professional documentation site for your project. 