# ~/.zshrc

/home/graham/miniforge3/bin/conda init zsh > /dev/null

unsetopt SHARE_HISTORY
unsetopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS


# user vars
export EDITOR=nvim
export XDG_SESSION_TYPE=x11
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$HOME/go/bin:$PATH"
export PATH="$PATH:$HOME/.platformio/penv/bin"
export PATH="$PATH:/opt/microchip/xc32/v4.35/bin"

export PUID=1000
export PGID=1000
export TZ=America/New_York
export PLEX_CLAIM=

# plex 
export PLEX_SERVER_DIR=/home/graham/repos/plex-server
export MEDIA_PATH=${PLEX_SERVER_DIR}/media
export MOVIES_PATH=${PLEX_SERVER_DIR}/media/movies
export TV_PATH=${PLEX_SERVER_DIR}/media/tv
export PHOTOS_PATH=${PLEX_SERVER_DIR}/media/photos
export MUSIC_PATH=${PLEX_SERVER_DIR}/media/music

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

# fzf
source <(fzf --zsh)

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# user vars
export EDITOR=nvim
export XDG_SESSION_TYPE=x11
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$HOME/go/bin:$PATH"
export PATH="$PATH:$HOME/.platformio/penv/bin"
export PATH="$PATH:/opt/microchip/xc32/v4.35/bin"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# homebrew
if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# library path
if [[ ":$LD_LIBRARY_PATH:" != *":/usr/local/lib:"* ]]; then
    export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
fi

export NEXUS_DIR=~/work/nexus
export NEXUS_ROS_DISTRO=/opt/ros/humble
export NEXUS_OUTPUT=$NEXUS_DIR/output
export PX4_DIR=~/work/PX4-Autopilot
export MICRO_DDS_BRIDGE_DIR=~/work/Micro-XRCE-DDS-Agent
export ARK_JETSON_KERNEL_DIR=$HOME/work/tmp/ark_jetson_kernel
export ROS_DOMAIN_ID=3
export ROS_LOCALHOST_ONLY=0
export WP_BOX=$HOME/.fusion360/wineprefixes/default
export GZ_SIM_RESOURCE_PATH=$PX4_DIR/Tools/simulation/gz/worlds:$PX4_DIR/Tools/simulation/gz/models:$HOME/.gz/fuel/fuel.gazebosim.org/models
export STM32_PRG_PATH=$HOME/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin

# llvm
export LLVM_CONFIG_PATH=/usr/bin/llvm-config-14
export LIBCLANG_PATH=/usr/lib/llvm-14/lib/libclang.so

alias vim='nvim'
alias cura="~/Documents/prints/UltiMaker-Cura-5.3.0-linux-modern.AppImage"
alias sr2="source /opt/ros/humble/setup.zsh && source ~/ws/install/setup.zsh"
alias python="python3"

# docker x11 access (suppress output)
xhost +local:docker >/dev/null 2>&1

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
