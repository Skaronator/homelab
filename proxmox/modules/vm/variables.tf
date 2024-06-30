variable "name" {
  type = string
}

variable "target_node" {
  type = string
}

variable "vmid" {
  type = number
}

variable "cores" {
  type = number
}

variable "memory" {
  type = number
}

variable "size" {
  type = string
}

variable "storage_name" {
  type = string
}

variable "iso" {
  type = string
}

variable "pci_devices" {
  type    = list(string)
  default = []
}
