template_vmid = 230
username      = "admin"

snippet_node = "pve-39"
snippet_datastore = "proxmox"

net_bridge = "vlan20"
net_gateway = "10.10.20.254"
nameservers = ["10.10.20.254"]

servers = {
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
