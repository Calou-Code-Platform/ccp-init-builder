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

    main
}

function main() {
    title

    echo "Calou Code Platform initialization builder v2.3"
    echo "Developed by Caloutw"
    
    echo -e

    echo "Tools : "
    echo "├─ (1) code-server / A online code editor service."
    echo "├─ (2) vscode-tunnel / Run visual studio code on web browser or vsc."
    echo "├─ (3) Zip / zip & unzip package."
    echo "├─ (4) RClone / Cloud drive tools."
    echo -e
    echo "Programming Language: "
    echo "├─ (10) nvm / Node.js version manager."
    echo "├─ (11) pyenv / Python version manager."

    echo -e

    echo "(Ctrl + C) Exit"

    echo -e

    read -p "Choice : " choice

    if [ $choice -eq 1 ]; then
        __INSTALL_CODE_SERVER
    elif [ $choice -eq 3 ]; then
        __INSTALL_VSCODE_TUNNEL
    elif [ $choice -eq 3 ]; then
        __INSTALL_ZIP
    elif [ $choice -eq 4 ]; then
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
    echo "Install Successful."
    sleep 2

    main
}

function __INSTALL_VSCODE_TUNNEL(){
    title
    echo "Installing Visual Studio Code Tunnel..."

    curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz
    tar -xf vscode_cli.tar.gz

    sudo mv code /usr/local/bin/code-tunnel
    rm -rf vscode_cli.tar.gz

    title
    echo "Install Successful."
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

    if ! grep -q 'export NVM_DIR' ~/.bashrc; then
        echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' >> ~/.bashrc
        echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"' >> ~/.bashrc
    fi
    
    if ! grep -q "nvmUpdate()" ~/.bashrc; then
        cat << 'EOF' >> ~/.bashrc
nvmUpdate() {
  \nvm "$@"
  local exit_code=$?
  if [ $exit_code -eq 0 ] && [[ "$1" == "install" || "$1" == "use" || "$1" == "alias" ]]; then
    local current_node_path=$(nvm which current)
    if [[ -x "$current_node_path" ]] && [[ "$current_node_path" != *"system"* ]]; then
      local system_node_path=$(readlink -f /usr/bin/node)
      if [[ "$system_node_path" != "$current_node_path" ]]; then
        sudo ln -sf "$current_node_path" /usr/bin/node
        sudo ln -sf "$(dirname "$current_node_path")/npm" /usr/bin/npm
      fi
    fi
  fi
  return $exit_code
}
alias nvm="nvmUpdate"
EOF
    fi

    title
    echo -e "Please run \"\033[1;33msource ~/.bashrc\033[0m\" after install."
    echo "Install Successful."
    read -p "Press enter to continue..."

    main
}

function __INSTALL_PYTHON() {
    title
    sudo apt install software-properties-common -y
    sudo add-apt-repository ppa:deadsnakes/ppa -y
    sudo apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
    sudo apt update -y
    sudo apt upgrade -y

    title
    echo "Installing PYENV..."

    curl -fsSL https://pyenv.run | bash
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
    echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(pyenv init - bash)"' >> ~/.bashrc

    title
    echo "Please run \" source ~/.bashrc \" after install."
    echo "Install Successful."
    read -p "Press enter to continue..."

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
