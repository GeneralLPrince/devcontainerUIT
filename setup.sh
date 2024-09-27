#!/bin/bash

# Install Python and Git
install_python() {
    if ! command -v python3 &> /dev/null; then
        sudo apt-get update
        sudo apt-get install python3 -y
    fi
}

install_git() {
    if ! command -v git &> /dev/null; then
        sudo apt-get update
        sudo apt-get install git -y
    fi
}

install_python
install_git

# Clone checkuit repo if not already cloned
TARGET_DIR="/workspaces/checkuit"
if [ ! -d "$TARGET_DIR" ]; then
    git clone https://github.com/generallprince/checkuit.git "$TARGET_DIR"
fi

# Add alias to .bashrc if not already present
ALIAS="alias checkuit='python3 $TARGET_DIR/checkuit.py'"

if ! grep -Fxq "$ALIAS" ~/.bashrc; then
    echo "$ALIAS" >> ~/.bashrc
fi

# Source .bashrc in non-interactive shell
if [ "$-" != "${-#*i}" ]; then
    # Interactive shell
    source ~/.bashrc
else
    echo "Non-interactive shell, setting up alias for future sessions"
fi
