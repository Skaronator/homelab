# Waiting for OpenTF 1.9 so we can use for_each provider
resource "proxmox_virtual_environment_download_file" "talos_1_7_5_node1" {
  provider           = proxmox.node1
  node_name          = "node1"
  content_type       = "iso"
  datastore_id       = "local"
  file_name          = "talos-v1.7.5.iso"
  url                = "https://github.com/siderolabs/talos/releases/download/v1.7.5/metal-amd64.iso"
  checksum           = "494dfafbf3b0eba1d71c24511989de554ef94d3c153d1dca107dc44fa2d7b31c34217c5036a5d0c2d205c3ed631892ef9cc12b3ef56ba7131c387c9fe1edee20"
  checksum_algorithm = "sha512"
}

resource "proxmox_virtual_environment_download_file" "talos_1_7_5_node2" {
  provider           = proxmox.node2
  node_name          = "node2"
  content_type       = "iso"
  datastore_id       = "local"
  file_name          = "talos-v1.7.5.iso"
  url                = "https://github.com/siderolabs/talos/releases/download/v1.7.5/metal-amd64.iso"
  checksum           = "494dfafbf3b0eba1d71c24511989de554ef94d3c153d1dca107dc44fa2d7b31c34217c5036a5d0c2d205c3ed631892ef9cc12b3ef56ba7131c387c9fe1edee20"
  checksum_algorithm = "sha512"
}

resource "proxmox_virtual_environment_download_file" "talos_1_7_5_node3" {
  provider           = proxmox.node3
  node_name          = "node3"
  content_type       = "iso"
  datastore_id       = "local"
  file_name          = "talos-v1.7.5.iso"
  url                = "https://github.com/siderolabs/talos/releases/download/v1.7.5/metal-amd64.iso"
  checksum           = "494dfafbf3b0eba1d71c24511989de554ef94d3c153d1dca107dc44fa2d7b31c34217c5036a5d0c2d205c3ed631892ef9cc12b3ef56ba7131c387c9fe1edee20"
  checksum_algorithm = "sha512"
}
