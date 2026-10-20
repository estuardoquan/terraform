net_bridge = "vxlan0"
#net_vlan_id = 30
#net_trunks = "10;20"
net_gateway = "10.30.0.254"
nameservers = ["10.30.0.254"]

snippet_node = "pve-39"
snippet_datastore = "proxmox"
disk_datastore = "vm"
disk_size = 32
ssh_public_key_file = "~/.ssh/id_ed25519.pub"

cpu_cores = 2
memory = 2048

servers = {
    "alpine-351" = {
        vmid          = 351
        node_name     = "pve-39"
        template_vmid = 3050
        address       = "10.30.0.51"
    }
    "alpine-352" = {
        vmid          = 352
        node_name     = "pve-39"
        template_vmid = 3050
        address       = "10.30.0.52"
    }
}


username = "admin"
