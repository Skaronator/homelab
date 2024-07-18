
resource "proxmox_virtual_environment_vm" "this" {
  name            = var.name
  node_name       = var.target_node
  description     = "Managed by Terraform"
  vm_id           = var.vmid
  stop_on_destroy = true
  keyboard_layout = "de"

  memory {
    dedicated = var.memory
  }

  cpu {
    cores        = var.cores
    architecture = "x86_64"
    type         = "host"
  }

  cdrom {
    enabled = true
    file_id = var.iso
  }

  disk {
    datastore_id = var.storage_name
    file_format  = "raw"
    interface    = "scsi0"
    size         = var.size
  }

  network_device {
    bridge = "vmbr0"
  }

  operating_system {
    type = "l26"
  }

  dynamic "hostpci" {
    for_each = var.hostpci
    content {
      device = hostpci.key
      id     = hostpci.value
      rombar = true
    }
  }
}
