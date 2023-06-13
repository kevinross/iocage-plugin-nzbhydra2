#!/bin/sh
set -x
# Fetch latest release
fetch $(curl -s https://api.github.com/repos/theotherp/nzbhydra2/releases/latest | grep browser_download_url | grep 'generic[.]zip' | cut -d '"' -f 4) -o /usr/local/ || true

# Extract
unzip /usr/local/nzbhydra2-*-generic.zip -o -d /usr/local/nzbhydra2 || true

#Remove
rm /usr/local/nzbhydra2-*-generic.zip || true

# Add user
pw user add nzbhydra2 -c nzbhydra2 -u 999 -d /nonexistent -s /usr/bin/nologin || true

# Change ownership
chown -R nzbhydra2:nzbhydra2 /usr/local/nzbhydra2 || true

# Add service
cp /usr/local/nzbhydra2/other/rc.d/nzbhydra2 /etc/rc.d/nzbhydra2 || true
chmod u+x /etc/rc.d/nzbhydra2 || true

# Enable the service
sysrc -f /etc/rc.conf nzbhydra2_enable="YES" || true
sysrc -f /etc/rc.conf nzbhydra2_datafolder="/mnt/nzbhydra2_data" || true

# Start the service
service nzbhydra2 start || true
