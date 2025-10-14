#!/bin/bash
set -euo pipefail

readonly DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# Colors
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

FILES=(
  ".zshrc"
  ".bashrc"
  ".shell_common"
  ".gitconfig"
  ".gitignore"
  ".tmux.conf"
  ".config/neofetch/config.conf"
  ".config/alacritty/alacritty.toml"
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

echo "Creating symlinks from $DOTFILES_DIR to home directory..."
echo ""

for file in "${FILES[@]}"; do
  src="$DOTFILES_DIR/$file"
  dest="$HOME/$file"

  # If the source doesn't exist, skip
  if [ ! -e "$src" ]; then
    log_warn "Skipping $file (not found in repo)"
    continue
  fi

  # Create backup if destination exists and is not a symlink
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mkdir -p "$BACKUP_DIR/$(dirname "$file")"
    cp -a "$dest" "$BACKUP_DIR/$file"
    log_info "Backed up $file"
  fi

  # Create parent directory if needed
  mkdir -p "$(dirname "$dest")"

  # Create symlink
  if [ -d "$src" ]; then
    ln -sfn "$src" "$dest"
  else
    ln -sf "$src" "$dest"
  fi

  log_success "Linked $file"
done

echo ""
log_success "All symlinks created successfully!"
[ -d "$BACKUP_DIR" ] && echo -e "${BLUE}[INFO]${NC} Backups saved to: $BACKUP_DIR"

# Check for .env file
if [ ! -f "$HOME/.env" ] && [ -f "$DOTFILES_DIR/.env.example" ]; then
  echo ""
  log_warn "Don't forget to create ~/.env from .env.example"
  echo "  cp $DOTFILES_DIR/.env.example ~/.env"
  echo "  Then edit ~/.env to add your tokens"
fi
