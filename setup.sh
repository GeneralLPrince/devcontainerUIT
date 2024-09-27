#!/usr/bin/env bash
set -e  # Exit immediately if a command exits with a non-zero status

echo "Starting setup.sh..."

echo "Installing Python3 and Git if not already installed..."
install_python() {
    if ! command -v python3 &> /dev/null; then
        echo "Python3 not found. Installing Python3..."
        sudo apt-get install python3 -y
    else
        echo "Python3 is already installed."
    fi
}

install_git() {
    if ! command -v git &> /dev/null; then
        echo "Git not found. Installing Git..."
        sudo apt-get install git -y
    else
        echo "Git is already installed."
    fi
}

install_python
install_git

echo "Cloning checkuit repository..."
TARGET_DIR="$HOME/checkuit"

if [ ! -d "$TARGET_DIR" ]; then
    git clone https://github.com/generallprince/checkuit.git "$TARGET_DIR"
    echo "Repository cloned to $TARGET_DIR."
else
    echo "Repository already exists at $TARGET_DIR. Pulling latest changes..."
    cd "$TARGET_DIR" && git pull
fi

echo "Setting up alias 'checkuit'..."
ALIAS="alias checkuit='python3 $TARGET_DIR/checkuit.py'"

# Ensure .bash_aliases is sourced in .bashrc
if ! grep -Fxq 'if [ -f ~/.bash_aliases ]; then' "$HOME/.bashrc"; then
    echo 'if [ -f ~/.bash_aliases ]; then' >> "$HOME/.bashrc"
    echo '    . ~/.bash_aliases' >> "$HOME/.bashrc"
    echo 'fi' >> "$HOME/.bashrc"
    echo ".bash_aliases sourcing added to .bashrc."
fi

# Add alias to .bash_aliases
if [ ! -f "$HOME/.bash_aliases" ]; then
    touch "$HOME/.bash_aliases"
    echo ".bash_aliases file created."
fi

if ! grep -Fxq "$ALIAS" "$HOME/.bash_aliases"; then
    echo "$ALIAS" >> "$HOME/.bash_aliases"
    echo "Alias 'checkuit' added to .bash_aliases."
else
    echo "Alias 'checkuit' already exists in .bash_aliases."
fi

# Source .bashrc to make the alias available in the current script's shell
source "$HOME/.bashrc"

echo "Setup completed successfully. Please restart your terminal or run 'source ~/.bashrc' to apply changes."
