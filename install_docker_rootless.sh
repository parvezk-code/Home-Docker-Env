#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

rootlessScriptName="rootless-install.sh"
rootlessScriptURl="https://get.docker.com/rootless"
dockerBinExport="export PATH=\$HOME/bin:\$PATH"
dockerHostExport="export DOCKER_HOST=unix://\$XDG_RUNTIME_DIR/docker.sock"

#if sudo apt-get -qq install uidmap; then 
if dpkg -s  uidmap > /dev/null 2>&1; then
    echo " "
else
	echo "Package uidmap not found : apt-get install -y uidmap"
    exit 1
fi

if dpkg -s  curl > /dev/null 2>&1; then
    echo " "
else
	echo "Package curl not found : apt-get install -y curl"
    exit 1
fi

which docker > /dev/null 2>&1
cmd1=$?
systemctl --user status docker --no-pager | grep rootless > /dev/null 2>&1
cmd2=$?
docker -v > /dev/null 2>&1
cmd3=$?

if [ $cmd2 -eq 0 ] || [ $cmd3 -eq 0 ]; then
    echo "Docker already installed"
else
    echo "----------------installing rootless docker-------------------"
    curl -o $rootlessScriptName -fsSL $rootlessScriptURl
    #wget -O $rootlessScriptName  $rootlessScriptURl
    sh $rootlessScriptName

    echo " " >> $HOME/.bashrc
	echo "# following line is added for rootless docker setup">> $HOME/.bashrc
    echo $dockerBinExport >> ~/.bashrc
	echo $dockerHostExport >> ~/.bashrc

    echo " " >> $HOME/.profile
	echo "# following line is added for rootless docker setup">> $HOME/.profile
    echo $dockerBinExport >> ~/.profile
    echo $dockerHostExport >> ~/.profile

    echo "----------------installing docker-compose -------------------"
    COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
    curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o $HOME/bin/docker-compose
    chmod a+x $HOME/bin/docker-compose
    docker-compose -v

fi

