#!/bin/bash
set -euo pipefail

# Colors
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

log_error() {
    echo -e "${RED}[✗]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# check if running as root
if [[ $EUID -eq 0 ]]; then
   log_error "This script should not be run as root"
   exit 1
fi

log_info "Updating apt..."
sudo apt update

log_info "Installing build tools and utilities..."
sudo apt install -y \
    build-essential \
    ninja-build \
    cmake \
    zsh \
    neofetch \
    fzf \
    tmux \
    direnv \
    python3-argcomplete

log_success "Build tools installed"

# Install rust
if ! command -v cargo &>/dev/null; then
    log_info "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    log_success "Rust installed"
else
    log_info "Rust is already installed"
fi

# Ensure cargo is in path
source "$HOME/.cargo/env"

# Install zoxide
log_info "Installing zoxide..."
if cargo install zoxide --locked; then
    log_success "zoxide installed"
else
    log_error "Failed to install zoxide"
fi

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log_info "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    log_success "oh-my-zsh installed"
else
    log_info "oh-my-zsh already installed"
fi

echo ""
log_success "Installation complete!"
echo ""
echo "Next steps:"
echo "  1. Run ./install_symlinks.sh to set up dotfiles"
echo "  2. Copy .env.example to .env and add your tokens"
echo "  3. Switch to zsh: chsh -s \$(which zsh)"
echo "  4. Restart your terminal"
