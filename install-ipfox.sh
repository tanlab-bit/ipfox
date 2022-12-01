#!/usr/bin/env bash

# Script to install ipfox as a systemd service. Need to be run as root.
# To uninstall and revert all changes, run with argument "--uninstall"

# The files installed by the script conform to the Filesystem Hierarchy Standard:
# https://wiki.linuxfoundation.org/lsb/fhs

# Check if the user is root
if [ "$(id -u)" != "0" ]; then
    echo "[x] This script must be run as root!" 1>&2
    exit 1
fi

# Uninstall mode if command line argument "--uninstall" is given
if [ "$1" = "--uninstall" ]; then
    echo "[-] Disabling and removing ipfox service..."
    systemctl stop ipfox.service
    systemctl disable ipfox.service
    rm /etc/systemd/system/ipfox.service

    echo "[-] Uninstalling ipfox..."
    rm -r /usr/local/lib/ipfox
    rm -r /usr/local/etc/ipfox

    echo "[*] ipfox has been uninstalled."
    exit 0
fi

# Check if Python runtime is present at default system location
# This should be /usr/bin/python3 for Python 3 by default
if [ ! -f /usr/bin/python3 ]; then
    echo "[x] Python 3 runtime not found at /usr/bin/python3!" 1>&2
    exit 1
fi

# Setting up unit files to systemd
echo "[-] Copying unit files to /etc/systemd/system"
cp ipfox.service /etc/systemd/system/ipfox.service
echo "[-] Setting permissions on unit files"
chown root:root /etc/systemd/system/ipfox.service
chmod 644 /etc/systemd/system/ipfox.service

# Setting up Python script and friends
echo "[-] Copying ipfox.py to /usr/local/lib"
mkdir -p /usr/local/lib/ipfox
cp ipfox.py /usr/local/lib/ipfox
echo "[-] Setting permissions on ipfox.py"
chown root:root /usr/local/lib/ipfox/ipfox.py
chmod 644 /usr/local/lib/ipfox/ipfox.py

# Create configuration directory and sample configuration file
echo "[-] Creating configuration directory at /usr/local/etc/ipfox"
mkdir -p /usr/local/etc/ipfox
echo "[-] Copying sample configuration file to /usr/local/etc/ipfox/ipfox.ini.default"
cp ipfox.ini.default /usr/local/etc/ipfox

# Summary
echo "[*] Installation complete -"
echo "installed: ipfox service unit file: /etc/systemd/system/ipfox.service"
echo "installed: ipfox Python script: /usr/local/lib/ipfox/ipfox.py"
echo "installed: ipfox configuration directory: /usr/local/etc/ipfox"
echo "installed: ipfox sample configuration file: /usr/local/etc/ipfox/ipfox.ini.default"
# echo "installed: ipfox log file: /var/log/ipfox.log"
echo "[*] Edit /usr/local/etc/ipfox/ipfox.ini.default and save as ipfox.ini"
echo "[*] Enable and start service with -"
echo "$ sudo systemctl enable ipfox.service"
echo "$ sudo systemctl start ipfox.service"
