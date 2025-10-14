# ~/.zshrc

unsetopt SHARE_HISTORY
unsetopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="crunch"
CASE_SENSITIVE="true"
DISABLE_AUTO_TITLE="true"
HIST_STAMPS="yyyy-mm-dd"

zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 30

plugins=(
    git
    aliases
    common-aliases
    direnv
    docker
    docker-compose
    fzf
    python
    rsync
    rust
    safe-paste
    screen
    themes
    tmux
    ubuntu
    zoxide
    zsh-interactive-cd
)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

. "$HOME/.cargo/env"

eval "$(zoxide init --cmd cd zsh)"

if [ -f /opt/ros/humble/setup.zsh ]; then
  source /opt/ros/humble/setup.zsh

  if command -v register-python-argcomplete3 >/dev/null 2>&1; then
    eval "$(register-python-argcomplete3 ros2)"
    eval "$(register-python-argcomplete3 colcon)"
  fi
fi

if [ -f /usr/share/vcstool-completion/vcs.zsh ]; then
  source /usr/share/vcstool-completion/vcs.zsh
fi

use-protobuf-system() {
    export PATH="${PATH//:\/home\/graham\/.local\/bin/}"
    export PATH="${PATH//\/home\/graham\/.local\/bin:/}"
    export PATH="$PATH:/home/graham/.local/bin"
    export CMAKE_PREFIX_PATH="${CMAKE_PREFIX_PATH//:\/home\/graham\/.local/}"
    export CMAKE_PREFIX_PATH="${CMAKE_PREFIX_PATH//\/home\/graham\/.local:/}"
    export PKG_CONFIG_PATH="${PKG_CONFIG_PATH//:\/home\/graham\/.local\/lib\/pkgconfig/}"
    export LD_LIBRARY_PATH="${LD_LIBRARY_PATH//:\/home\/graham\/.local\/lib/}"
    echo "Using system protobuf: $(protoc --version)"
}

use-protobuf-local() {
    export PATH="${PATH//:\/home\/graham\/.local\/bin/}"
    export PATH="${PATH//\/home\/graham\/.local\/bin:/}"
    export PATH="/home/graham/.local/bin:$PATH"
    export CMAKE_PREFIX_PATH="/home/graham/.local:$CMAKE_PREFIX_PATH"
    export PKG_CONFIG_PATH="/home/graham/.local/lib/pkgconfig:$PKG_CONFIG_PATH"
    export LD_LIBRARY_PATH="/home/graham/.local/lib:$LD_LIBRARY_PATH"
    echo "Using local protobuf: $(protoc --version)"
}
use-protobuf-system

# load shared environment variables between bashrc and zshrc
[ -f ~/.shell_common ] && source ~/.shell_common

# load sensitive environment variables
[ -f ~/.env ] && source ~/.env
