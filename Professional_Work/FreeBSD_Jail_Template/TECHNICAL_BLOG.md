# Building a Secure FreeBSD Jail Platform with PF and Unbound

## Introduction
At Harris Secured Networks, security, performance, and reproducibility form the core of our infrastructure strategy. In this project, we built a hardened FreeBSD jail template designed to host customer-facing web services with strict network segmentation, local DNS resolution, and reverse proxy support.

## Architecture
- **Host**: FreeBSD with PF and Unbound configured for DNSSEC and caching
- **Jails**: Lightweight containers built on ZFS clones, each hosting a TypeScript app served via NGINX

## Key Elements

### PF Firewall
```pf
ext_if = "em0"
int_if = "lo1"
set skip on lo
block all
pass in on $ext_if proto tcp to port 443 keep state
anchor "jail_rules/*"
```

### Unbound DNS
Configured to serve `.internal` zones and cache upstream queries for jails, reducing latency and external DNS exposure.

### Jail Lifecycle
```sh
zfs clone zroot/jails/base@template zroot/jails/webapp1
jail -c name=webapp1 path=/jails/webapp1 host.hostname=webapp1.local ip4.addr=10.0.1.10
```

### NGINX Reverse Proxy
```nginx
server {
  listen 443 ssl;
  server_name customer1.example.com;
  location / {
    proxy_pass http://127.0.0.1:3000;
  }
}
```

## Outcome
This secure template is now used as the base image for all HSN jail deployments. It supports rapid scaling, strong isolation, and reliable name resolution—all critical to multi-tenant deployments.

