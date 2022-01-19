#!/bin/bash
# A script to automate initial configuration of the Dasharo testing environment

OS=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)
source os/$OS/commands
echo "------> Operating system detected: $OS"

# Prepare OS before installing packages
prepare() {
	echo "------> Preparing for installation"
	$SYNC
	$UPGRADE
}

# Install packages from repositories
install_packages() {
	echo "------> Installing packages"
	$INSTALL $(cat os/$OS/packages.list)
}

# Configure operating system
configure() {
	echo "------> Configuring system"
	# TODO: Place configs in filesystem
}

# Ask the user to reboot the system
reboot_prompt() {
	echo -n "Reboot? [y]/n > "
	read response
	if [[ "$response" == "y" || "$response" == "" ]]; then
		echo /sbin/reboot
	else
		echo "Please reboot manually to finalize setup"
	fi
}

prepare
#install_packages
configure
reboot_prompt
