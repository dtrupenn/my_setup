#!/usr/bin/env bash

# Finding things
function findin () {
    find . -exec grep -q "$1" '{}' \; -print
}

# Extracting files
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1    ;;
            *.tar.gz)    tar xvzf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xvf $1     ;;
            *.tbz2)      tar xvjf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Print specific column
function fawk {
    first="awk '{print "
    last="}'"
    cmd="${first}\$${1}${last}"
    eval $cmd
}

# Ghetto Code Review function
function gcr() {
    local context=20
    local opts=""
    if [ "$1" == "-c" ]; then
        opts="--cached"
        shift
    fi
    if [ -n "$1" ]; then
        context=$1
    fi
    git diff $opts -w -U$1 | pygmentize -l diff -O full=true -f html | python2.7 $HOME/bin/pastie/pastie.py
}

# Environment ssh
function sshe() {
    if [ $# -lt 2 ]; then
        echo "Usage: ${FUNCNAME[0]} APP ENV [NUMBER]"
        return 1
    fi
    local num="01"
    local app="$1"
    local env="$2"
    if [[ $env =~ ^[0-9]+$ ]]; then
        env="test$env"
    fi
    if [ -n "$3" ]; then
        num="$3"
    fi

    local app_alias=`cut -f2 -d' ' ~/app_aliases | grep "^$app$"`
    if [ -n "$app_alias" ]; then
        app=`grep " $app_alias$" ~/app_aliases | cut -f1 -d' '`
    fi

    local hostname="$num-$app-$env.envnxs.net"
    local cmd="ssh -q -A -oStrictHostKeyChecking=no $hostname"
    echo $cmd
    eval $cmd
}

fixssh() {
  for key in SSH_AUTH_SOCK SSH_CONNECTION SSH_CLIENT; do
    if (tmux show-environment | grep "^${key}" > /dev/null); then
      value=`tmux show-environment | grep "^${key}" | sed -e "s/^[A-Z_]*=//"`
      export ${key}="${value}"
    fi
  done
}


# Make things lowercase
lowercase(){
    echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
}

# Detect OS
UNAME=$(uname | tr "[:upper:]" "[:lower:]")
if [ "$UNAME" = "darwin" ]; then
    OS="mac"
else
    OS="linux"
fi

#ALIASES
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ll='ls -hal'
alias rm='rm -i'
alias diskspace='du -S | sort -n -r | more'
alias pastie='python $HOME/bin/pastie/pastie.py'
alias ctagit='ctags -R -f ./.git/tags .'
if [ "$OS" = "linux" ]; then
    alias co='sh $HOME/bin/rmate'
    alias gitInfo='ssh git@git.corp.appnexus.com info'
    alias adnxs='cd /usr/local/adnxs'
    alias apps='cd /usr/local/adnxs/apps'
    alias configs='cd /usr/local/adnxs/configs'
    alias maestroui='cd /usr/local/adnxs/maestro3-ui'
    alias maestroapi='cd /usr/local/adnxs/maestro3-api'
    alias tasker='cd /usr/local/adnxs/tasker-api'
    alias eos_rm='eos ps | grep $USER | awk '"'"'{ print $1 }'"'"' | while read inst ;  do eos kill -i $inst && eos rmc -i $inst; done'
    alias refresh='eval `ssh-agent`; ssh-add'
    alias htmldiff='pygmentize -l diff -O full=true -f html'
    alias ssh_refresh='. $HOME/.ssh/latestagent'
    alias frelease='autoenv list -f | grep test | awk '"'"'{ print $1 }'"'"' | xargs -L1 autoenv release'
fi

# Activate z command
. $HOME/bin/z/z.sh

# Exposing editor for things
export EDITOR='vim'
if [ $OS = "linux" ]; then
    alias vim="nvim"
    alias vi="nvim"
    alias oldvim="vim"
fi

# Setting PATH for Python 2.7 AND Ruby
export PATH="$HOME:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/git_alias:$PATH"
if [ "$OS" = "mac" ]; then
    export PATH="$HOME/Python-2.7.3:$PATH"
    export PATH="/usr/local/opt/ruby/bin:$PATH"
    export PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH"
fi

export DATE=$(date +%Y-%m-%dT%H:%M:%S%z)

# Customize history as we know it
# Don't write duplicate lines in the bash_history
export HISTCONTROL=ignoredups

# Append to the history file, don't overwrite it. This will cause some
# duplicates, even with the setting above since t a new history setting is
# saved with each session.
#shopt -s histappend

# Large command history file
HISTFILESIZE=1000000
HISTSIZE=10000

# Setting for the new UTF-8 terminal support in Lion
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
#export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock

# Load bashrc if it exists
if [ -f $HOME/.bashrc ]; then
   source $HOME/.bashrc
fi

# Setting up PROMPT
source $HOME/bin/git-prompt.sh
source $HOME/bin/kube-ps1.sh

# Note these first four lines are optional
export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM="verbose"
export PS1='\[\033[01;32m\][\t]\[\033[00m\] \[\033[01;34m\]\W $(kube_ps1)\[\033[00m\]$(__git_ps1 "\[\033[01;33m\](%s)\[\033[00m\]")$ '

# Startup actions
if [ $OS = "linux" ]; then
    . ~/.ssh/saveagent
    #if tmux has -t "work4life"; then
    #    exec tmux attach -t "work4life"
    #elif [ -n "${LC_tmux_session+1}" ] && tmux has; then
    #    exec tmux attach
    #fi
fi
