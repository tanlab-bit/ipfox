#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# Check if the user is root
if [ "$(id -u)" != "0" ]; then
    echo "[x] This script must be run as root" 1>&2
    exit 1
fi

# Check if Python runtime is present at default system location
# This should be /usr/bin/python3 for Python 3 by default
if [ ! -f /usr/bin/python3 ]; then
    echo "[x] Python 3 runtime not found at /usr/bin/python3" 1>&2
    exit 1
fi

# Setting up unit files to systemd
echo "[*] Copying unit files to /etc/systemd/system"
cp ipfox.service /etc/systemd/system
echo "[*] Setting permissions on unit files"
chown root:root /etc/systemd/system/ipfox.service
chmod 644 /etc/systemd/system/ipfox.service

# Setting up Python script and friends
echo "[*] Copying ipfox.py to /usr/local/lib"
mkdir -p /usr/local/lib/ipfox
cp ipfox.py /usr/local/lib/ipfox
echo "[*] Setting permissions on ipfox.py"
chown root:root /usr/local/lib/ipfox/ipfox.py
chmod 644 /usr/local/lib/ipfox/ipfox.py

# Create configuration directory and sample configuration file
echo "[*] Creating configuration directory"
mkdir -p /usr/local/etc/ipfox
echo "[*] Copying sample configuration file"
cp ipfox.conf /usr/local/etc/ipfox
