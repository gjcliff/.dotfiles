#!/bin/bash
set -euo pipefail

readonly DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# colors
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

FILES=(
  ".zshrc"
  ".bashrc"
  ".gitconfig"
  ".gitignore"
  ".tmux.conf"
  ".config/neofetch/config.conf"
  ".config/alacritty/alacritty.toml"
  ".config/neofetch/config.conf"
  ".oh-my-zsh/custom/themes/dst.zsh-theme"
)

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[!]${NC} $1"
}

echo "creating symlinks from $DOTFILES_DIR to home directory..."
echo ""

for file in "${FILES[@]}"; do
  src="$DOTFILES_DIR/$file"
  dest="$HOME/$file"

  if [ ! -e "$src" ]; then
    log_warn "skipping $file (not found in repo)"
    continue
  fi

  # create backup if destination exists and is not a symlink
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mkdir -p "$BACKUP_DIR/$(dirname "$file")"
    cp -a "$dest" "$BACKUP_DIR/$file"
    log_info "backed up $file"
  fi

  # create parent directory if needed
  mkdir -p "$(dirname "$dest")"

  # create symlink
  if [ -d "$src" ]; then
    ln -sfn "$src" "$dest"
  else
    ln -sf "$src" "$dest"
  fi

  log_success "linked $file"
done

echo ""
log_success "all symlinks created successfully!"
[ -d "$BACKUP_DIR" ] && echo -e "${BLUE}[INFO]${NC} backups saved to: $BACKUP_DIR"
