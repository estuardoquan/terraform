// Template //
variable "template_vmid" {
  type    = number
  default = 230
}

// Cluster nodes //
variable "servers" {
  type = map(object({
    vmid      = number
    node_name = string
    address   = string
    bootstrap = bool
  }))
  default = {
    "k3s-238" = {
      vmid      = 238
      node_name = "pve-38"
      address   = "10.10.20.38"
      bootstrap = true
    }
    "k3s-239" = {
      vmid      = 239
      node_name = "pve-39"
      address   = "10.10.20.39"
      bootstrap = false
    }
  }
}
// Hardware //
variable "cpu_cores" {
  type    = number
  default = 2
}

variable "cpu_type" {
  type    = string
  default = "host"
}

variable "memory" {
  type    = number
  default = 4096
}

variable "disk_size" {
  type    = number
  default = 32
}

variable "disk_datastore" {
  type    = string
  default = "local-lvm"
}

// Snippets live on the shared NFS storage //
variable "snippet_datastore" {
  type    = string
  default = "proxmox"
}

variable "snippet_node" {
  type    = string
  default = "pve-39"
}

// Network //
variable "net_bridge" {
  type    = string
  default = "vlan20"
}

variable "net_vlan_id" {
  type    = number
  default = null
}

variable "net_gateway" {
  type    = string
  default = "10.10.20.254"
}

variable "net_prefix" {
  type    = number
  default = 24
}

variable "nameservers" {
  type    = list(string)
  default = ["10.10.20.254"]
}

// Guest account //
variable "username" {
  type = string
  default = "admin"
}

variable "ssh_public_key_file" {
  type    = string
  default = "~/.ssh/id_ed25519.pub"
}

// k3s //
variable "k3s_token" {
  type      = string
  sensitive = true
  default   = ""
}
