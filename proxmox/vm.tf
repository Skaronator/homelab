locals {
  cp = {
    cores  = 4
    memory = 4096
    size   = "32G"
    iso    = "local:iso/talos-v1.7.5.iso"
  }
  worker = {
    cores  = 16
    memory = 48 * 1024
    size   = "64G"
    iso    = "local:iso/talos-v1.7.5.iso"
  }
}

module "vm_node_1" {
  for_each = {
    "talos-cp-1" = merge(local.cp, {
      name = "talos-cp-1"
      vmid = 101
    })
    "talos-worker-1" = merge(local.worker, {
      name = "talos-worker-1"
      vmid = 111
    })
  }
  source = "./modules/vm"

  name         = each.value.name
  target_node  = "node1"
  vmid         = each.value.vmid
  cores        = each.value.cores
  memory       = each.value.memory
  size         = each.value.size
  storage_name = "local-zfs"
  iso          = each.value.iso
  pci_devices  = lookup(each.value, "pci_devices", [])

  providers = {
    proxmox = proxmox.node1
  }
}

module "vm_node_2" {
  for_each = {
    "talos-cp-2" = merge(local.cp, {
      name = "talos-cp-2"
      vmid = 102
    })
    "talos-worker-2" = merge(local.worker, {
      name = "talos-worker-2"
      vmid = 112
      pci_devices = [
        "0000:07:00.0"
      ]
    })
  }
  source = "./modules/vm"

  name         = each.value.name
  target_node  = "node2"
  vmid         = each.value.vmid
  cores        = each.value.cores
  memory       = each.value.memory
  size         = each.value.size
  storage_name = "local-lvm"
  iso          = each.value.iso
  pci_devices  = lookup(each.value, "pci_devices", [])

  providers = {
    proxmox = proxmox.node2
  }
}

module "vm_node_3" {
  for_each = {
    "talos-cp-3" = merge(local.cp, {
      name = "talos-cp-3"
      vmid = 103
    })
    "talos-worker-3" = merge(local.worker, {
      name = "talos-worker-3"
      vmid = 113
    })
  }
  source = "./modules/vm"

  name         = each.value.name
  target_node  = "node3"
  vmid         = each.value.vmid
  cores        = each.value.cores
  memory       = each.value.memory
  size         = each.value.size
  storage_name = "local-lvm"
  iso          = each.value.iso
  pci_devices  = lookup(each.value, "pci_devices", [])

  providers = {
    proxmox = proxmox.node3
  }
}
