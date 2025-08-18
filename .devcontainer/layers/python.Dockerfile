# syntax=docker/dockerfile:1

############################
# Python Layer via apt (simpler than pyenv)
############################
FROM layer-base AS layer-python

ARG PYTHON_VERSION=3.11

# Install Python via apt - more reliable than pyenv in containers
RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
        python${PYTHON_VERSION} \
        python${PYTHON_VERSION}-dev \
        python${PYTHON_VERSION}-venv \
        python3-pip \
    && sudo apt-get autoremove -y && sudo apt-get clean -y && sudo rm -rf /var/lib/apt/lists/*

# Set up Python symlinks and upgrade pip
RUN sudo ln -sf /usr/bin/python${PYTHON_VERSION} /usr/bin/python && \
    sudo ln -sf /usr/bin/python${PYTHON_VERSION} /usr/bin/python3 && \
    python -m pip install --upgrade pip setuptools wheel

# Verify installation
RUN python --version && pip --version
