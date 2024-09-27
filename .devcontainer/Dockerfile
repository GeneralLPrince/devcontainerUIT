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

# Ensure the setup script has executable permissions
RUN chmod +x /workspaces/devcontainerUIT/.devcontainer/setup.sh

# Optionally, run the setup script
CMD ["/workspaces/devcontainerUIT/.devcontainer/setup.sh"]
