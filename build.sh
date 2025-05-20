# Render build script (create this as build.sh in your project root)
#!/bin/bash

# Install Python dependencies
pip install -r requirements.txt

# Install Playwright and browsers
playwright install chromium
playwright install-deps chromium

# Set permissions
chmod +x build.sh