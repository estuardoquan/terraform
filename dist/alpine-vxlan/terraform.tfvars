snippet_store = "proxmox"
ssh_public_key_file = "~/.ssh/id_ed25519.pub"

servers = {
    "alpine-351" = {
        vmid = 351
        node = "pve-39"
        template = 3050
        address = "10.30.0.51"
        memory = 2048
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
        address = "10.30.0.52"
        memory = 2048
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
        address = "10.30.0.53"
        memory = 2048
        net = {
            bridge = "vxlan0"
            gateway = "10.30.0.254"
        }
        disk = {
            size = 32
            store = "vm"
        }   
    }
}
