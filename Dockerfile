# Base image
FROM mcr.microsoft.com/vscode/devcontainers/python:3.11

# Install essential tools in one RUN command to optimize caching
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    python3-pip \
    git && \
    rm -rf /var/lib/apt/lists/*

# Copy setup script to /opt/devcontainer directory
COPY setup.sh /opt/devcontainer/setup.sh

# Make the script executable
RUN chmod +x /opt/devcontainer/setup.sh
