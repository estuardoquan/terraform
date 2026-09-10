// Template //
variable "template_vmid" {
  type    = number
  default = 0
}

// Cluster nodes //
variable "servers" {
  type = map(object({
    vmid      = number
    node_name = string
    address   = string
    bootstrap = bool
  }))
    validation {
    condition     = length([for s in var.servers : s if s.bootstrap]) == 1
    error_message = "Exactly one server must have bootstrap = true."
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

// k3s //
variable "k3s_token" {
  type      = string
  sensitive = true
  default   = ""
}
