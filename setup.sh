#!/bin/bash

# Install Python and Git
install_python() {
    if ! command -v python3 &> /dev/null; then
        sudo apt-get install python3 -y
    fi
}

install_git() {
    if ! command -v git &> /dev/null; then
        sudo apt-get install git -y
    fi
}

install_python
install_git

# Clone checkuit repo
TARGET_DIR="/workspaces/checkuit"

if [ ! -d "$TARGET_DIR" ]; then
    git clone https://github.com/generallprince/checkuit.git "$TARGET_DIR"
fi

# Add alias
ALIAS="alias checkuit='python3 $TARGET_DIR/checkuit.py'"

if ! grep -Fxq "$ALIAS" ~/.bashrc; then
    echo "$ALIAS" >> ~/.bashrc
    source ~/.bashrc
fi
