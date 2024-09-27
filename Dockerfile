# Base image
FROM mcr.microsoft.com/vscode/devcontainers/python:3.11

# Install essential tools in one RUN command to optimize caching
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    python3-pip \
    git && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory to the repository root
WORKDIR /workspaces/devcontainerUIT

# Ensure the script has executable permissions
RUN chmod +x /workspaces/devcontainerUIT/setup.sh
