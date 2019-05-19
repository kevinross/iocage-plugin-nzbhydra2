#!/bin/sh

# Fetch latest release
fetch $(curl -s https://api.github.com/repos/theotherp/nzbhydra2/releases/latest | grep browser_download_url | grep 'linux[.]zip' | cut -d '"' -f 4) -o /usr/local/share

# Extract
unzip /usr/local/share/nzbhydra2-*-linux.zip -o -d /usr/local/share/nzbhydra2

# Add user
pw user add nzbhydra2 -c nzbhydra2 -u 999 -d /nonexistent -s /usr/bin/nologin

# Add service
cp /usr/local/share/nzbhydra2/rc.d/nzbhydra2 /usr/local/etc/rc.d/nzbhydra2
chmod u+x /usr/local/etc/rc.d/nzbhydra2

# Enable the service
sysrc -f /etc/rc.conf nzbhydra2_enable="YES"

# Start the service
service nzbhydra2_plexpass start 2>/dev/null
