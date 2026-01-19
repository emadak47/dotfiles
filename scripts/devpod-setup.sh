#!/bin/bash
set -e

echo "Installing dotfiles dependencies..."

apt-get update && apt-get install -y \
    bat \
    neovim \
    eza \
    stow \
    fish \
    tig \
    tmux \
    || echo "Some packages may have failed to install (this is OK if already installed)"

cd ~/dotfiles

echo "Applying dotfiles with stow..."
stow -t ~ nvim bat tig tmux fish

echo "Dotfiles installation complete!"
