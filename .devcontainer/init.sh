#!/bin/bash

# DevContainer Initialization Script
# This script orchestrates the complete setup of the algorithm study environment

set -e

echo "🚀 Initializing Algorithm Study Environment..."
echo "=============================================="

# Run SSH setup
echo ""
echo "📡 Setting up SSH configuration..."
/workspaces/Algorithms/.devcontainer/setup-ssh.sh

# Run aliases setup
echo ""
echo "⚡ Setting up development aliases..."
/workspaces/Algorithms/.devcontainer/setup-aliases.sh

# Run dependencies setup
echo ""
echo "📦 Installing dependencies..."
/workspaces/Algorithms/.devcontainer/setup-dependencies.sh

echo ""
echo "🎉 Algorithm study environment ready!"
echo "====================================="
echo "✅ SSH configured for GitHub access"
echo "✅ Development aliases available"
echo "✅ Dependencies installed"
echo ""
echo "Available commands:"
echo "  - run-challenge: Execute algorithm solutions"
echo "  - switch-ruby: List Ruby versions"
echo "  - switch-python: List Python versions"
echo "  - switch-node: List Node versions"
