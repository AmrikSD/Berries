terraform {
    required_version = ">= 1.5.4"
    required_providers {
        proxmox = {
            source = "bpg/proxmox"
            version = "~> 0.27.0"
        }
        sops = {
            source = "carlpett/sops"
            version = "~> 0.7.2"
        }
    }
}

provider "sops" {}

data "sops_file" "proxmox-secret" {
  source_file = "proxmox.sops.yaml"
}

provider "proxmox" {
    endpoint = "https://10.2.1.1:8006"
    insecure = true
    username = data.sops_file.proxmox-secret.data["proxmox.username"]
    password = data.sops_file.proxmox-secret.data["proxmox.password"]
}

