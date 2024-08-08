terraform {
  backend "s3" {
    key                         = "proxmox.tfstate"
    region                      = "fr-par"
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    access_key                  = var.backend_access_key
    secret_key                  = var.backend_secret_key
    bucket                      = var.backend_bucket
    endpoints = {
      s3 = "https://s3.fr-par.scw.cloud"
    }
  }
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.62.0"
    }
  }
  required_version = "~> 1.8"
}

provider "proxmox" {
  alias    = "node1"
  endpoint = "https://192.168.0.5:8006/"
  username = var.proxmox_user
  password = var.proxmox_password
  insecure = true
}

provider "proxmox" {
  alias    = "node2"
  endpoint = "https://192.168.0.32:8006/"
  username = var.proxmox_user
  password = var.proxmox_password
  insecure = true
}

provider "proxmox" {
  alias    = "node3"
  endpoint = "https://192.168.0.33:8006/"
  username = var.proxmox_user
  password = var.proxmox_password
  insecure = true
}
