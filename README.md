# Squid Proxy Server Docker Image

This document provides details on how to use the Docker image `siestacat/squid-proxy-server` for setting up a Squid proxy server. The image allows you to quickly deploy a proxy server with basic authentication.

## GitHub Repository

For more information, updates, and the source code, visit the [GitHub repository](https://github.com/siestacat/docker-squid-proxy-server).

## Running the Docker Container

You can start the Squid proxy server using Docker with the following commands:

### For Production Use (Detached Mode)

```bash
docker run -d -p 30128:3128 \
  -e SQUID_USER=user \
  -e SQUID_PASSWORD=password \
  -e NETWORK_INTERFACE=tun0 \ # Optional - tcp_outgoing_address
  siestacat/squid-proxy-server
```

### For Development Use (Interactive Mode)

```bash
docker run --rm -it -p 30128:3128 \
  -e SQUID_USER=user \
  -e SQUID_PASSWORD=password \
  -e NETWORK_INTERFACE=tun0 \ # Optional - tcp_outgoing_address
  siestacat/squid-proxy-server
```

## Building the Docker Image

To build the Docker image locally, use the following command:

```bash
docker build -t siestacat/squid-proxy-server:latest .
```

## Docker Compose Example

Here's an example of how you might configure `docker-compose` to use the Squid proxy server:

```yaml
version: '3.8'

services:
  squid-proxy:
    image: siestacat/squid-proxy-server
    container_name: squid_proxy
    ports:
      - "30128:3128"
    environment:
      - SQUID_USER=user
      - SQUID_PASSWORD=password
      - NETWORK_INTERFACE=tun0 # Optional - tcp_outgoing_address
    restart: unless-stopped
```

## Testing the Proxy

To test if the proxy is working, you can use `curl` to fetch your public IP address through the proxy:

```bash
curl -x http://user:password@localhost:30128 ifconfig.me
```