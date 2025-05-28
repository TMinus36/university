# Terminal Demo Script: FreeBSD Secure Jail Template Deployment

## 🎯 Objective
Demonstrate setting up:
1. PF firewall
2. Unbound DNS
3. ZFS jail template clone
4. Jail deployment with NGINX + TypeScript
5. Reverse proxy test

---

## 1. PF Firewall Setup
```sh
vi /etc/pf.conf
```
Paste:
```
ext_if = "em0"
set skip on lo
block all
pass in on $ext_if proto tcp to port 443 keep state
anchor "jail_rules/*"
```

```sh
service pf enable
service pf restart
```

---

## 2. Unbound DNS Setup
```sh
pkg install unbound
vi /usr/local/etc/unbound/unbound.conf
```
Insert:
```
server:
    interface: 127.0.0.1
    access-control: 10.0.0.0/8 allow
    cache-max-ttl: 86400
    hide-identity: yes
    hide-version: yes
```

```sh
service unbound enable
service unbound start
```

---

## 3. ZFS Jail Template & Clone
```sh
zfs snapshot zroot/jails/base@template
zfs clone zroot/jails/base@template zroot/jails/webapp1
```

---

## 4. Jail Creation
```sh
jail -c name=webapp1 path=/jails/webapp1 host.hostname=webapp1.local ip4.addr=10.0.1.10 command=/bin/sh
pkg install nginx node npm
```

Place TypeScript app in `/usr/local/www/app`

---

## 5. NGINX Reverse Proxy
Edit `/usr/local/etc/nginx/nginx.conf` inside jail:
```
server {
    listen 443 ssl;
    server_name customer1.example.com;

    location / {
        proxy_pass http://127.0.0.1:3000;
    }
}
```

```sh
nginx -t
service nginx restart
```

Test with:
```sh
curl -k https://customer1.example.com
```

---

## 🎬 End of Demo
Narrate what each step achieves: isolation, DNS resolution, service exposure.
