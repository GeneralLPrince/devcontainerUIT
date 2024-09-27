#!/bin/bash

# Install Python and Git for Linux environments
install_python() {
    if ! command -v python3 &> /dev/null
    then
        echo "Python not found. Installing Python..."
        sudo apt-get update
        sudo apt-get install python3 -y
    else
        echo "Python is already installed."
    fi
}

install_git() {
    if ! command -v git &> /dev/null
    then
        echo "Git not found. Installing Git..."
        sudo apt-get update
        sudo apt-get install git -y
    else
        echo "Git is already installed."
    fi
}

# Clone checkuit repo and add alias
TARGET_DIR="/workspaces/checkuit"

install_python
install_git

if [ -d "$TARGET_DIR" ]; then
    echo "checkuit is already installed in $TARGET_DIR"
else
    echo "Cloning checkuit from GitHub..."
    git clone https://github.com/generallprince/checkuit.git "$TARGET_DIR"
    if [ $? -ne 0 ]; then
        echo "Failed to clone checkuit repository."
        exit 1
    fi
fi

ALIAS="alias checkuit='python3 $TARGET_DIR/checkuit.py'"

if ! grep -Fxq "$ALIAS" ~/.bashrc; then
    echo "$ALIAS" >> ~/.bashrc
    echo "Alias added. Sourcing..."
    source ~/.bashrc
fi
