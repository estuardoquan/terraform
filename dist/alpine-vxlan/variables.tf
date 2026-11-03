// Cluster nodes //
variable "servers" {
  type = map(object({
    vmid      = number
    node_name = string
    template_vmid = number
    address   = string
    cpu = object({
      cores = optional(number, 2)
      type = optional(string, host)
    })
    memory = number
    net = object({
      bridge = string
      gateway = optional(string)
      prefix = optional(number, 24) 
      trunks = optional(string)
      vlan = optional(number)
    })
    disk = object({
      size = number
      store = string
    })
    nameservers = list(string)
    snippets = object({
      store = string
      node = string
    })
  }))
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

variable "github_ssh_key_file" {
  type    = string
  default = "~/.ssh/id_github"
}
// nsupdate //
variable "nsupdate_key_secret" {
  type      = string
  sensitive = true
}
