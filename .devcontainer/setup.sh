#!/usr/bin/env bash
set -e  # Exit immediately if a command exits with a non-zero status

echo "============================="
echo "Starting setup.sh script..."
echo "============================="

# Display current user and home directory for debugging
echo "Running as user: $(whoami)"
echo "Home directory: $HOME"

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

# Function to install MySQL if not already installed
install_mysql() {
    if ! command -v mysql &> /dev/null; then
        echo "MySQL not found. Installing MySQL..."
        sudo apt-get install mysql-server -y
        echo "MySQL installed successfully."
    else
        echo "MySQL is already installed."
    fi
}

# Function to install SQLite3 if not already installed
install_sqlite3() {
    if ! command -v sqlite3 &> /dev/null; then
        echo "SQLite3 not found. Installing SQLite3..."
        sudo apt-get install sqlite3 -y
        echo "SQLite3 installed successfully."
    else
        echo "SQLite3 is already installed."
    fi
}

# Install necessary packages
echo "Installing necessary packages..."
install_python
install_git
install_mysql
install_sqlite3

# Clone the checkuit repository if it doesn't exist
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

# Define the alias
ALIAS="alias checkuit='python3 $TARGET_DIR/checkuit.py'"

# Add the alias directly to .bashrc
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
echo "Please restart your terminal or run 'source ~/.bashrc' to apply changes."

rm -r "/workspaces/devcontainerUIT/.devcontainer"
