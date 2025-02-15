# GitOps Driven Homelab

This project utilizes Infrastructure as Code and GitOps to automate the provisioning, operation, and updating of self-hosted services in my homelab.

![img](./.github/images/dashboard.png)

## Features

- [x] Automated deployment of all services using [ArgoCD](https://argo-cd.readthedocs.io/en/stable/)
- [x] Automated updates of all services using [Renovate](https://github.com/renovatebot/renovate)
- [x] Automated DNS updates of local DNS (AdGuard Home) using [external-dns](https://github.com/kubernetes-sigs/external-dns)
- [x] Automated DNS updates of global DNS (Cloudflare) using [cert-manager.io](https://cert-manager.io/)
- [x] Automated certificate creation and renewal using [cert-manager.io](https://cert-manager.io/)
- [x] Media Server setup using [Plex](https://www.plex.tv/)
- [x] Media Automation using Radarr, Sonarr, Lidarr
- [x] Password Management with Vaultwarden
- [x] Kubernetes Native Storage using [csi-driver-nfs](https://github.com/kubernetes-csi/csi-driver-nfs)
- [ ] Automated Kubernetes backups using [velero](https://velero.io/)
- [ ] Automated Database Setup and Backups using [CloudNativePG](https://cloudnative-pg.io/)
- [ ] Monitoing setup using [Grafana](https://github.com/grafana/grafana), [Grafana Loki](https://github.com/grafana/loki), [Grafana Mimir](https://github.com/grafana/mimir) and [Grafana Alloy](https://github.com/grafana/alloy)

## Hardware Stack

After nearly a decade with Debian and ZFS, I’ve switched to Unraid for a more power-efficient storage solution.
Unlike ZFS, Unraid allows idle disks to spin down, significantly reducing energy consumption while still providing over 100 TB of RAID storage.

My setup consists of a single Unraid server that runs Kubernetes in Talos VMs.

```mermaid
flowchart TD
 subgraph s1["Unraid Server"]
        nfs["Unraid NFS"]
        subgraph vm["Unraid VM"]
            cp1["Talos Kubernetes Control Plane 1"]
            w1["Talos Kubernetes Worker 1"]
        end
        nfs <--> cp1 & w1
  end
```
