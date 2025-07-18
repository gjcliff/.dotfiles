# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 "(%s)")\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH=$PATH:~/.local/bin
# source /opt/ros/iron/setup.bash
# source ~/ws/interbotix/install/setup.bash
source /usr/share/doc/fzf/examples/key-bindings.bash
# Install Ruby Gems to ~/gems
# export XDG_SESSION_TYPE=xcb
export XDG_SESSION_TYPE=x11

export COPPELIASIM_ROOT_DIR="$HOME/classes/Q1/ME449/CoppeliaSim_Edu_V4_5_1_rev4_Ubuntu22_04"
alias coppelia="$COPPELIASIM_ROOT_DIR/coppeliaSim.sh"

source /usr/share/colcon_cd/function/colcon_cd.sh
# export _colcon_cd_root=/opt/ros/iron/
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash

export PATH=$PATH:/opt/microchip/xc32/v4.35/bin

alias vim='nvim'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [[ ":$LD_LIBRARY_PATH:" != *":/usr/local/lib:"* ]]; then
    export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
fi

export EDITOR=nvim

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
. "$HOME/.cargo/env"

alias qflipper="sudo ~/.appimages/qFlipper-x86_64-1.3.3.AppImage"
alias cura="~/Documents/prints/UltiMaker-Cura-5.3.0-linux-modern.AppImage"
# alias neofetch="neofetch --source ~/.config/neofetch/pngs/sad_pepe.png"
xhost +local:docker
clear
neofetch
source /home/graham/Documents/personal/alacritty/alacritty/extra/completions/alacritty.bash

# work
source /opt/ros/humble/setup.bash
export NEXUS_DIR=~/work/nexus
export NEXUS_ROS_DISTRO=/opt/ros/humble
export NEXUS_OUTPUT=$NEXUS_DIR/output
export PX4_DIR=~/work/PX4-Autopilot
export MICRO_DDS_BRIDGE_DIR=~/work/Micro-XRCE-DDS-Agent
export MAPBOX_ACCESS_TOKEN=pk.eyJ1IjoibWFnaS0yIiwiYSI6ImNtNmxhaXhyMjA3NHkyaW9xbHN5bzY5bjIifQ.FEk3P3eh75NARHBTr2mI0g
export RERUN_MAPBOX_ACCESS_TOKEN=$MAPBOX_ACCESS_TOKEN
export ARK_JETSON_KERNEL_DIR=/home/graham/work/tmp/ark_jetson_kernel
export ROS_DOMAIN_ID=3
export ROS_LOCALHOST_ONLY=0

export WP_BOX=$HOME/.fusion360/wineprefixes/default

export GZ_SIM_RESOURCE_PATH=$PX4_DIR/Tools/simulation/gz:$HOME/work/PX4-Autopilot/Tools/simulation/gz/models:$HOME/.gz/fuel/fuel.gazebosim.org/models:$GZ_SIM_RESOURCE_PATH

export STM32_PRG_PATH=/home/graham/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin