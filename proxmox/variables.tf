variable "backend_access_key" {
  type        = string
  description = "Access key for the backend configuration"
}

variable "backend_secret_key" {
  type        = string
  description = "Secret key for the backend configuration"
  sensitive   = true
}

variable "backend_bucket" {
  type        = string
  description = "Bucket name for the backend configuration"
}

variable "proxmox_user" {
  type        = string
  description = "Username for the proxmox API"
}

variable "proxmox_password" {
  type        = string
  description = "Password for the proxmox API"
  sensitive   = true
}
