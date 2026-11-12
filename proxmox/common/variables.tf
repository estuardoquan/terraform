// Cluster nodes //
variable "servers" {
  type = map(object({
    vmid = number
    node = string
    template  = number
    domain = optional(string,"local")
    // HARDWARE
    cpu = optional(object({
      cores = optional(number, 2)
      type = optional(string, "x86-64-v2-AES")
    }),{})
    efi = optional(object({
      store = optional(string, "local-lvm")
      size = optional(string, "4m")
    }), {})
    disks = optional(map(object({
      size = optional(number, 1)
      store = optional(string, "local-lvm")
      lvm = map(object({
        mount = optional(string)
        vg = optional(string, "vg0")
        lv = optional(string, "lv_root")
        size = optional(string, "100%")
      }),{})
    }), {
      "scsi0" = {
        size = 4
      }
      "scsi1" = {
        size = 2
        lvm = {
          mount = "/home"
          vg = "vg_data"
          lv = "lv_home"
        }
      }
    }))
    swap_size = optional(string, "")
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
    packages = optional(list(string), [])
    bootcmd = optional(list(string), [])
    runcmd = optional(list(string), [])
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

variable "default_bootcmd" {
  type = list(string)
  default = [
    "pv=$(pvs --noheadings -o pv_name -S vg_name=vg0 | tr -d ' ' | head -n 1)",
    "part=$(basename \"$(readlink -f \"$pv\")\")",
    "growpart \"/dev/$(basename \"$(readlink -f /sys/class/block/$part/..)\")\" \"$(cat /sys/class/block/$part/partition)\" || true",
    "[ \"$(vgs --noheadings -o vg_free_count vg0 | tr -d ' ')\" -gt 0 ] && lvextend -r -l +100%FREE vg0/lv_root || true",
  ]
}

variable "default_packages" {
  type = list(string)
  default = []
}

variable "default_runcmd" {
  type = list(string)
  default = []
}

variable "default_vg" {
  type = string
  default = "vg0"
}
