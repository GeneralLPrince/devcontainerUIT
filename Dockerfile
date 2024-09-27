# Base image
FROM mcr.microsoft.com/vscode/devcontainers/python:3.11

# Install tools
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl

# Copy setup script to /opt directory
COPY setup.sh /opt/devcontainer/setup.sh

# Make the script executable
RUN chmod +x /opt/devcontainer/setup.sh

# Run the setup script during container creation
RUN /bin/bash /opt/devcontainer/setup.sh
