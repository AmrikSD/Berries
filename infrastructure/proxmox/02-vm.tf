resource "proxmox_virtual_environment_vm" "talos_vm_k8s_master" {
  node_name       = "proxmox"
  count           = 3
  stop_on_destroy = true

  name        = "talos-k8s-master-${count.index + 1}"
  description = "Managed By Terraform"
  tags        = ["master", "talos", "terraform"]

  vm_id = 400 + count.index

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.talos.id
    interface    = "scsi0"
  }

  operating_system {
    type = "l26"
  }

  memory {
    dedicated = 2048
  }

  cpu {
    type  = "x86-64-v2-AES"
    cores = 2
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  tpm_state {
    version = "v2.0"
  }


  lifecycle {
    ignore_changes = [
      description
    ]
  }
}


resource "proxmox_virtual_environment_vm" "talos_vm_k8s_worker" {
  node_name       = "proxmox"
  count           = 3
  stop_on_destroy = true

  name        = "talos-k8s-worker-${count.index + 1}"
  description = "Managed By Terraform"
  tags        = ["worker", "talos", "terraform"]

  vm_id = 410 + count.index

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.talos.id
    interface    = "scsi0"
  }

  operating_system {
    type = "l26"
  }

  memory {
    dedicated = 2048
  }

  cpu {
    type  = "x86-64-v2-AES"
    cores = 2
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  tpm_state {
    version = "v2.0"
  }


  lifecycle {
    ignore_changes = [
      description
    ]
  }

}
