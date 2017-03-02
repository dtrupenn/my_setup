#!/usr/bin/env bash

# Updating/Initializing all submodules
git submodule update --init --recursive

# Move all files into home directory and load new bash profile
cp .ssh_saveagent $HOME/.ssh/saveagent
cp .ssh_config $HOME/.ssh/config
cp .bash_profile $HOME/
cp .zshrc $HOME/
cp .gitmodules $HOME/
cp .gitconfig $HOME/
cp -r bin $HOME/bin

mkdir -p $HOME/.config/nvim
cp flake8 $HOME/.config/flake8
cp init.vim $HOME/.config/nvim/init.vim

# Re-evaluating
#cp .tmux.conf $HOME/
#cp -r .vim $HOME/


# Setting up bash profile
sudo cp $HOME/bin/git-prompt.sh /etc/bash_completion.d/git
source $HOME/.bash_profile

# Determine OS platform
UNAME=$(uname | tr "[:upper:]" "[:lower:]")
CENTOS_FILE="/etc/redhat-release"
UBUNTU_FILE="/etc/os-release"

# Packages
# Mac
if [ "$UNAME" == "darwin" ]; then
    # Install Homebrew
    # http://brew.sh/
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    # Install Command Line Tools
    # NOTE: Assume alreaady installed
    #xcode-select --install

    # Install pkgs
    brew install neovim tmux

    # Install node and other modules
    brew install node
    npm install forever express -g
# Centos Linux
elif [ -f $CENTOS_FILE ]; then
    sudo yum install cmake make gcc gcc-c++ nodejs redis
# Ubuntu Linux
elif [ -f $UBUNTU_FILE ]; then
    sudo apt-get update; sudo apt-get -y install cmake make gcc python-setuptools python-dev build-essentials tig flake8 appnexus-maestro-tools python3-pip python-yaml npm nodejs redis-server schema-tool python-psycopg2 apache2 php5 python-nose python-nose-timer
    sudo easy_install pip; sudo pip install --upgrade virtualenv; sudo pip install neovim; sudo pip3 install neovim
fi

# NPM Installation
sudo npm install forever express -g

# Install oh-my-zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Build neovim from source
git clone https://github.com/neovim/neovim.git
cd neovim
rm -r build
make clean
make CMAKE_BUILD_TYPE=Release
sudo make install
cd ..

# Build tmux from source

echo "Building libevent stable..."
wget https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz
tar -xzf libevent-2.1.8-stable.tar.gz
cd libevent-2.1.8-stable
./configure && make
sudo make install
cd ..

echo "Building ncurses stable..."
wget https://ftp.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz
tar -xzf ncurses-6.0.tar.gz
cd ncurses-6.0
./configure && make
sudo make install
cd ..

echo "Building tmux stable..."
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure && make
sudo make install
cd ..

# Installing tmux mem cpu plugin
if [ "$UNAME" == "darwin" ]; then
    cd $HOME/bin/tmux-mem-cpu-load
    cmake .
    make
    sudo make install
fi
echo "Run :PluginInstall in vim to complete Vundle Installation"
