# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# case insensitive completion in shell
bind 'set completion-ignore-case on'

# bash history configuration
shopt -s histappend
export HISTFILESIZE=20000
export HISTSIZE=5000
# avoid duplicates..
export HISTCONTROL="ignoredups:erasedups:ignoreboth"

source ~/.git-prompt.sh

LESSHISTSIZE=200
# Make 'less' more friendly for non-text input files, see lesspipe(1).
which lesspipe1.sh > /dev/null && eval "$(lesspipe.sh)"

# Terminal colors settings.
color_prompt=yes

if [ "$color_prompt" = yes ]; then
    CYAN="\[\033[00;36m\]"
    GREEN="\[\033[00;32m\]"
    RED="\[\033[0;31m\]"
    WHITE="\[\033[00m\]"
    YELLOW="\[\033[0;33m\]"
    PS1="$RED\$(date +%H:%M) $CYAN\w$YELLOW\$(__git_ps1) $WHITE\$ "
else
    PS1="\$(date +%H:%M) \w\$(__git_ps1) \$ "
fi
unset color_prompt force_color_prompt

# Tweak colors for 'ls' command.
# See http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
#
# Dark terminal themes
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Light terminal themes
#export CLICOLOR=1
#export LSCOLORS=ExFxBxDxCxegedabagacad

# MK: hardcode the path to `bash-completion`. Resolution via `brew` is slow.
bash_completion_path=/usr/local/etc/bash_completion
# 'brew install git bash-completion' wants this to be done
if [ -f $bash_completion_path ]; then
  #. $(brew --prefix)/etc/bash_completion
  . $bash_completion_path
fi

# source setting for PATH and variables.
. ~/.bashrc-paths-vars

# Be sure to load aliases after all environments variables are defined
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Shell function definitions
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# set Vim as editor
export EDITOR=gvim
export VISUAL=$EDITOR

# Use e.g. by Vim during editing ChangeLogs
export EMAIL="Martin Krauskopf <martin.krauskopf@gmail.com>"

# colors for bash scripts
export C_DEFAULT="\x1B[39m"
export C_BLACK="\x1B[30m"
export C_RED="\x1B[31m"
export C_GREEN="\x1B[32m"
export C_YELLOW="\x1B[33m"
export C_BLUE="\x1B[34m"
export C_MAGENTA="\x1B[35m"
export C_CYAN="\x1B[36m"
export C_LIGHT_GRAY="\x1B[37m"
export C_DARK_GRAY="\x1B[90m"
export C_LIGHT_RED="\x1B[91m"
export C_LIGHT_GREEN="\x1B[92m"
export C_LIGHT_YELLOW="\x1B[93m"
export C_LIGHT_BLUE="\x1B[94m"
export C_LIGHT_MAGENTA="\x1B[95m"
export C_LIGHT_CYAN="\x1B[96m"
export C_WHITE="\x1B[97m"

# colors for bash scripts
export ECHO_C_DEFAULT="echo -ne $C_DEFAULT"
export ECHO_C_BLACK="echo -ne $C_BLACK"
export ECHO_C_RED="echo -ne $C_RED"
export ECHO_C_GREEN="echo -ne $C_GREEN"
export ECHO_C_YELLOW="echo -ne $C_YELLOW"
export ECHO_C_BLUE="echo -ne $C_BLUE"
export ECHO_C_MAGENTA="echo -ne $C_MAGENTA"
export ECHO_C_CYAN="echo -ne $C_CYAN"
export ECHO_C_LIGHT_GRAY="echo -ne $C_LIGHT_GRAY"
export ECHO_C_DARK_GRAY="echo -ne $C_DARK_GRAY"
export ECHO_C_LIGHT_RED="echo -ne $C_LIGHT_RED"
export ECHO_C_LIGHT_GREEN="echo -ne $C_LIGHT_GREEN"
export ECHO_C_LIGHT_YELLOW="echo -ne $C_LIGHT_YELLOW"
export ECHO_C_LIGHT_BLUE="echo -ne $C_LIGHT_BLUE"
export ECHO_C_LIGHT_MAGENTA="echo -ne $C_LIGHT_MAGENTA"
export ECHO_C_LIGHT_CYAN="echo -ne $C_LIGHT_CYAN"
export ECHO_C_WHITE="echo -ne $C_WHITE"

# Grep options
#GREP_OPTIONS=
for pattern in .cvs .git .hg .svn; do
  GREP_OPTIONS="$GREP_OPTIONS --exclude-dir=$pattern"
done
export GREP_OPTIONS

# https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Node Version Manager
# See https://github.com/creationix/nvm/issues/539
# nvm (Node Version Manager) set up according to Homebrew
export NVM_DIR=~/.nvm
# MK: hardcode the path to `nvm.sh`. Resolution vai `brew` is slow.
NVM_SH="/usr/local/opt/nvm/nvm.sh"
#NVM_SH=$(brew --prefix nvm)/nvm.sh
source $NVM_SH --no-use
#alias node='unalias node ; unalias npm ; nvm use default ; node $@'
#alias npm='unalias node ; unalias npm ; nvm use default ; npm $@'

# nvm bash completion
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

# See https://github.com/rbenv/rbenv
which rbenv > /dev/null && eval "$(rbenv init -)"

# See https://github.com/nvbn/thefuck
eval $(thefuck --alias)

