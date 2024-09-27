# Base the container on the Python 3.11 image
FROM mcr.microsoft.com/vscode/devcontainers/python:3.11

# Install necessary development tools
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl

# Copy the setup script into the container
COPY setup.sh /usr/local/bin/setup.sh

# Make the script executable
RUN chmod +x /usr/local/bin/setup.sh

# Run the setup script
RUN /bin/bash /usr/local/bin/setup.sh
