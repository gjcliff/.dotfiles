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
   log_error "this script should not be run as root"
   exit 1
fi

log_info "updating apt"
sudo apt update

log_info "installing build tools and utilities"
sudo apt install -y \
    build-essential \
    ninja-build \
    cmake \
    zsh \
    neofetch \
    tmux \
    direnv \
    python3-argcomplete

log_success "build tools installed"

# install fzf
if ! command -v fzf &>/dev/null; then
    log_info "installing fzf"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

# install rust
if ! command -v cargo &>/dev/null; then
    log_info "installing rust"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    log_success "rust installed"
else
    log_info "rust is already installed"
    source "$HOME/.cargo/env"
fi

# install zoxide
log_info "installing zoxide"
if cargo install zoxide --locked; then
    log_success "zoxide installed"
else
    log_error "failed to install zoxide"
fi

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log_info "installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    log_success "oh-my-zsh installed"
else
    log_info "oh-my-zsh already installed"
fi

echo ""
log_success "installation complete!"
echo ""
echo "next steps:"
echo "  1. run ./install_symlinks.sh to set up dotfiles"
echo "  2. switch to zsh: chsh -s \$(which zsh)"
echo "  3. restart your terminal"
