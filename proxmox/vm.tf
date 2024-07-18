locals {
  cp = {
    cores  = 4
    memory = 4096
    size   = 32
  }
  worker = {
    cores  = 16
    memory = 48 * 1024
    size   = 64
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
  iso          = proxmox_virtual_environment_download_file.talos_1_7_5_node1.id
  hostpci      = lookup(each.value, "hostpci", {})

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
      hostpci = {
        hostpci0 = "0000:07:00"
      }
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
  iso          = proxmox_virtual_environment_download_file.talos_1_7_5_node2.id
  hostpci      = lookup(each.value, "hostpci", {})

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
      hostpci = {
        hostpci0 = "0000:06:00"
      }
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
  iso          = proxmox_virtual_environment_download_file.talos_1_7_5_node3.id
  hostpci      = lookup(each.value, "hostpci", {})

  providers = {
    proxmox = proxmox.node3
  }
}
