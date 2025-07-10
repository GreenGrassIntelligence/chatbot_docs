Documentation Setup Guide
=========================

This guide covers setting up the documentation system for the e-commerce chatbot project, including Sphinx configuration and GitHub Pages deployment.

Overview
--------

The documentation is built using Sphinx and deployed to GitHub Pages. This setup provides:
- Automated documentation generation
- GitHub Pages hosting
- Search functionality
- Responsive design

Prerequisites
------------

- Python 3.8+
- Git
- GitHub repository with GitHub Pages enabled

Installation Steps
-----------------

1. **Install Sphinx and Dependencies**

   .. code-block:: bash

      pip install -r requirements.txt

2. **Initialize Sphinx (if not already done)**

   .. code-block:: bash

      sphinx-quickstart -p "E-commerce Chatbot" -a "Your Name" -v 1.0 -r 1.0 -l en -n

3. **Build Documentation**

   .. code-block:: bash

      make html

4. **View Documentation Locally**

   .. code-block:: bash

      python -m http.server 8000 --directory _build/html

Configuration Files
------------------

**conf.py**
   Main Sphinx configuration file with theme settings, extensions, and project metadata.

**Makefile**
   Build automation for different output formats (HTML, PDF, etc.).

**requirements.txt**
   Python dependencies for documentation building.

GitHub Pages Setup
-----------------

1. **Enable GitHub Pages**
   - Go to repository Settings > Pages
   - Select source branch (usually `gh-pages` or `main` with `/docs` folder)
   - Choose theme if desired

2. **Configure GitHub Actions (Optional)**
   - Create `.github/workflows/docs.yml` for automated builds
   - Triggers on push to main branch
   - Builds and deploys documentation automatically

3. **Custom Domain (Optional)**
   - Add CNAME file with your domain
   - Configure DNS settings

Build Process
------------

The documentation build process includes:

1. **Source Processing**
   - RST file parsing
   - Code block highlighting
   - Cross-reference resolution

2. **Output Generation**
   - HTML generation
   - Search index creation
   - Static asset copying

3. **Quality Checks**
   - Link validation
   - Image optimization
   - Accessibility checks

Troubleshooting
--------------

**Common Issues:**

- **Build Errors**: Check Python dependencies and Sphinx version
- **Missing Images**: Ensure image paths are correct relative to RST files
- **Broken Links**: Run link checker with `make linkcheck`
- **Theme Issues**: Verify theme installation and configuration

**Useful Commands:**

.. code-block:: bash

   # Clean build directory
   make clean

   # Check for broken links
   make linkcheck

   # Build specific format
   make html
   make pdf
   make epub

Maintenance
----------

- Regular updates to keep documentation current
- Link validation on schedule
- Performance monitoring
- User feedback collection

For more detailed information, see the individual setup files in this directory. 