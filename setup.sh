#!/usr/bin/env bash
set -e  # Exit immediately if a command exits with a non-zero status

echo "============================="
echo "Starting setup.sh script..."
echo "============================="

# Function to install Python3 if not already installed
install_python() {
    if ! command -v python3 &> /dev/null; then
        echo "Python3 not found. Installing Python3..."
        sudo apt-get install python3 -y
        echo "Python3 installed successfully."
    else
        echo "Python3 is already installed."
    fi
}

# Function to install Git if not already installed
install_git() {
    if ! command -v git &> /dev/null; then
        echo "Git not found. Installing Git..."
        sudo apt-get install git -y
        echo "Git installed successfully."
    else
        echo "Git is already installed."
    fi
}

# Install necessary packages
echo "Installing necessary packages..."
install_python
install_git

# Clone the checkuit repository if it doesn't exist
echo "Cloning checkuit repository..."
TARGET_DIR="$HOME/checkuit"

if [ ! -d "$TARGET_DIR" ]; then
    git clone https://github.com/generallprince/checkuit.git "$TARGET_DIR"
    echo "Repository cloned to $TARGET_DIR."
else
    echo "Repository already exists at $TARGET_DIR. Pulling latest changes..."
    cd "$TARGET_DIR" && git pull
    echo "Repository updated."
fi

# Define the alias
ALIAS="alias checkuit='python3 $TARGET_DIR/checkuit.py'"

# Ensure .bash_aliases is sourced in .bashrc
echo "Ensuring .bash_aliases is sourced in .bashrc..."
if ! grep -Fxq 'if [ -f ~/.bash_aliases ]; then' "$HOME/.bashrc"; then
    echo 'if [ -f ~/.bash_aliases ]; then' >> "$HOME/.bashrc"
    echo '    . ~/.bash_aliases' >> "$HOME/.bashrc"
    echo 'fi' >> "$HOME/.bashrc"
    echo ".bash_aliases sourcing added to .bashrc."
else
    echo ".bash_aliases is already sourced in .bashrc."
fi

# Add the alias to .bash_aliases
echo "Adding alias to .bash_aliases..."
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

echo "============================="
echo "setup.sh script completed."
echo "============================="
echo "Please restart your terminal or run 'source ~/.bashrc' to apply changes."
