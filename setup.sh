#!/bin/bash

# Update package lists and install Python and Git
install_python() {
    if ! command -v python3 &> /dev/null; then
        apt-get update
        apt-get install python3 -y
    fi
}

install_git() {
    if ! command -v git &> /dev/null; then
        apt-get update
        apt-get install git -y
    fi
}

install_python
install_git

# Clone checkuit repo if not already cloned
TARGET_DIR="/workspaces/checkuit"

if [ ! -d "$TARGET_DIR" ]; then
    git clone https://github.com/generallprince/checkuit.git "$TARGET_DIR"
fi

# Define the alias
ALIAS="alias checkuit='python3 $TARGET_DIR/checkuit.py'"

# Add alias to .bash_aliases for the 'codespace' user
sudo -u codespace bash -c "
if ! grep -Fxq '$ALIAS' ~/.bash_aliases; then
    echo \"$ALIAS\" >> ~/.bash_aliases
    echo 'Alias added to .bash_aliases'
fi
"
