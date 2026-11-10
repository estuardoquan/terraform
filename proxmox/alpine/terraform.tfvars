snippet_store = "proxmox"

servers = {
    "alpine-299" = {
        vmid = 299
        node = "pve-39"
        template = 200
        memory = 2048
        cpu = {
            cores = 2
        }
        address = "10.10.0.79"
        nameservers = ["10.10.0.254"]
        net = {
            bridge = "vmbr0"
            gateway = "10.10.0.254"
        }
        disks = {
            "scsi0" = {
                store = "vm"
            }
            "scsi1" = {
                mount = "/home"
                size = 2
                store = "vm"
            }
            "scsi2" = {
                mount = "/var/lib/docker"
                size = 4
                store = "vm"
            }
        }
        packages = [
            "docker",
            "docker-compose-cli",
        ]
    }
}

default_packages = [
    "build-base",
    "clang-extra-tools",
    "lua-language-server",
    "neovim",
    "nodejs",
    "npm",
    "stow",
    "tmux",
    "tree-sitter-cli",
]
