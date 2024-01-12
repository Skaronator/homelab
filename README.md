# Niklas Homelab

This project utilizes Infrastructure as Code and GitOps to automate provisioning, operating, and updating self-hosted services in my homelab.

![img](./.github/images/dashboard.png)

## History

This is a new take on the GitOps Infrastructure for my Homelab. Up until now I used a private self-hosted Gitlab Repository containing all Kubernetes Deployments written in Terraform. I recently start migrating all deployments from Terraform to ArgoCD due to [outstanding design issues in Terraform with Kubernetes CRD and CR](https://github.com/hashicorp/terraform-provider-kubernetes/issues/1367).

## Technology Stack

Name | Description
---- | -----------
[AdGuardHome](https://github.com/AdguardTeam/AdGuardHome) | Network-wide ads & trackers blocking DNS server
[ArchiSteamFarm](https://github.com/JustArchiNET/ArchiSteamFarm) | Tool for managing Steam accounts and idling games
[ArgoCD](https://github.com/argoproj/argo-cd) | GitOps tool for deploying applications to Kubernetes
[cert-manager](https://github.com/cert-manager/cert-manager) | Kubernetes add-on for managing SSL/TLS certificates
[Debian](https://www.debian.org) | Stable Linux distribution
[ESPHome](https://github.com/esphome/esphome) | Framework for creating custom firmware for ESP8266/ESP32 devices
[external-dns](https://github.com/kubernetes-sigs/external-dns) | Kubernetes add-on for managing DNS records
[Firefly III](https://github.com/firefly-iii/firefly-iii) | Personal finance manager for tracking expenses and income
[FlareSolverr](https://github.com/FlareSolverr/FlareSolverr) | Service for bypassing Cloudflare's anti-bot protection
[Home Assistant](https://github.com/home-assistant/core) | Open-source home automation platform
[Homepage](https://github.com/benphelps/homepage) | Personal start page or dashboard
[ingress-nginx](https://github.com/kubernetes/ingress-nginx) | Kubernetes Ingress controller for external access to services
[JDownloader 2](https://jdownloader.org) | Download manager for various online hosting services
[k0s](https://github.com/k0sproject/k0s) | Lightweight Kubernetes distribution
[k0s: CoreDNS](https://github.com/coredns/coredns) | Flexible and extensible DNS server
[k0s: metrics-server](https://github.com/kubernetes-sigs/metrics-server) | Collects resource utilization data for Kubernetes nodes and pods
[Lidarr](https://github.com/Lidarr/Lidarr) | Automation tool for managing music collections
[MetalLB](https://github.com/metallb/metallb) | Load-balancer implementation for bare metal Kubernetes clusters
[MeTube](https://github.com/alexta69/metube) | Self-hosted web application for managing YouTube video playlists
[Minecraft Server](https://github.com/itzg/docker-minecraft-server) | Hosting Modded Minecraft Server
[Monero Node](https://github.com/monero-project/monero) | Software implementation for running a Monero cryptocurrency node
[MQTT Broker](https://github.com/eclipse/mosquitto) | MQTT broker for the Internet of Things (IoT) communication protocol
[paperless-ngx](https://github.com/paperless-ngx/paperless-ngx) | Document management system for organizing and archiving files
[Plex](https://www.plex.tv) | Media server for organizing and streaming media content
[Prowlarr](https://github.com/Prowlarr/Prowlarr) | API integration tool for managing and monitoring media libraries
[Rathole](https://github.com/rapiz1/rathole) | Service for storing and organizing media files
[Restic](https://github.com/restic/restic) | Backup and restore software for files and directories
[Scrutiny](https://github.com/AnalogJ/scrutiny) | Disk health monitoring and analysis tool
[Sealed Secrets](https://github.com/bitnami-labs/sealed-secrets) | Kubernetes controller for managing encrypted secrets
[Stash](https://github.com/stashapp/stash) | Media server for everything that is not in Plex
[Syncthing](https://github.com/syncthing/syncthing) | Decentralized file synchronization tool
[Tautulli](https://github.com/Tautulli/Tautulli) | Monitoring and tracking tool for Plex Media Server
[Transmission](https://github.com/transmission/transmission) | BitTorrent client for downloading and sharing files
[UniFi Controller](https://ui.com) | Software controller for managing UniFi network devices and services
[Vaultwarden](Vaultwarden) | Self-hosted password manager
[ZFS](https://github.com/openzfs/zfs) | File system and logical volume manager for ZFS filesystems
[Zigbee2MQTT](https://github.com/Koenkk/zigbee2mqtt) | Zigbee to MQTT bridge for connecting Zigbee devices to a MQTT broker
[zrepl](https://github.com/zrepl/zrepl) | Asynchronous ZFS replication and backup solution

## External Resources and Services

Name | Description
---- | -----------
[Cloudflare](https://www.cloudflare.com) | DNS Server which is nativly supported by cert-manager.io and external-dns
[Gandi](https://gandi.net) | Domain Provider
[IONOS VPS](https://www.ionos.de/server/vps) | Simple 1€/month VPS. Providing stable IPv4 that is bridged with [Rathole](https://github.com/rapiz1/rathole) to my homelab
[Scaleway Glacier (S3 Cold Storage)](https://www.scaleway.com/en/glacier-cold-storage/) | S3 Compatible storage for Restic for just 2€/TB

## Hardware Stack

### Server "Spirit"

* CPU: Ryzen 5800X
* RAM: 64GB ECC
* Mainboard: X470D4U2-2T
* OS: Debian 12
* OS SSD: MX500 500GB
* Storage ZPOOL SATA SSD: ZFS Spanned Pool (RAID 0)
  * Crucial MX500 2TB
  * Samsung 850 EVO 2TB
* Storage ZPOOL NVMe SSD: ZFS Mirrored Pool (RAID 1)
  * 2x WD Black SN850X 2TB
* Storage ZPOOL HDD: 2x ZRAID2 (RAID 6)
  * 12x WD White Label 18TB

### Server "Dawn"

* Raspberry Pi 4
* RAM: 8GB
* OS: Raspberry Pi OS
* OS SSD: Crucial MX500 512GB

### Network Equipment

* FRITZ!Box 7590 AX
* 3x UniFi Switch Flex XG (4x 10 Gbit/s / 1 Gbit/s)
* 3x UniFi Switch Flex Mini (5x 1 Gbit/s)
