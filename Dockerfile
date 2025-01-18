FROM alpine:latest

# Install Squid and Apache2-utils for htpasswd
RUN apk add --no-cache squid apache2-utils

# Copy custom Squid configuration files into the container
COPY squid.conf /etc/squid/squid.conf
COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Expose the port Squid listens on
EXPOSE 3128

# Run the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]