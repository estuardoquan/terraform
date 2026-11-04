// Cluster nodes //
variable "servers" {
  type = map(object({
    vmid = number
    node = string
    template  = number
    os = options(string)
    domain = optional(string,"local")
    // HARDWARE
    cpu = optional(object({
      cores = optional(number, 2)
      type = optional(string, "x86-64-v2-AES")
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
    packages = optional(list(string), [
      "lua-language-server",
      "clang-extra-tools",
      "tree-sitter-cli",
      "build-base",
      "nodejs",
      "npm",
    ])
  }))
}

variable "ssh_key_file" {
  type    = string
  default = "~/.ssh/id_ed25519"
}

variable "github_ssh_key_file" {
  type    = string
  default = "~/.ssh/id_github"
}

variable "snippet_store" {
  type = string
  default = "local-lvm"
}

variable "snippet_node" {
  type = string
  default = "pve-39"
}

variable "os" {
  type = list(string)
  default = ["alpine", "deb-k3s"]
}
