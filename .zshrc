# ~/.zshrc

/home/graham/miniforge3/bin/conda init zsh > /dev/null

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/graham/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/graham/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/graham/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/graham/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/home/graham/miniforge3/bin/mamba';
export MAMBA_ROOT_PREFIX='/home/graham/miniforge3';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
