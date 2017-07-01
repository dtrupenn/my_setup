# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/dtrujillo/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bureau"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git pip python redis-cli docker)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

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
alias co='sh $HOME/bin/rmate'
alias gitInfo='ssh git@git.corp.appnexus.com info'
alias adnxs='cd /usr/local/adnxs'
alias adnxs='cd /usr/local/adnxs'
alias apps='cd /usr/local/adnxs/apps'
alias maestroui='cd /usr/local/adnxs/maestro3-ui'
alias maestroapi='cd /usr/local/adnxs/maestro3-api'
alias tasker='cd /usr/local/adnxs/tasker-api'
alias eos_rm='eos ps | grep $USER | awk '"'"'{ print $1 }'"'"' | while read inst ;  do eos kill -i $inst && eos rmc -i $inst; done'
alias refresh='eval `ssh-agent`; ssh-add'
alias htmldiff='pygmentize -l diff -O full=true -f html'
alias ssh_refresh='. $HOME/.ssh/latestagent'
alias frelease='autoenv list -f | grep test | awk '"'"'{ print $1 }'"'"' | xargs -L1 autoenv release'

# Activate z command
. $HOME/bin/z/z.sh

# Exposing editor for things
export EDITOR='nvim'
alias vim="nvim"
alias vi="nvim"
alias oldvim="vim"

export PATH="$HOME:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/git_alias:$PATH"

# Large command history file
HISTFILESIZE=1000000
HISTSIZE=10000

. ~/.ssh/saveagent
