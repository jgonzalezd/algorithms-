# syntax=docker/dockerfile:1

############################
# Node.js Layer via NVM
############################
FROM layer-base AS layer-node

ARG NODE_VERSION=18.17.0

# Install NVM and Node.js - using bash -ic to properly load NVM in same RUN
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash && \
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc && \
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.bashrc && \
    bash -ic "nvm install ${NODE_VERSION} && nvm use ${NODE_VERSION} && nvm alias default ${NODE_VERSION}" && \
    npm config set prefix ~/.npm-global && \
    echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc && \
    bash -ic "npm install -g typescript ts-node @types/node"

# Verify installation
RUN bash -ic "node --version && npm --version && tsc --version"
