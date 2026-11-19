snippet_store = "proxmox"

servers = {
    "lan-core" = {
        vmid = 201
        node = "pve-39"
        template = 200
        memory = 2048
        cpu = {
            cores = 2
        }
        address = "10.10.0.1"
        nameservers = ["10.10.0.254"]
        net = {
            bridge = "vmbr0"
            gateway = "10.10.0.254"
        }
        datastore = "vm"
        disks = {
            "scsi0" = {
                size = 4
            }
            "scsi1" = {
                size = 8
                lvm = {
                    vg = "vg1"
                    lv = {
                        "lv_home" = {
                            mount = "/home"
                            size = "25%"
                        }
                        "lv_docker" = {
                            mount = "/var/lib/docker"
                            size = "100%"
                        }
                    }
                }
            }
        }
        packages = [
            "docker",
            "docker-cli-compose",
        ]
        runcmd = [
            "rc-update add docker default",
            "rc-service docker start",
        ]
    }
}

default_packages = [
    "build-base",
    "clang-extra-tools",
    "git",
    "lua-language-server",
    "neovim",
    "nodejs",
    "npm",
    "stow",
    "tmux",
    "tree-sitter-cli",
]
