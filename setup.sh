#!/usr/bin/env bash

# Updating/Initializing all submodules
#git submodule update --init --recursive

# Move all files into home directory and load new bash profile
cp -r dotfiles/. $HOME
cp -r bin $HOME/bin
cp -r git_alias $HOME/bin

mkdir -p $HOME/.config/nvim
cp flake8 $HOME/.config/flake8
cp init.vim $HOME/.config/nvim/init.vim

# Setting up bash profile
sudo cp $HOME/bin/git-prompt.sh /etc/bash_completion.d/git
# source $HOME/.bash_profile

# Determine OS platform
UNAME=$(uname | tr "[:upper:]" "[:lower:]")
UBUNTU_FILE="/etc/os-release"

# Packages
# Mac
if [ "$UNAME" == "darwin" ]; then
    ANKH_ARTIFACT='ankh-darwin-amd64.tar.gz'

    # Install Command Line Tools
    # NOTE: Assume already installed
    # xcode-select --install

    # Install Homebrew
    # http://brew.sh/
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    # Install node and other modules
    brew install node
    npm install forever express -g

    # Install docker things
    brew cask install docker
    brew cask install virtualbox
    brew cask install minikube

    # Install tools
    brew install neovim tmux tig tree wget fzf

    # Install python things
    brew install python
    pip3 install neovim

# Ubuntu Linux
elif [ -f $UBUNTU_FILE ]; then
    ANKH_ARTIFACT='ankh-linux-amd64.tar.gz'
    sudo apt-get update; sudo apt-get -y install curl openssh-server cmake make gcc python-setuptools python-dev python-pip build-essential tig python3-pip python-yaml npm nodejs redis-server python-psycopg2 apache2 pkg-config wget git automake libtool tig

    # AppNexus specific
    # sudo apt-get install appnexus-maestro-tools schema-tool

    sudo pip install --upgrade pip; sudo pip install --upgrade virtualenv; sudo pip install flake8; sudo pip install neovim; sudo pip3 install neovim

    curl -L 'https://github.com/appnexus/ankh/releases/download/v1.0.0/ankh-linux-amd64.tar.gz' | sudo tar -C /usr/local/bin -xzf -

    # NPM Installation
    sudo npm install forever express -g

fi

# Install Helm
# More info: https://github.com/kubernetes/helm/blob/master/docs/install.md
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get-helm-3 | bash -e
helm init --client-only

# Install Ankh
curl -L "https://github.com/appnexus/ankh/releases/download/v2.1.0/$ANKH_ARTIFACT" | sudo tar -C /usr/local/bin -xzf -

# Install oh-my-zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Install powerlevel10k
brew install romkatv/powerlevel10k/powerlevel10k

# Installing tmux mem cpu plugin
if [ "$UNAME" == "darwin" ]; then
    cd $HOME/bin/tmux-mem-cpu-load
    cmake .
    make
    sudo make install
fi

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Run :PluginInstall in neovim to complete Vundle Installation"
echo "Check https://github.com/mbadolato/iTerm2-Color-Schemes for iTerm2 color schemes"
