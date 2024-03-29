#!/bin/bash

install() {
	package_name=$1
	install_name=$2
	if ! { echo "$(pip3 list)" | grep -q "^${package_name}"; }; then
		echo "Installing ${package_name}"
		pip3 install ${install_name}
	else
		echo "Package ${package_name} already installed"
	fi
}

install "python-wireguard" "python_wireguard"

# Adding environment variable
dir=$(dirname $0)
home=$(realpath ${dir})
if [ ! -f ~/.bash_profile ] || ! grep -q HONEYWALT_VM_HOME <~/.bash_profile; then
	echo "export HONEYWALT_VM_HOME=${home}/" >> ~/.bash_profile
fi

# Include ~/.bash_profile if ~/.bashrc does not exist or if it does not include it already
if [ ! -f ~/.bashrc ] || ! grep -q \.bash_profile <~/.bashrc; then
cat <<EOT >> ~/.bashrc
if [ -f ~/.bash_profile ]; then
    . ~/.bash_profile
fi
EOT
fi