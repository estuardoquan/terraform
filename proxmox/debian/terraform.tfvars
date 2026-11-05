snippet_store = "proxmox"

default_packages = [
    "nodejs",
    "npm",
]

servers = {
    "debian-499" = {
        vmid = 499
        node = "pve-38"
        template = 400
        memory = 4096
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
            size = 64
        }
        packages = [
            "podman",
            "unzip",
        ]
        runcmd = ["systemctl mask tmp.mount"]
    }
}
