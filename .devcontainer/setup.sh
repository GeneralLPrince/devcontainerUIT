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

# Install necessary packages
echo "Installing necessary packages..."
install_python
install_git

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

# Configure Git user (if needed)
echo "Configuring Git user..."
git config --global user.email "your_email@example.com"  # Update with your email
git config --global user.name "Your Name"  # Update with your name

# Add changes and push to remote repository
echo "Pushing changes to remote repository..."
git add .
git commit -m "Automated commit from setup.sh" || echo "No changes to commit"
git push origin main  # Adjust to your branch name if different

echo "============================="
echo "setup.sh script completed."
echo "============================="
echo "Please restart your terminal or run 'source ~/.bashrc' to apply changes."

# Remove the devcontainer folder
rm -rf "/workspaces/devcontainerUIT/.devcontainer"
