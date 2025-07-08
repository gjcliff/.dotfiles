#!/bin/bash
set -e

# update apt
sudo apt update

# install build tools and utilities
sudo apt install -y \
    build-essential \
    ninja-build \
    cmake \
    zsh \
    neofetch

# install rust (rustup and cargo)
if ! command -v cargo &>/dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source $HOME/.cargo/env
else
    echo "rust is already installed."
fi

# ensure cargo is in path
source $HOME/.cargo/env

# install zoxide with cargo
cargo install zoxide --locked

# install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "oh-my-zsh already installed."
fi

echo "done. you can switch to zsh with: zsh"
echo "or set it as your default shell with: chsh -s $(which zsh)"
