# 🌏 ipfox

![Python 3.7+](https://img.shields.io/badge/python-3.7+-297ca0?logo=python&logoColor=white) [![License MIT](https://img.shields.io/github/license/daisylab-bit/ipfox)](./LICENSE) [![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)

Automatic IP address detection for your server. Requires Python 3.7 and above.

## Locations

We follow the Filesystem Hierarchy Standard (FHS) spec:

```
installed: /etc/systemd/system/ipfox.service

installed: /usr/local/lib/ipfox/ipfox.py
installed: /usr/local/etc/ipfox/ipfox.ini

installed: /var/log/ipfox.log
```

## Runtimes

We assume you have system-wide Python 3 installed to `/usr/bin/python3`.

## Usage

Install via script:

```bash
sudo ./install.sh
```

The script basically does the following. It first moves the Unit file to `/etc/systemd/system/`.

```bash
# Copy the unit file
sudo cp ipfox.service /etc/systemd/system/

# Set the right permissions
sudo chown root:root /etc/systemd/system/ipfox.service
sudo chmod 644 /etc/systemd/system/ipfox.service
```

It then moves the Python script to `/usr/local/lib/` under a separate directory.

```bash
# Create the directory and copy over the script
sudo mkdir -p /usr/local/lib/ipfox
sudo cp ipfox.py /usr/local/lib/ipfox/

# Set the right permissions
sudo chown root:root /usr/local/lib/ipfox/ipfox.py
sudo chmod 644 /usr/local/lib/ipfox/ipfox.py
```

You will need to enable and start the service:

```bash
# Enable the service
sudo systemctl enable ipfox
```

## License

[MIT](./LICENSE)
