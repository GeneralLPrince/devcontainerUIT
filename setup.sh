#!/bin/bash

# Update package lists and install Python and Git
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

# Add alias to .bash_aliases if not already present
alias checkuit='python3 /workspaces/checkuit/checkuit.py'

if ! grep -Fxq "$ALIAS" ~/.bash_aliases; then
    echo "$ALIAS" >> ~/.bash_aliases
    echo "Alias added to .bash_aliases"
fi

# Source both .bashrc and .bash_aliases
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi
