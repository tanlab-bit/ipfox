# 🌏 ipfox ![Python 3.7+](https://img.shields.io/badge/python-3.7+-297ca0?logo=python&logoColor=white) [![License MIT](https://img.shields.io/github/license/daisylab-bit/ipfox)](./LICENSE) [![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)

Automatically send IP address on system reboot for your server. Requires Python 3.7 and above.

## Locations

We follow the Filesystem Hierarchy Standard (FHS) spec:

```
[*] Installation complete -

    installed: /etc/systemd/system/ipfox.service
    installed: /usr/local/lib/ipfox/ipfox.py
    installed: /usr/local/etc/ipfox
    installed: /usr/local/etc/ipfox/ipfox.default.ini
```

## Runtimes

We assume you have system-wide Python 3 installed to `/usr/bin/python3`.

## Usage

Clone the repo locally:

```bash
# via github source
git clone https://github.com/daisylab-bit/ipfox.git

# ... or from gitee mirror
git clone https://gitee.com/daisylab-bit/ipfox.git
```

Install via script:

```bash
# Make file executable if needed
chmod +x install-ipfox.sh

# Run the installer
sudo ./install-ipfox.sh
```

The script basically does the following:

- Copies the Unit file to `/etc/systemd/system/`.
- Copies the Python script to `/usr/local/lib/` under directory `ipfox`.
- Copies the sample configuration file to `/usr/local/etc/ipfox/` as `ipfox.default.ini`.

Configuration should be put under `/usr/local/etc/ipfox/`. So, copy sample configuration file to `ipfox.ini`:

```bash
sudo cp /usr/local/etc/ipfox/ipfox.default.ini /usr/local/etc/ipfox/ipfox.ini
```

And edit the configuration file to your needs.

```bash
sudo vim /usr/local/etc/ipfox/ipfox.ini
```

- Change all capitalized variables. `SERVER_NAME` should be unique for each server.
- `RemoteIP` should preferably be a locally accessible IP address.
- `ReceiverList` should not contain duplicate keys (i.e., unique names for each receiver).

```ini
; ipfox.ini - Default configuration file for ipfox.
; Path: /usr/local/etc/ipfox/ipfox.ini
; You should change all capitalized variables to suit your needs.

[Connection]
; Try performing socket connection to ...
; (We recommend 10.0.0.55 for BIT local servers)
RemoteIP = 10.0.0.55
RemotePort = 80

[Email]
; What's to be sent in the email?
Hostname = SERVER_NAME
Subject = ipfox - %(hostname)s rebooted

; SMTP server host and user, you send email from this address
SenderHost = mail.bit.edu.cn
SenderUser = EMAIL_ADDR_SENDER
SenderAuth = EMAIL_ADDR_PASSWORD

; A list of email addresses to receive the email
[ReceiverList]
Receiver1 = EMAIL_ADDR_1
Receiver2 = EMAIL_ADDR_2
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
