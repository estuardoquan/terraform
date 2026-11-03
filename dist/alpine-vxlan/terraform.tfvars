snippet_store = "proxmox"
ssh_public_key_file = "~/.ssh/id_ed25519.pub"

servers = {
    "alpine-351" = {
        vmid = 351
        node = "pve-39"
        template = 3050
        memory = 2048
        address = "10.30.0.51"
        nameservers = ["10.30.0.254"]
        net = {
            bridge = "vxlan0"
            gateway = "10.30.0.254"
        }
        disk = {
            size = 32
            store = "vm"
        }
    }
    "alpine-352" = {
        vmid = 352
        node = "pve-39"
        template = 3050
        memory = 2048
        address = "10.30.0.52"
        nameservers = ["10.30.0.254"]
        net = {
            bridge = "vxlan0"
            gateway = "10.30.0.254"
        }
        disk = {
            size = 32
            store = "vm"
        }
    }
    "alpine-353" = {
        vmid = 353
        node = "pve-39"
        template = 3050
        memory = 2048
        address = "10.30.0.53"
        nameservers = ["10.30.0.254"]
        net = {
            bridge = "vxlan0"
            gateway = "10.30.0.254"
        }
        disk = {
            size = 32
            store = "vm"
        }   
    }
    "alpine-1000" = {
        vmid = 1000
        node = "pve-38"
        template = 3050
        memory = 8192
        cpu = {
            cores = 4
        }
        address = "10.255.10.10"
        nameservers = ["10.255.10.254"]
        net = {
            bridge = "vxlan0"
            gateway = "10.255.10.254"
            vlan = 10
        }
        disk = {
            size = 32
            store = "vm"
        }
    }
}
