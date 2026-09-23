// Cluster nodes //
variable "servers" {
  type = map(object({
    vmid      = number
    node_name = string
    template_vmid = number
    address   = string
  }))
}

// Hardware //
variable "cpu_cores" {
  type    = number
  default = 4
}

variable "cpu_type" {
  type    = string
  default = "host"
}

variable "memory" {
  type    = number
  default = 8192
}

variable "disk_size" {
  type    = number
  default = 16
}

variable "disk_datastore" {
  type    = string
  default = "local-lvm"
}

// Snippets live on the shared NFS storage //
variable "snippet_datastore" {
  type    = string
  default = "local-lvm"
}

variable "snippet_node" {
  type    = string
  default = "pve-0"
}

// Network //
variable "net_bridge" {
  type    = string
  default = "vmbr0"
}

variable "net_vlan_id" {
  type    = number
  default = null
}

variable "net_gateway" {
  type    = string
  default = "10.0.0.254"
}

variable "net_prefix" {
  type    = number
  default = 24
}

variable "nameservers" {
  type    = list(string)
  default = ["10.0.0.254"]
}

// Guest account //
variable "username" {
  type = string
  default = "admin"
}

variable "ssh_public_key_file" {
  type    = string
  default = "~/.ssh/tf_id_ed25519.pub"
}

// nsupdate //
variable "nsupdate_key_secret" {
  type      = string
  sensitive = true
}
