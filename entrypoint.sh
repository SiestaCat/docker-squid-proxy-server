#!/bin/sh
# Generate password file
htpasswd -bc /etc/squid/passwd $SQUID_USER $SQUID_PASSWORD

# Optionally configure the network interface
if [ -n "$NETWORK_INTERFACE" ]; then
    echo "http_port $NETWORK_INTERFACE:3128" >> /etc/squid/squid.conf
else
    echo "http_port 3128" >> /etc/squid/squid.conf
fi

# Start Squid in the background
squid -N &

# Tail the Squid logs to the console
tail -f /var/log/squid/access.log
