# Base image
FROM mcr.microsoft.com/vscode/devcontainers/python:3.11

# Install essential tools in one RUN command to optimize caching
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    python3-pip \
    git && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /workspaces/devcontainerUIT

# Create the target directory for setup scripts
RUN mkdir -p /opt/devcontainerUIT

# Copy setup script to /opt/devcontainerUIT directory
COPY setup.sh /opt/devcontainerUIT/setup.sh

# Make the script executable
RUN chmod +x /opt/devcontainerUIT/setup.sh
