resource "proxmox_vm_qemu" "this" {
  name        = var.name
  target_node = var.target_node
  vmid        = var.vmid
  cpu         = "host"
  cores       = var.cores
  memory      = var.memory
  onboot      = true

  network {
    bridge    = "vmbr0"
    firewall  = false
    link_down = false
    model     = "virtio"
  }
  disks {
    scsi {
      scsi0 {
        disk {
          size    = var.size
          storage = var.storage_name
        }
      }
    }
    ide {
      ide1 {
        cdrom {
          iso = var.iso
        }
      }
    }
  }

  # TODO Use this once the provider has fixed this:
  # https://github.com/Telmate/terraform-provider-proxmox/issues/1029
  # dynamic "hostpci" {
  #   for_each = var.pci_devices
  #   content {
  #     host   = hostpci.value
  #     rombar = 1
  #     pcie   = 1
  #   }
  # }
  lifecycle {
    ignore_changes = [
      hostpci
    ]
  }
}
