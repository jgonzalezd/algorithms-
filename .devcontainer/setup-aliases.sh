#!/bin/bash

# Algorithm Study Environment - Alias Setup Script
# This script sets up persistent aliases and fixes npm configuration for the devcontainer

echo "Setting up algorithm study environment..."

# Fix npm configuration issues with nvm
echo "Fixing npm configuration..."
if [ -f "/home/vscode/.npmrc" ]; then
    # Remove problematic globalconfig and prefix settings
    sed -i '/^globalconfig=/d' /home/vscode/.npmrc
    sed -i '/^prefix=/d' /home/vscode/.npmrc
    echo "Removed problematic npm config settings from .npmrc"
else
    echo "No .npmrc file found - npm config is clean"
fi

echo "Setting up algorithm study aliases..."

# Ensure login shells have RVM configuration
BASH_PROFILE_PATH="/home/vscode/.bash_profile"
if [ ! -f "$BASH_PROFILE_PATH" ]; then
    echo "Creating .bash_profile for RVM configuration..."
    echo '' >> $BASH_PROFILE_PATH
    echo '# RVM Configuration' >> $BASH_PROFILE_PATH
    echo '[ -s ~/.rvm/scripts/rvm ] && source ~/.rvm/scripts/rvm' >> $BASH_PROFILE_PATH
    echo "rvm use \${RUBY_VERSION:-3.2.2} --default 2>/dev/null || true" >> $BASH_PROFILE_PATH
    echo '' >> $BASH_PROFILE_PATH
    echo '# Source .bashrc for aliases and functions' >> $BASH_PROFILE_PATH
    echo 'if [ -f ~/.bashrc ]; then' >> $BASH_PROFILE_PATH
    echo '    . ~/.bashrc' >> $BASH_PROFILE_PATH
    echo 'fi' >> $BASH_PROFILE_PATH
fi

# Create or append to .bashrc with algorithm aliases
cat >> /home/vscode/.bashrc << 'EOF'

# Algorithm Study Environment Aliases
alias run-challenge='/workspaces/Algorithms/scripts/run.sh'
alias switch-ruby='echo "Available Ruby versions:" && rvm list'
alias switch-python='echo "Available Python versions:" && pyenv versions'  
alias switch-node='echo "Available Node versions:" && nvm list'
EOF

echo "Algorithm environment configured successfully!"
echo "- Fixed npm configuration issues with nvm"
echo "- Set up algorithm study aliases"
echo ""
echo "Available aliases:"
echo "  - run-challenge: Run algorithm solutions"
echo "  - switch-ruby: Show Ruby versions"
echo "  - switch-python: Show Python versions"
echo "  - switch-node: Show Node versions"
