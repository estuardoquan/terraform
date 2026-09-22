net_bridge = "vlan30"
net_gateway = "10.10.30.254"
nameservers = ["10.10.30.254"]

snippet_node = "pve-39"
snippet_datastore = "proxmox"
disk_datastore = "ssd-pool-vm"
disk_size = 16
ssh_public_key_file = "~/.ssh/id_ed25519.pub"

servers = {
  "alpine-350" = {
    vmid          = 350
    node_name     = "pve-39"
    template_vmid = 3050
    address       = "10.10.30.50"
  }
}


username = "admin"
