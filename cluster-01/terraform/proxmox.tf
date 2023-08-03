resource "proxmox_virtual_environment_hosts" "first_node_host_entries" {
  node_name = "proxmox"

  entry {
    address = "127.0.0.1"

    hostnames = [
      "localhost",
      "localhost.localdomain",
      "proxmox"
    ]
  }
}

resource "proxmox_virtual_environment_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "proxmox"

  source_file {
    path = "http://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"
  }
}

resource "proxmox_virtual_environment_file" "talos_image" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "proxmox"

  source_file {
    path = "../../images/talos-amd64.iso"
  }
}

