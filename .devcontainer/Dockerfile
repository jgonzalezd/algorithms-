# syntax=docker/dockerfile:1

############################
# Modular Devcontainer Build
############################

# Build arguments to select which runtimes to include
ARG WITH_NODE=true
ARG WITH_RUBY=true  
ARG WITH_PYTHON=true
ARG NODE_VERSION=18.17.0
ARG RUBY_VERSION=3.2
ARG PYTHON_VERSION=3.11
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000

############################
# Base layer - always included
############################
FROM ubuntu:22.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

# System dependencies
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update && apt-get install -y --no-install-recommends \
        git \
        curl \
        wget \
        build-essential \
        libssl-dev \
        libreadline-dev \
        zlib1g-dev \
        libbz2-dev \
        libsqlite3-dev \
        libffi-dev \
        liblzma-dev \
        libncurses5-dev \
        libncursesw5-dev \
        libgdbm-dev \
        libgdbm6 \
        libdb-dev \
        libyaml-dev \
        libnss3-dev \
        vim \
        sudo \
        ca-certificates \
        gnupg \
        software-properties-common \
        openssh-client \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN groupadd --gid 1000 vscode && \
    useradd --uid 1000 --gid 1000 -m vscode && \
    echo "vscode ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/vscode && \
    chmod 0440 /etc/sudoers.d/vscode

USER vscode
WORKDIR /home/vscode
SHELL ["/bin/bash", "-o", "pipefail", "-lc"]

# Create and set permissions for .ssh directory to prevent root ownership on mount
RUN mkdir -p /home/vscode/.ssh && chmod 700 /home/vscode/.ssh

############################
# Node.js layer - conditional
############################
FROM base AS node
ARG WITH_NODE
ARG NODE_VERSION

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN if [ "$WITH_NODE" = "true" ]; then \
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash && \
        echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc && \
        echo '# Fix npm/nvm conflicts BEFORE loading nvm' >> ~/.bashrc && \
        echo 'if [ -f ~/.npmrc ]; then sed -i -e "/^prefix=/d" -e "/^globalconfig=/d" ~/.npmrc; fi' >> ~/.bashrc && \
        echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc && \
        echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.bashrc && \
        echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc && \
        bash -ic "source ~/.nvm/nvm.sh && \
                    nvm install ${NODE_VERSION} && \
                    nvm use ${NODE_VERSION} && \
                    nvm alias default ${NODE_VERSION} && \
                    npm config delete prefix 2>/dev/null || true && \
                    npm config delete globalconfig 2>/dev/null || true && \
                    npm config set prefix ~/.npm-global && \
                    npm install -g typescript ts-node @types/node"; \
    fi

############################
# Ruby layer - conditional  
############################
FROM node AS ruby
ARG WITH_RUBY
ARG RUBY_VERSION

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN if [ "$WITH_RUBY" = "true" ]; then \
        gpg --batch --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \
        curl -sSL https://get.rvm.io | bash -s stable && \
        source ~/.rvm/scripts/rvm && \
        rvm autolibs disable && \
        rvm install ${RUBY_VERSION} --disable-binary && \
        rvm use ${RUBY_VERSION} --default && \
        # Ensure Bundler present without pinning a specific patch level
        if ! command -v bundler >/dev/null; then gem install bundler; fi && \
        # Idempotent .bashrc updates with error handling
        grep -qxF '[ -s ~/.rvm/scripts/rvm ] && source ~/.rvm/scripts/rvm' ~/.bashrc || echo '[ -s ~/.rvm/scripts/rvm ] && source ~/.rvm/scripts/rvm' >> ~/.bashrc && \
        grep -qxF "rvm use ${RUBY_VERSION} --default 2>/dev/null || true" ~/.bashrc || echo "rvm use ${RUBY_VERSION} --default 2>/dev/null || true" >> ~/.bashrc; \
    fi

############################
# Python layer - conditional
############################
FROM ruby AS python
ARG WITH_PYTHON
ARG PYTHON_VERSION

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN if [ "$WITH_PYTHON" = "true" ]; then \
        curl https://pyenv.run | bash && \
        echo '' >> ~/.bashrc && \
        echo '# Pyenv configuration' >> ~/.bashrc && \
        echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc && \
        echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc && \
        echo 'eval "$(pyenv init --path)"' >> ~/.bashrc && \
        echo 'eval "$(pyenv init -)"' >> ~/.bashrc && \
        bash -ic "pyenv install ${PYTHON_VERSION} && \
                   pyenv global ${PYTHON_VERSION} && \
                   pip install --no-cache-dir --upgrade pip setuptools wheel"; \
    fi

############################
# Final development image
############################
FROM python AS dev
WORKDIR /workspace

# Health check for installed runtimes
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD ([ "$WITH_NODE" != "true" ] || bash -ic "node --version") && \
      ([ "$WITH_RUBY" != "true" ] || bash -lc "ruby --version") && \
      ([ "$WITH_PYTHON" != "true" ] || python --version) || exit 1

CMD ["/bin/bash"]