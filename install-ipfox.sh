#!/usr/bin/env bash

# Script to install ipfox as a systemd service. Need to be run as root.
# To uninstall and revert all changes, run with argument "--uninstall"

# The files installed by the script conform to the Filesystem Hierarchy Standard:
# https://wiki.linuxfoundation.org/lsb/fhs

# Check if the user is root
if [ "$(id -u)" != "0" ]; then
    echo -e "[x] This script must be run as root!" 1>&2
    exit 1
fi

# Uninstall mode if command line argument "--uninstall" is given
if [ "$1" = "--uninstall" ]; then
    echo -e "[-] Disabling and removing ipfox service..."
    systemctl stop ipfox.service
    systemctl disable ipfox.service
    rm /etc/systemd/system/ipfox.service

    echo -e "[-] Uninstalling ipfox..."
    rm -r /usr/local/lib/ipfox
    rm -r /usr/local/etc/ipfox

    echo -e "[*] ipfox has been uninstalled."
    exit 0
fi

# Check if Python runtime is present at default system location
# This should be /usr/bin/python3 for Python 3 by default
if [ ! -f /usr/bin/python3 ]; then
    echo -e "[x] Python 3 runtime not found at /usr/bin/python3!" 1>&2
    exit 1
fi

echo -e "\e[32m[*] Installing ipfox...\e[0m"

# Setting up unit files to systemd
echo -e "\e[34m[-] Copying unit files to /etc/systemd/system\e[0m"
cp ipfox.service /etc/systemd/system/ipfox.service
chown root:root /etc/systemd/system/ipfox.service
chmod 644 /etc/systemd/system/ipfox.service

# Setting up Python script and friends
echo -e "\e[34m[-] Copying ipfox.py to /usr/local/lib/ipfox\e[0m"
mkdir -p /usr/local/lib/ipfox
cp ipfox.py /usr/local/lib/ipfox
chown root:root /usr/local/lib/ipfox/ipfox.py
chmod 644 /usr/local/lib/ipfox/ipfox.py

# Create configuration directory and sample configuration file
echo -e "\e[34m[-] Creating configuration directory at /usr/local/etc/ipfox\e[0m"
mkdir -p /usr/local/etc/ipfox
cp ipfox.default.ini /usr/local/etc/ipfox

# Summary
echo -e "\e[32m[*] Installation complete -\e[0m"
echo -e
echo -e "    installed: /etc/systemd/system/ipfox.service"
echo -e "    installed: /usr/local/lib/ipfox/ipfox.py"
echo -e "    installed: /usr/local/etc/ipfox"
echo -e "    installed: /usr/local/etc/ipfox/ipfox.default.ini"
# echo -e "installed: ipfox log file: /var/log/ipfox.log"
echo -e

echo -e "\e[1;31m[!] Copy /usr/local/etc/ipfox/ipfox.default.ini to ipfox.ini, then edit\e[0m"
echo -e "\e[32m[*] Enable and start service with -\e[0m"
echo -e
echo -e "    sudo systemctl enable ipfox"
echo -e "    sudo systemctl start ipfox"
echo -e

echo -e "\e[31m[!] To uninstall, run this script with argument --uninstall\e[0m"
