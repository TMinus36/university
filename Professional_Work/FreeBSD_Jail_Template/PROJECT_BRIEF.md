# Project Brief: FreeBSD Jail Web Cluster Template

**Client**: Harris Secured Networks  
**Contractor**: Timothy Harris (TMinus36)  
**Duration**: 3 months (2025)

## Objective
To create a reproducible, secure FreeBSD jail template capable of running customer-facing services in isolated containers using ZFS, PF, and Unbound. The template must support reverse proxying, internal DNS resolution, and on-demand jail provisioning.

## Deliverables
- ZFS-based container skeleton for jails
- PF firewall configuration with reload automation
- Unbound DNS for jailed services
- Web stack deployed inside jails (NGINX + TypeScript)
- TLS handling and host/jail isolation

## Impact
- Reduced provisioning time for new services to under 30 seconds
- Hardened DNS and firewall baseline for all production deployments
- Cluster-ready jail template now used across all A-Team infrastructure

