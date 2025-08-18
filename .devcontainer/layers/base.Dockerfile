# syntax=docker/dockerfile:1

############################
# Base Layer - OS & System Dependencies
############################
FROM ubuntu:22.04 AS layer-base

ENV DEBIAN_FRONTEND=noninteractive

# ---- Build arguments ---- #
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

# ---- System dependencies ---- #
RUN apt-get update && apt-get install -y --no-install-recommends \
        git curl wget build-essential \
        libssl-dev libreadline-dev zlib1g-dev \
        libbz2-dev libsqlite3-dev libffi-dev liblzma-dev \
        libncurses5-dev libncursesw5-dev libgdbm-dev libgdbm6 libdb-dev libyaml-dev \
        libnss3-dev libtinfo5 \
        vim sudo ca-certificates gnupg software-properties-common \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# ---- Non-root user ---- #
RUN groupadd --gid ${USER_GID} ${USERNAME} && \
    useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} && \
    echo "${USERNAME} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME}

USER ${USERNAME}
WORKDIR /home/${USERNAME}
SHELL ["/bin/bash", "-lc"]
