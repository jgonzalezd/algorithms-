#!/bin/bash

# Dependencies Setup Script
# This script installs and configures development dependencies

set -e

echo "Setting up development dependencies..."

# Install global Node.js types
echo "Installing Node.js types..."
npm install -g @types/node

echo "✅ Dependencies setup completed successfully"
echo "   - @types/node installed globally"
