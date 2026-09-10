net_bridge = "vlan20"
net_gateway = "10.10.20.254"
nameservers = ["10.10.20.254"]

snippet_node = "pve-39"
snippet_datastore = "proxmox"
#disk_datastore = "proxmox"

ssh_public_key_file = "~/.ssh/id_ed25519.pub"


servers = {
  "k3s-238" = {
    vmid          = 238
    node_name     = "pve-38"
    template_vmid = 938
    address       = "10.10.20.38"
    bootstrap     = true
  }
  "k3s-239" = {
    vmid          = 239
    node_name     = "pve-39"
    template_vmid = 939
    address       = "10.10.20.39"
    bootstrap     = false
  }
}

username      = "admin"

