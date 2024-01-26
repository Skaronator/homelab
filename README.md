# Niklas Homelab

This project utilizes Infrastructure as Code and GitOps to automate the provisioning, operation, and updating of self-hosted services in my homelab.

![img](./.github/images/dashboard.png)

## History

This is a new approach to the GitOps infrastructure for my Homelab. Until now, I utilized a private self-hosted Gitlab Repository containing all Kubernetes Deployments written in Terraform. I recently started migrating all deployments from Terraform to ArgoCD due to [outstanding design issues in Terraform with Kubernetes CRD and CR](https://github.com/hashicorp/terraform-provider-kubernetes/issues/1367).

## Hardware Stack

The hardware was specifically selected to achieve a low-power C10 CPU state, resulting in a power draw of around **12 watts** for Node 2 and 3. Node 1, however, draws more power due to the HDDs, but there is room for improvement in the future (considering MergeFS + SnapRAID).

### Network Equipment

* FRITZ!Box 7590 AX
* 1x UniFi Switch Aggregation (8x 10 Gbit/s SFP+)
* 3x UniFi Switch Flex XG (4x 10GBASE-T + 1x 1 Gbit/s)
* 3x UniFi Switch Flex Mini (5x 1 Gbit/s)

### Server "Node 1" (HDD Storage)

Node 1 is the primary storage server that contains all spinning rust disks.

<details>
<summary>Detailed Hardware Specs</summary>

* CPU: Intel i5 14600
* RAM: 128 GB DDR4-3200 CL16-18-18-38
* Mainboard: ASUS Prime H770-Plus D4
* NIC: Intel X710-DA2 (2x 10 GBit/s SFP+)
* OS: Debian 12
* OS SSD: MX500 500GB
* Storage ZFS ZPOOL HDD
  * ZRAID2 (Raid6)
    * 6x WD White Label 18TB
  * ZRAID2 (Raid6)
    * 6x WD White Label 18TB
* Storage ZFS ZPOOL SSD: ZFS Spanned Pool (RAID 0)
  * Crucial MX500 2TB
  * Samsung 850 EVO 2TB
* Storage RookIO
  * 2x WD Black SN850X 2TB

</details>

### Server "Node 2"

Node 2 is a low-power node for Kubernetes. It contains fast NVMe storage and fast networking for Rook.io/CephFS Storage.

<details>
<summary>Detailed Hardware Specs</summary>

* CPU: Intel i5 14600
* RAM: 64GB GB DDR4-3200 CL16-18-18-38
* Mainboard: ASUS Prime H770-Plus D4
* NIC: Intel X710-DA2 (2x 10 GBit/s SFP+)
* OS: Debian 12
* OS SSD:
* Storage RookIO
  * 1x Samsung 990 Pro 4TB

</details>

### Server "Node 3"

Node 3 is a low-power node for Kubernetes. It contains fast NVMe storage and fast networking for Rook.io/CephFS Storage.

<details>
<summary>Detailed Hardware Specs</summary>

* CPU: Intel i5 14600
* RAM: 64GB GB DDR4-3200 CL16-18-18-38
* Mainboard: ASUS Prime H770-Plus D4
* NIC: Intel X710-DA2 (2x 10 GBit/s SFP+)
* OS: Debian 12
* OS SSD:
* Storage RookIO
  * 1x Samsung 990 Pro 4TB

</details>

## Software Stack

All servers run the latest version of Debian. Kubernetes is provisioned by the awesome [k0s project](https://github.com/k0sproject/k0s).

**Storage** is separated into two types:

- **Cluster storage** is provisioned with [Rook.io](https://rook.io/) that runs on my fast NVMe drives. Storage is replicated across all 3 nodes, which means that all services continue to run even when 2 nodes fail.
- **Local storage** is directly connected to [Node 1](#server-node-1-hdd-storage) to improve storage capacity. This is mostly the spinning rust disks.

Backups are done directly with [Restic](https://github.com/restic/restic) and in the future with [velero](https://github.com/vmware-tanzu/velero), which also uses restic in the background. Backups are stored in [Scaleway Glacier Cold Storage](https://www.scaleway.com/en/glacier-cold-storage/), costing 2€/TB.

**Ingress** is done using [ingress-nginx](https://github.com/kubernetes/ingress-nginx) Ingress Controller. The ingress controller is deployed twice for these use cases:

- **nginx-private** provisions an Ingress that is only available from the local network.
- **nginx-public** provisions an Ingress that is only available from the worldwide web.

[MetalLB](https://github.com/metallb/metallb) provides a stable IP that is highly available and doesn't depend on a single node to be available.

**DNS** records are automatically applied via [external-dns](https://github.com/kubernetes-sigs/external-dns). External DNS is deployed twice:

- **private** watches all nginx-private ingress resources and automatically updates my AdGuardHome DNS records.
- **public** watches all nginx-public ingress resources and automatically updates my Cloudflare DNS records.

Automatic updates are handled by [renovate](https://github.com/renovatebot/renovate). Deployments are done using [ArgoCD](https://github.com/argoproj/argo-cd).
