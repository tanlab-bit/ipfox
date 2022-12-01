# 🌏 ipfox

![Python 3.7+](https://img.shields.io/badge/python-3.7+-297ca0?logo=python&logoColor=white) [![License MIT](https://img.shields.io/github/license/daisylab-bit/ipfox)](./LICENSE) [![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)

Automatic IP address detection for your server. Requires Python 3.7 and above.

## Locations

We follow the Filesystem Hierarchy Standard (FHS) spec:

```
[*] Installation complete -
installed: ipfox service unit file: /etc/systemd/system/ipfox.service
installed: ipfox Python script: /usr/local/lib/ipfox/ipfox.py
installed: ipfox configuration directory: /usr/local/etc/ipfox
installed: ipfox sample configuration file: /usr/local/etc/ipfox/ipfox.ini.default
```

## Runtimes

We assume you have system-wide Python 3 installed to `/usr/bin/python3`.

## Usage

Install via script:

```bash
sudo ./install-ipfox.sh
```

The script basically does the following:

- Copies the Unit file to `/etc/systemd/system/`.
- Copies the Python script to `/usr/local/lib/` under directory `ipfox`.
- Copies the sample configuration file to `/usr/local/etc/ipfox/` as `ipfox.ini.default`.

Configuration should be put under `/usr/local/etc/ipfox/`. So, copy sample configuration file to `ipfox.ini`:

```bash
sudo cp /usr/local/etc/ipfox/ipfox.ini.default /usr/local/etc/ipfox/ipfox.ini
```

And edit the configuration file to your needs.

```bash
sudo vim /usr/local/etc/ipfox/ipfox.ini
```

To enable and start the service:

```bash
sudo systemctl enable ipfox
sudo systemctl start ipfox
```

Uninstall and revert changes via:

```bash
sudo ./install-ipfox.sh --uninstall
```

## License

[MIT](./LICENSE)
