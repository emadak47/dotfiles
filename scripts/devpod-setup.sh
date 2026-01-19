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

FISH_CONFIG="$HOME/.config/fish/config.fish"
FISH_PATH_LINE='fish_add_path "/opt/nvim-linux-x86_64/bin"'

if [ -f "$FISH_CONFIG" ]; then
    if ! grep -q "/opt/nvim-linux-x86_64/bin" "$FISH_CONFIG"; then
        echo "" >> "$FISH_CONFIG"
        echo "# Add Neovim to PATH" >> "$FISH_CONFIG"
        echo "$FISH_PATH_LINE" >> "$FISH_CONFIG"
        echo "Added Neovim to fish PATH"
    else
        echo "Neovim already in fish PATH"
    fi
else
    echo "Warning: $FISH_CONFIG not found. You may need to manually add: $FISH_PATH_LINE"
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
stow -t ~ nvim bat git shell tig tmux zsh fish alacritty

echo ""
echo "=========================================="
echo "Dotfiles installation complete!"
echo "=========================================="
echo ""
