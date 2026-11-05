snippet_store = "proxmox"

servers = {
    "debian-499" = {
        vmid = 499
        node = "pve-38"
        template = 400
        memory = 2048
        cpu = {
            cores = 2
        }
        address = "10.10.0.50"
        nameservers = ["10.10.0.254"]
        net = {
            bridge = "vmbr0"
            gateway = "10.10.0.254"
        }
        disk = {
            size = 32
            store = "vm"
        }
    }
}
