#!/bin/sh
# Ensure log directory exists
mkdir -p /var/log/squid /squid-proxy/cache
chown squid:squid /var/log/squid
chown squid:squid /squid-proxy/cache

# Generate password file
htpasswd -bc /etc/squid/passwd $SQUID_USER $SQUID_PASSWORD

# Configure the network interface
if [ -n "$NETWORK_INTERFACE" ]; then
    echo "http_port $NETWORK_INTERFACE:3128" >> /etc/squid/squid.conf
else
    echo "http_port 3128" >> /etc/squid/squid.conf
fi

# Start Squid in the foreground for better Docker integration
squid -N -d 1

# Follow the access log (in background to allow squid to run in foreground)
tail -f /var/log/squid/access.log &