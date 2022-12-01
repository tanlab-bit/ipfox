# ipfox

Automatic IP address detection for your server. Requires Python 3.7 and above.

## Locations

We follow the Filesystem Hierarchy Standard (FHS) spec:

```
installed: /etc/systemd/system/ipfox.service

installed: /usr/local/lib/ipfox/ipfox.py
installed: /usr/local/etc/ipfox/*.json

installed: /var/log/ipfox.log
```

## Usage

Move the Unit file to `/etc/systemd/system/` and enable it.

```bash
# Copy the unit file
sudo cp ipfox.service /etc/systemd/system/

# Set the right permissions
sudo chown root:root /etc/systemd/system/ipfox.service
sudo chmod 644 /etc/systemd/system/ipfox.service

# Enable the service
sudo systemctl enable ipfox
```

Move the Python script to `/usr/local/lib/` under a separate directory.

```bash
# Create the directory and copy over the script
sudo mkdir -p /usr/local/lib/ipfox
sudo cp ipfox.py /usr/local/lib/ipfox/

# Set the right permissions
sudo chown root:root /usr/local/lib/ipfox/ipfox.py
sudo chmod 644 /usr/local/lib/ipfox/ipfox.py
```
