#!/bin/sh
# Ensure log directory exists
mkdir -p /var/log/squid /squid-proxy/cache
chown squid:squid /var/log/squid
chown squid:squid /squid-proxy/cache

# Generate password file
htpasswd -bc /etc/squid/passwd $SQUID_USER $SQUID_PASSWORD

# Remove existing 'tcp_outgoing_address' lines to avoid duplicates
sed -i '/^tcp_outgoing_address /d' /etc/squid/squid.conf

# If NETWORK_INTERFACE is set, use it for outgoing connections
if [ -n "$NETWORK_INTERFACE" ]; then
    echo "tcp_outgoing_address $NETWORK_INTERFACE" >> /etc/squid/squid.conf
fi

# Start Squid in the foreground for better Docker integration
squid -N -d 1

# Follow the access log (in background to allow squid to run in foreground)
tail -f /var/log/squid/access.log &
