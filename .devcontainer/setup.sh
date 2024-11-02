#!/usr/bin/env bash
set -e 

echo "============================="
echo "Starting setup.sh script..."
echo "============================="

install_python() {
    if ! command -v python3 &> /dev/null; then
        echo "Python3 not found. Installing Python3..."
        sudo apt-get install python3 -y
        echo "Python3 installed successfully."
    else
        echo "Python3 is already installed."
    fi
}

install_git() {
    if ! command -v git &> /dev/null; then
        echo "Git not found. Installing Git..."
        sudo apt-get install git -y
        echo "Git installed successfully."
    else
        echo "Git is already installed."
    fi
}

echo "Installing necessary packages..."
install_python
install_git

echo "Cloning checkuit repository..."
TARGET_DIR="/workspaces/checkuit/"

if [ ! -d "$TARGET_DIR" ]; then
    git clone https://github.com/generallprince/checkuit.git "$TARGET_DIR"
    echo "Repository cloned to $TARGET_DIR."
else
    echo "Repository already exists at $TARGET_DIR. Pulling latest changes..."
    cd "$TARGET_DIR" && git pull
    echo "Repository updated."
fi

ALIAS="alias checkuit='python3 $TARGET_DIR/checkuit.py'"

echo "Adding alias directly to .bashrc..."
if ! grep -Fxq "$ALIAS" "$HOME/.bashrc"; then
    echo "$ALIAS" >> "$HOME/.bashrc"
    echo "Alias 'checkuit' added to .bashrc."
else
    echo "Alias 'checkuit' already exists in .bashrc."
fi

echo "============================="
echo "setup.sh script completed."
echo "============================="

rm -r "/workspaces/devcontainerUIT/.devcontainer"
