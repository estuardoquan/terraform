// Cluster nodes //
variable "servers" {
  type = map(object({
    vmid = number
    node = string
    template  = number
    // HARDWARE
    cpu = optional(object({
      cores = optional(number, 2)
      type = optional(string, host)
    }),{})
    disk = optional(object({
      size = optional(number, 16)
      store = optional(string, "local-lvm")
    }),{})
    memory = number
    // NETWORK
    address   = string
    nameservers = list(string)
    net = optional(object({
      bridge = optional(string,"vmbr0")
      gateway = optional(string, "10.0.0.254")
      prefix = optional(number, 24) 
      trunks = optional(string)
      vlan = optional(number)
    }),{})
    // ACCOUNT
    username = optional(string, "admin")
  }))
}

variable "ssh_public_key_file" {
  type    = string
  default = "~/.ssh/tf_id_ed25519.pub"
}

variable "github_ssh_key_file" {
  type    = string
  default = "~/.ssh/id_github"
}

variable "snippets_store" {
  type = string
  default = "local-lvm"
}

variable "snippets_node" {
  type = string
  default = "pve-39"
}
