#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

FILES=(
  ".bashrc"
  ".gitconfig"
  ".gitignore"
  ".tmux.conf"
  ".zshrc"
  "config.conf"
)

echo "Creating symlinks from $DOTFILES_DIR to home directory..."

for file in "${FILES[@]}"; do
  src="$DOTFILES_DIR/$file"
  dest="$HOME/$file"

  # If the source doesn't exist, skip
  if [ ! -e "$src" ]; then
    echo "Skipping $file (not found in repo)"
    continue
  fi

  if [ -d "$src" ]; then
    ln -sfn "$src" "$dest"
  else
    ln -sf "$src" "$dest"
  fi

  echo "Linked $file -> $dest"
done

echo "All symlinks created successfully."
