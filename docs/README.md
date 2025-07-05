# E-commerce Chatbot Documentation

This directory contains the Sphinx documentation for the E-commerce Chatbot project.

## Quick Start

### Prerequisites

- Python 3.8+
- pip

### Installation

1. Install Sphinx and dependencies:
```bash
pip install -r requirements.txt
```

2. Build the documentation:
```bash
# Build HTML documentation
make html

# Or use the Python script
python build_docs.py html
```

3. View the documentation:
```bash
# Open in browser
open _build/html/index.html

# Or serve locally
make serve
# Then visit http://localhost:8000
```

## Building Documentation

### Available Commands

```bash
# Build HTML documentation
make html
python build_docs.py html

# Build PDF documentation
make pdf
python build_docs.py pdf

# Build EPUB documentation
make epub
python build_docs.py epub

# Check for broken links
make linkcheck
python build_docs.py check

# Build all formats
python build_docs.py all

# Serve documentation locally
make serve
python build_docs.py serve
```

### Using Make

The `Makefile` provides standard Sphinx targets:

```bash
make help          # Show all available commands
make html          # Build HTML documentation
make pdf           # Build PDF documentation
make epub          # Build EPUB documentation
make linkcheck     # Check for broken links
make doctest       # Run doctests
make spelling      # Check spelling
make clean         # Clean build directory
```

### Using Python Script

The `build_docs.py` script provides additional features:

```bash
python build_docs.py html    # Build HTML with dependency checking
python build_docs.py all     # Build all formats
python build_docs.py serve   # Serve with auto-reload
python build_docs.py check   # Check links
```

## Documentation Structure

```
docs/
├── index.rst                    # Main documentation index
├── quick_reference.rst          # Quick reference guide
├── implementation_status.rst    # Feature implementation status
├── chatbot_capabilities.rst     # Detailed capabilities guide
├── deployment_guide.rst         # Deployment instructions
├── validation_guide.rst         # Testing and validation
├── analysis_and_improvements.rst # Analysis and improvements
├── improvements_summary.rst     # Summary of improvements
├── documentation_audit_summary.rst # Documentation audit
├── api/                         # API documentation
│   └── index.rst               # API reference index
├── _static/                     # Static files (CSS, images)
│   └── custom.css              # Custom styling
├── _templates/                  # Custom templates
├── conf.py                      # Sphinx configuration
├── Makefile                     # Build commands
├── requirements.txt             # Python dependencies
└── build_docs.py               # Build script
```

## Customization

### Theme

The documentation uses the `sphinx_rtd_theme` (Read the Docs theme). You can customize it by modifying:

- `conf.py` - Theme options and configuration
- `_static/custom.css` - Custom CSS styles

### Adding New Pages

1. Create a new `.rst` file in the appropriate directory
2. Add it to the relevant `toctree` in `index.rst`
3. Build the documentation to see your changes

### Adding API Documentation

1. Create new files in the `api/` directory
2. Add them to the `api/index.rst` toctree
3. Use autodoc directives to document Python modules

## Development

### Auto-reload During Development

```bash
# Watch for changes and rebuild automatically
make watch

# Or serve with auto-reload
python build_docs.py serve
```

### Code Documentation

To document Python code, use docstrings and autodoc directives:

```rst
.. automodule:: src.main
   :members:
   :undoc-members:
   :show-inheritance:
```

### Spell Checking

```bash
make spelling
```

This will check spelling in all documentation files.

## Troubleshooting

### Common Issues

1. **Import Errors**: Make sure all dependencies are installed
   ```bash
   pip install -r requirements.txt
   ```

2. **Build Errors**: Clean and rebuild
   ```bash
   make clean
   make html
   ```

3. **Missing Files**: Check that all referenced files exist

4. **Theme Issues**: Ensure sphinx_rtd_theme is installed
   ```bash
   pip install sphinx_rtd_theme
   ```

### Getting Help

- Check the Sphinx documentation: https://www.sphinx-doc.org/
- Review the `conf.py` file for configuration options
- Look at existing `.rst` files for examples

## Contributing

When contributing to the documentation:

1. Follow the existing style and structure
2. Use proper RST syntax
3. Add new pages to the appropriate toctree
4. Test your changes by building the documentation
5. Check for broken links and spelling errors

## Deployment

The built documentation can be deployed to:

- GitHub Pages
- Read the Docs
- Any static file hosting service

The HTML output is in `_build/html/` and can be served by any web server. 