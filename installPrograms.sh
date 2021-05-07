#!/bin/bash

installDependency () {
        if ! command -v $1 &> /dev/null;
        then
                $2
        else
                echo "$1 already installed"
        fi
}

# Insatll Brew
installDependency "brew" "/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
echo "Update Brew"
brew update

installDependency "dialog" "brew install dialog"
name=$(dialog --inputbox "First, please enter a name for the user account." 10 60 3>&1 1>&2 2>&3 3>&1) || exit 1

# Install Python3
installDependency "python3" "brew install python3"
installDependency "pip3" "curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py"

installDependency "node" "brew install node"

# Setup go
installDependency "go" "brew install golang; mkdir -p $HOME/go/{bin,src,pkg}; export GOPATH=$HOME/go; export GOROOT=\"$(brew --prefix golang)/libexec\"; export PATH=\"$PATH:${GOPATH}/bin:${GOROOT}/bin\""

# ZSH Section
installDependency "zsh" "brew insatll zsh"
chsh -s /bin/zsh "$name" >/dev/null 2>&1
sudo -u "$name" mkdir -p "/home/$name/.cache/zsh/"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
