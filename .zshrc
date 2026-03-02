# ~/.zshrc

unsetopt SHARE_HISTORY
unsetopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

DISABLE_AUTO_TITLE="true"
export PROMPT_IGNORE_EXIT_CODE=true

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="dst"
CASE_SENSITIVE="true"
DISABLE_AUTO_TITLE="true"
HIST_STAMPS="yyyy-mm-dd"

if [ -f /.dockerenv ] || grep -q docker /proc/1/cgroup 2>/dev/null; then
    export IN_DOCKER="docker"
fi

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

if [ -n "$IN_DOCKER" ]; then
  PROMPT=${PROMPT//\\n/}               # remove accidental newlines
  PROMPT="%{$fg[cyan]%}($IN_DOCKER)%{$reset_color%} $PROMPT"
fi

. "$HOME/.cargo/env"

eval "$(zoxide init --cmd cd zsh)"

if command -v register-python-argcomplete3 >/dev/null 2>&1; then
    eval "$(register-python-argcomplete3 ros2)"
    eval "$(register-python-argcomplete3 colcon)"
fi

if [ -f /usr/share/vcstool-completion/vcs.zsh ]; then
  source /usr/share/vcstool-completion/vcs.zsh
fi

neofetch

source <(fzf --zsh)

[ -f ~/.shell_common ] && source ~/.shell_common
[ -f ~/.env ] && source ~/.env

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
