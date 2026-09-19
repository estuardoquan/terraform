terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.66"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token" {
  type      = string
  sensitive = true
}

variable "proxmox_ssh_user" {
  type    = string
  default = "root"
}

provider "proxmox" {
  endpoint  = var.proxmox_api_url
  api_token = var.proxmox_api_token
  insecure  = true

  # Snippets are uploaded over SFTP, not the HTTP API — a PAM account is
  # required. The API token cannot do this on its own.
  #ssh {
  #  agent    = true
  #  username = var.proxmox_ssh_user
  #}

  ssh {
    username    = var.proxmox_ssh_user
    private_key = file(pathexpand("~/.ssh/id_ed25519"))
  }
}
