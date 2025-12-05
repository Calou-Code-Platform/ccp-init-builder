#!/bin/bash

function title() {
    clear

    echo " ██████╗ ██████╗██████╗ ";
    echo "██╔════╝██╔════╝██╔══██╗";
    echo "██║     ██║     ██████╔╝";
    echo "██║     ██║     ██╔═══╝ ";
    echo "╚██████╗╚██████╗██║     ";
    echo " ╚═════╝ ╚═════╝╚═╝     ";    
}

function setup(){
    title

    sudo apt -y update | sudo apt -y upgrade
    sudo apt -y install curl wget git software-properties-common ca-certificates gnupg sudo gcc

    sudo apt -y install tmux

    main
}

function main() {
    title

    echo "Calou Code Platform initialization builder v2.3"
    echo "Developed by Caloutw"
    
    echo -e

    echo "Tools : "
    echo "├─ (1) code-server / run visual studio code on web browser."
    echo "├─ (2) Zip / zip & unzip package."
    echo "├─ (3) RClone / cloud drive tools."
    echo -e
    echo "Programming Language: "
    echo "├─ (10) nvm / Node.js version manager."
    echo "├─ (11) pyenv / Python version manager."

    echo -e

    echo "(Ctrl + C) Exit"

    echo -e

    read -p "Choice : " choice

    elif [ $choice -eq 1 ]; then
        __INSTALL_CODE_SERVER
    elif [ $choice -eq 2 ]; then
        __INSTALL_ZIP
    elif [ $choice -eq 3 ]; then
        __INSTALL_RCLONE
    elif [ $choice -eq 10 ]; then
        __INSTALL_NODE
    elif [ $choice -eq 11 ]; then
        __INSTALL_PYTHON
    else
        title
        echo "Error selection. please try again."
        sleep 2
        main
    fi
}

function __INSTALL_CODE_SERVER(){
    title
    echo "Installing code-server..."

    mkdir -p ~/.config/code-server
    read -s -p "code-server passowrd: " PASSWORD
    echo

    cat > ~/.config/code-server/config.yaml <<EOL
bind-addr: 0.0.0.0:3100
auth: password
password: $PASSWORD
cert: false
EOL

    curl -fsSL https://code-server.dev/install.sh | sh

    title
    echo "安裝成功"
    sleep 2

    main
}


function __INSTALL_NODE() {
    title
    echo "Setup Node.js..."
    sudo apt-get remove -y libnode-dev
    sudo apt update -y
    sudo apt upgrade -y

    title
    echo "Installing NVM..."

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    title
    echo "Install Successful."
    sleep 2

    main
}

function __INSTALL_PYTHON() {
    title
    sudo apt install software-properties-common -y
    sudo add-apt-repository ppa:deadsnakes/ppa -y
    sudo apt update -y
    sudo apt upgrade -y

    title
    echo "Installing NVM..."

    curl -fsSL https://pyenv.run | bash
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init - bash)"

    title
    echo "Install Successful."
    sleep 2

    main
}

function __INSTALL_ZIP() {
    title
    echo "Installing zip..."
    sudo apt install zip -y

    title
    echo "Installing unzip..."
    sudo apt install unzip -y

    title
    echo "Install Successful."
    sleep 2

    main
}

function __INSTALL_RCLONE(){
    title
    echo "Installing RClone..."
    sudo apt install fuse -y
    sudo apt install rclone -y

    title
    echo "Install Successful."
    sleep 2

    main
}

setup
