locals {
  vms = {
    "vm-node-0" = { id = "1000", pw_length = 16 },
    "vm-node-1" = { id = "1001", pw_length = 16 },
    "vm-node-2" = { id = "1002", pw_length = 16 },
  }
}

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


resource "random_password" "vm-node" {
  for_each         = local.vms
  length           = each.value.pw_length
  override_special = "_%@"
  special          = true
}

resource "tls_private_key" "vm-node" {
  for_each  = local.vms
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "proxmox_virtual_environment_vm" "vm-node" {

  for_each = local.vms

  name        = each.key
  description = "Managed by Terraform"
  tags        = ["terraform", "talos"]

  node_name = "proxmox"
  vm_id     = each.value.id

  agent {
    enabled = false
  }

  startup {
    order      = "1"
    up_delay   = "60"
    down_delay = "60"
  }

  cpu {
    cores = 2
    type  = "x86-64-v2"
  }

  memory {
    dedicated = 4096
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_file.talos_image.id
    interface    = "virtio0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_account {
      keys     = [trimspace(tls_private_key.vm-node[each.key].public_key_openssh)]
      password = random_password.vm-node[each.key].result
      username = "ubuntu"
    }
  }

  network_device {
    bridge = "vmbr0"
  }

  operating_system {
    type = "l26"
  }

  serial_device {}
}
