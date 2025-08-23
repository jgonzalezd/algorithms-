#!/bin/bash

# SSH Setup Script for GitHub Authentication
# This script configures SSH keys and GitHub access for the devcontainer

set -e

echo "Setting up SSH configuration for GitHub..."

# Create SSH directory with proper permissions
mkdir -p /home/vscode/.ssh
chmod 700 /home/vscode/.ssh

# Check if GitHub SSH key exists
if [ -f /home/vscode/.ssh/github_key ]; then
    echo "Configuring GitHub SSH key..."
    
    # Set proper permissions for the private key
    chmod 600 /home/vscode/.ssh/github_key
    
    # Create SSH config for GitHub
    cat > /home/vscode/.ssh/config << 'EOF'
Host github.com
  HostName github.com
  User git
  IdentityFile /home/vscode/.ssh/github_key
  IdentitiesOnly yes
EOF
    
    # Set proper permissions for SSH config
    chmod 600 /home/vscode/.ssh/config
    
    # Add GitHub to known hosts
    ssh-keyscan github.com >> /home/vscode/.ssh/known_hosts 2>/dev/null || true
    
    echo "✅ SSH configuration completed successfully"
    echo "   - GitHub SSH key configured"
    echo "   - SSH config file created"
    echo "   - GitHub added to known hosts"
else
    echo "⚠️  GitHub SSH key not found at /home/vscode/.ssh/github_key"
    echo "   Make sure to mount your SSH keys in devcontainer.json"
fi
