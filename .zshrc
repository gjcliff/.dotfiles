# ~/.zshrc

unsetopt SHARE_HISTORY
unsetopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="dst"
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

if command -v register-python-argcomplete3 >/dev/null 2>&1; then
    eval "$(register-python-argcomplete3 ros2)"
    eval "$(register-python-argcomplete3 colcon)"
fi

if [ -f /usr/share/vcstool-completion/vcs.zsh ]; then
  source /usr/share/vcstool-completion/vcs.zsh
fi

use-protobuf-system() {
    export CMAKE_PREFIX_PATH=$(echo "$CMAKE_PREFIX_PATH" | tr ':' '\n' | grep -v "$HOME/.local" | tr '\n' ':' | sed 's/:$//')
    export CMAKE_IGNORE_PATH="$HOME/.local"
    export PATH="/usr/bin:$PATH"
    echo "Using system protobuf: $(protoc --version)"
}

use-protobuf-local() {
    export CMAKE_PREFIX_PATH="$HOME/.local:$CMAKE_PREFIX_PATH"
    export PKG_CONFIG_PATH="$HOME/.local/lib/pkgconfig:$PKG_CONFIG_PATH"
    export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"
    unset CMAKE_IGNORE_PATH
    export PATH="$HOME/.local/bin:$PATH"
    echo "Using local protobuf: $(protoc --version)"
}
neofetch

[ -f ~/.shell_common ] && source ~/.shell_common
[ -f ~/.env ] && source ~/.env
use-protobuf-system
