# Niklas Homelab

This project utilizes Infrastructure as Code and GitOps to automate the provisioning, operation, and updating of self-hosted services in my homelab.

![img](./.github/images/dashboard.png)

## Features

- [x] Automated deployment of all services using [ArgoCD](https://argo-cd.readthedocs.io/en/stable/)
- [x] Automated updates of all services using Renovate
- [x] Automated DNS updates for local DNS using AdGuard Home
- [x] Automated DNS updates for global DNS using Cloudflare
- [x] Automated certificate creation and renewal using [cert-manager.io](https://cert-manager.io/)
- [x] Automated backups using [restic](https://restic.net/)
- [ ] Kubernetes Native Storage using [Rook.io](https://rook.io/)
- [ ] Automated Kubernetes backups using [velero](https://velero.io/)
- [ ] Automated Database Setup and Backups using [CloudNativePG](https://cloudnative-pg.io/)
- [ ] Monitoing setup using Grafana, Grafana Loki and Grafana Mimir

## Hardware Stack

The cluster consists of three nodes. Node 1 is the primary storage server that contains all spinning rust disks. Node 2 and 3 contain fast NVMe storage and fast networking for Rook.io/CephFS Storage.

The hardware was specifically selected to achieve a low-power C10 CPU state, resulting in a power draw of around **14 watts** for Node 2 and 3. Node 1, however, draws more power due to the HDDs.

```mermaid
flowchart TD
    1[Node 1]
    2[Node 2]
    3[Node 3]

    sw[10 Gbit/s Switch]

    sw <--> 1 & 2 & 3

    1 --> p1[Proxmox]
    2 --> p2[Proxmox]
    3 --> p3[Proxmox]

    p1 --> nfs[NFS Server] 

    p1 ---> cp1[Talos\nControl-Plane]
    p2 ---> cp2[Talos\nControl-Plane]
    p3 ---> cp3[Talos\nControl-Plane]

    p1 ---> w1[Talos\nWorker]
    p2 ---> w2[Talos\nWorker]
    p3 ---> w3[Talos\nWorker]
```
