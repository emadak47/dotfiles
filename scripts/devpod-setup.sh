#!/bin/bash
set -e

echo "Installing dotfiles dependencies..."

apt-get update

apt-get install -y \
    bat \
    eza \
    stow \
    fish \
    tig \
	ripgrep \
	fzf \
    || echo "Some packages may have failed to install (this is OK if already installed)"

echo "Installing Neovim from GitHub releases..."
NVIM_DIR="/opt/nvim-linux-x86_64"
if [ ! -d "$NVIM_DIR" ] || [ ! -f "$NVIM_DIR/bin/nvim" ]; then
    cd /tmp
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo rm -rf "$NVIM_DIR"
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
    rm nvim-linux-x86_64.tar.gz
    echo "Neovim installed to $NVIM_DIR"
else
    echo "Neovim already installed"
fi

echo "Installing Starship..."
if ! command -v starship &> /dev/null; then
    curl -sS https://starship.rs/install.sh | sh
    echo "Starship installed"
else
    echo "Starship already installed"
fi

cd ~/dotfiles

echo "Applying dotfiles with stow..."
stow -t ~ nvim bat tig fish

echo "Adding Neovim to fish PATH..."
fish -c 'fish_add_path "/opt/nvim-linux-x86_64/bin"'

echo "Changing default shell to fish..."
if command -v fish &> /dev/null; then
    FISH_PATH=$(which fish)
    if [ -n "$FISH_PATH" ]; then
        chsh -s "$FISH_PATH" || echo "Warning: Could not change shell (may need to be done manually)"
        echo "Default shell changed to fish: $FISH_PATH"
    else
        echo "Warning: Could not find fish binary"
    fi
else
    echo "Warning: fish not found"
fi

echo ""
echo "=========================================="
echo "Dotfiles installation complete!"
echo "=========================================="
echo ""
echo "Note: You may need to restart your shell or run:"
echo "  exec fish"
echo ""
