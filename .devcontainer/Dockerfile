# Use the official Python image as the base
FROM mcr.microsoft.com/vscode/devcontainers/python:3.11

# Install necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /workspaces/devcontainerUIT

# Optionally, run the setup script
CMD ["/workspaces/devcontainerUIT/.devcontainer/setup.sh"]
