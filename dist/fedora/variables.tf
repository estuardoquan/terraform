variable "name" {
  type = string
  default = "fedora"
}

variable "vmid" {
  type = string
  default = "300"
}

variable "target_node" {
  type = string
  default = "pve"
}

variable "bios" {
  type = string
  default = "ovmf"
}

variable "agent" {
  type = string
  default = "1"
}

variable "clone" {
  type = string
  default = "f44-se"
}

variable "memory" {
  type = string
  default = "4096"
}

variable "scsihw" {
  type = string
  default = "virtio-scsi-pci"
}

variable "auto_reboot" {
  type = bool
  default = true
}

variable "cpu" {
  type = map(number)
  default = {
    sockets = 1
    cores = 2
  }
}

variable "network" {
  type = list(string)
  default = [
    "vmbr0"
  ]
}

variable "storage" {
  type = string
  default = "local-lvm"
}

variable "disk_size" {
  type = string
  default = "32G"
}

variable "ipconfig" {
  type = list(string)
  default = [
    "ip=dhcp"
  ]
}

