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
      source  = "Telmate/proxmox"
      version = "3.0.1-rc3"
    }
  }
  required_version = "~> 1.8"
}

provider "proxmox" {
  alias       = "node1"
  pm_api_url  = "https://192.168.0.5:8006/api2/json"
  pm_user     = var.proxmox_user
  pm_password = var.proxmox_password
}

provider "proxmox" {
  alias       = "node2"
  pm_api_url  = "https://192.168.0.32:8006/api2/json"
  pm_user     = var.proxmox_user
  pm_password = var.proxmox_password
}

provider "proxmox" {
  alias       = "node3"
  pm_api_url  = "https://192.168.0.33:8006/api2/json"
  pm_user     = var.proxmox_user
  pm_password = var.proxmox_password
}
