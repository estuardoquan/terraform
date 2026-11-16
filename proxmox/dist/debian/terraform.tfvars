snippet_store = "proxmox"

servers = {
    "debian-499" = {
        vmid = 499
        node = "pve-38"
        template = 400
        memory = 4096
        swap_size = "2G"
        disks = {
            "scsi0" = {
                size = 15
            }
            "scsi1" = {
                size = 20
                lvm = {
                    vg = "vg1"
                    lv = {
                        "lv_home" = {
                            mount = "/home"
                        }
                    }
                }
            }
        }
        cpu = {
            cores = 2
        }
        address = "10.10.0.50"
        nameservers = ["10.10.0.254"]
        net = {
            bridge = "vmbr0"
            gateway = "10.10.0.254"
        }
        packages = [
            "podman",
        ]
        runcmd = ["systemctl mask tmp.mount"]
    }
}

default_packages = [
    "neovim",
    "nodejs",
    "npm",
    "stow",
    "tmux",
    "unzip",
]
