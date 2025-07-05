#!/usr/bin/env python3
"""
Build script for Sphinx documentation.
"""

import os
import sys
import subprocess
import shutil
from pathlib import Path

def run_command(cmd, cwd=None):
    """Run a command and return the result."""
    try:
        result = subprocess.run(
            cmd, 
            shell=True, 
            cwd=cwd, 
            capture_output=True, 
            text=True, 
            check=True
        )
        return result.stdout
    except subprocess.CalledProcessError as e:
        print(f"Error running command: {cmd}")
        print(f"Error: {e.stderr}")
        return None

def check_dependencies():
    """Check if required dependencies are installed."""
    try:
        import sphinx
        print(f"✓ Sphinx {sphinx.__version__} is installed")
    except ImportError:
        print("✗ Sphinx is not installed. Installing...")
        run_command("pip install -r requirements.txt")
    
    try:
        import sphinx_rtd_theme
        print("✓ sphinx-rtd-theme is installed")
    except ImportError:
        print("✗ sphinx-rtd-theme is not installed. Installing...")
        run_command("pip install sphinx-rtd-theme")

def clean_build():
    """Clean the build directory."""
    build_dir = Path("_build")
    if build_dir.exists():
        print("Cleaning build directory...")
        shutil.rmtree(build_dir)
        print("✓ Build directory cleaned")

def build_html():
    """Build HTML documentation."""
    print("Building HTML documentation...")
    result = run_command("sphinx-build -b html . _build/html")
    if result:
        print("✓ HTML documentation built successfully")
        return True
    else:
        print("✗ Failed to build HTML documentation")
        return False

def build_pdf():
    """Build PDF documentation."""
    print("Building PDF documentation...")
    result = run_command("sphinx-build -b latex . _build/latex")
    if result:
        print("✓ LaTeX files generated")
        # Try to build PDF
        pdf_result = run_command("make -C _build/latex all-pdf")
        if pdf_result:
            print("✓ PDF documentation built successfully")
            return True
        else:
            print("⚠ PDF build failed (LaTeX may not be installed)")
            return False
    else:
        print("✗ Failed to build PDF documentation")
        return False

def build_epub():
    """Build EPUB documentation."""
    print("Building EPUB documentation...")
    result = run_command("sphinx-build -b epub . _build/epub")
    if result:
        print("✓ EPUB documentation built successfully")
        return True
    else:
        print("✗ Failed to build EPUB documentation")
        return False

def check_links():
    """Check for broken links."""
    print("Checking for broken links...")
    result = run_command("sphinx-build -b linkcheck . _build/linkcheck")
    if result:
        print("✓ Link check completed")
        return True
    else:
        print("⚠ Link check found issues")
        return False

def serve_docs():
    """Serve the documentation locally."""
    html_dir = Path("_build/html")
    if not html_dir.exists():
        print("HTML documentation not built. Building first...")
        if not build_html():
            return False
    
    print("Starting local server at http://localhost:8000")
    print("Press Ctrl+C to stop the server")
    
    try:
        run_command("python -m http.server 8000", cwd="_build/html")
    except KeyboardInterrupt:
        print("\nServer stopped")

def main():
    """Main function."""
    print("E-commerce Chatbot Documentation Builder")
    print("=" * 50)
    
    # Check if we're in the right directory
    if not Path("conf.py").exists():
        print("Error: conf.py not found. Please run this script from the docs directory.")
        sys.exit(1)
    
    # Parse command line arguments
    if len(sys.argv) < 2:
        print("Usage: python build_docs.py [html|pdf|epub|serve|all|check]")
        print("\nOptions:")
        print("  html   - Build HTML documentation")
        print("  pdf    - Build PDF documentation")
        print("  epub   - Build EPUB documentation")
        print("  serve  - Serve HTML documentation locally")
        print("  all    - Build all formats")
        print("  check  - Check for broken links")
        sys.exit(1)
    
    command = sys.argv[1].lower()
    
    # Check dependencies
    check_dependencies()
    
    # Clean build directory
    clean_build()
    
    # Execute command
    if command == "html":
        success = build_html()
    elif command == "pdf":
        success = build_pdf()
    elif command == "epub":
        success = build_epub()
    elif command == "serve":
        serve_docs()
        return
    elif command == "check":
        success = check_links()
    elif command == "all":
        print("Building all documentation formats...")
        html_success = build_html()
        pdf_success = build_pdf()
        epub_success = build_epub()
        success = html_success and pdf_success and epub_success
    else:
        print(f"Unknown command: {command}")
        sys.exit(1)
    
    if success:
        print("\n✓ Documentation build completed successfully!")
        
        if command == "html" or command == "all":
            print("\nHTML documentation is available in: _build/html/")
            print("Open _build/html/index.html in your browser to view it.")
        
        if command == "pdf" or command == "all":
            print("\nPDF documentation is available in: _build/latex/")
        
        if command == "epub" or command == "all":
            print("\nEPUB documentation is available in: _build/epub/")
    else:
        print("\n✗ Documentation build failed!")
        sys.exit(1)

if __name__ == "__main__":
    main() 