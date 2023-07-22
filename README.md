# Niklas Homelab

This project utilizes Infrastructure as Code and GitOps to automate provisioning, operating, and updating self-hosted services in my homelab.

![img](./.github/images/dashboard.png)

## History

This is a new take on the GitOps Infrastructure for my Homelab. Up until now I used a private self-hosted Gitlab Repository containing all Kubernetes Deployments written in Terraform. I recently start migrating all deployments from Terraform to ArgoCD due to [outstanding design issues in Terraform with Kubernetes CRD and CR](https://github.com/hashicorp/terraform-provider-kubernetes/issues/1367).

## Technology Stack

* [AdGuardHome](https://github.com/AdguardTeam/AdGuardHome): Network-wide ads & trackers blocking DNS server
* [ArchiSteamFarm](https://github.com/JustArchiNET/ArchiSteamFarm)
* [ArgoCD](https://github.com/argoproj/argo-cd): GitOps tool for deploying applications to Kubernetes
* [Bitcoin Node](https://github.com/bitcoin/bitcoin):
* [cert-manager](https://github.com/cert-manager/cert-manager)
* [Debian](https://www.debian.org)
* [ESPHome](https://github.com/esphome/esphome)
* [external-dns](https://github.com/kubernetes-sigs/external-dns)
* [Firefly III](https://github.com/firefly-iii/firefly-iii)
* [FlareSolverr](https://github.com/FlareSolverr/FlareSolverr)
* [Home Assistant](https://github.com/home-assistant/core)
* [Homepage](https://github.com/benphelps/homepage)
* [ingress-nginx](https://github.com/kubernetes/ingress-nginx)
* [JDownloader 2](https://jdownloader.org)
* [k0s](https://github.com/k0sproject/k0s): Zero Friction Kubernetes Distribution
* [k0s: CoreDNS](https://github.com/coredns/coredns):
* [k0s: metrics-server](https://github.com/kubernetes-sigs/metrics-server)
* [Lidarr](https://github.com/Lidarr/Lidarr)
* [MettalLB](https://github.com/metallb/metallb): Load-balancer implementation for bare metal Kubernetes clusters
* [MeTube](https://github.com/alexta69/metube)
* [Minecraft Server](https://github.com/itzg/docker-minecraft-server)
* [Monero Node](https://github.com/monero-project/monero)
* [MQTT Broker](https://github.com/eclipse/mosquitto)
* [paperless-ngx](https://github.com/paperless-ngx/paperless-ngx)
* [Plex](https://www.plex.tv)
* [Prowlarr](https://github.com/Prowlarr/Prowlarr)
* [Rathole](https://github.com/rapiz1/rathole)
* [Restic](https://github.com/restic/restic):
* [Scrutiny](https://github.com/AnalogJ/scrutiny)
* [Sealed Secrets](https://github.com/bitnami-labs/sealed-secrets):
* [Stash](https://github.com/stashapp/stash)
* [Syncthing](https://github.com/syncthing/syncthing)
* [Tautulli](https://github.com/Tautulli/Tautulli)
* [Transmission](https://github.com/transmission/transmission)
* [Trilium Notes](https://github.com/zadam/trilium)
* [UniFi Controller](https://ui.com)
* [Vaultwarden](Vaultwarden)
* [Vikunja](https://vikunja.io/)
* [ZFS](https://github.com/openzfs/zfs)
* [Zigbee2MQTT](https://github.com/Koenkk/zigbee2mqtt)
* [zrepl](https://github.com/zrepl/zrepl)

## External Resources and Services

* [Cloudflare](https://www.cloudflare.com): DNS Server which is nativly supported by cert-manager.io and external-dns
* [Gandi](https://gandi.net): Domain Provider
* [IONOS VPS](https://www.ionos.de/server/vps): Simple 1€/month VPS. Providing stable IPv4 that is bridged with [Rathole](https://github.com/rapiz1/rathole) to my homelab

## Hardware Stack

### Server "Spirit"

* CPU: Ryzen 5800X
* RAM: 64GB
* Mainboard: X470D4U2-2T
* OS: Debian
* OS SSD: SanDisk 128GB
* Storage SATA SSD: ZFS Spanned Pool (RAID 0)
  * Crucial MX500 2TB
  * Samsung 850 EVO 2TB
* Storage NVMe SSD: ZFS Mirrored Pool (RAID 1)
  * 2x WD Black SN850X 2TB
* Storage HDD: 2x ZRAID2 (RAID 6)
  * 12x WD White Label 18TB

### Server "Dawn"

* Raspberry Pi 4
* RAM: 8GB
* OS: Raspberry Pi OS
* OS SSD: Crucial MX500 512GB

### Network Equipment

* FRITZ!Box 7590 AX
* 3x UniFi Switch Flex XG (4x 10 Gbit/&s / 1 Gbit/&s)
* 2x UniFi Switch Flex Mini (5x 1 Gbit/&s)
