#!/bin/sh

CUREENT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

COMMANDS_DIR=$CUREENT_DIR/commands

dockerBinExport="export PATH=$COMMANDS_DIR:\$PATH"

# export environment variables inside the $HOME/.bashrc file
if ! grep -q "$dockerBinExport" "$HOME/.bashrc"; then
	echo " " >> $HOME/.bashrc
	echo "# following line is added for home setup using docker">> $HOME/.bashrc
	echo $dockerBinExport >> ~/.bashrc
fi

#5 export environment variables inside the $HOME/.profile file
if ! grep -q "$dockerBinExport" "$HOME/.profile"; then
	echo " " >> $HOME/.profile
	echo "# following line is added for home setup using docker">> $HOME/.profile
	echo $dockerBinExport >> ~/.profile
fi