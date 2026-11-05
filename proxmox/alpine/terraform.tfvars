snippet_store = "proxmox"

default_packages = [
    "lua-language-server",
    "clang-extra-tools",
    "tree-sitter-cli",
    "build-base",
    "nodejs",
    "npm",
]

servers = {
    "alpine-350" = {
        vmid = 350
        node = "pve-39"
        template = 3050
        memory = 2048
        cpu = {
            cores = 2
        }
        address = "10.10.30.50"
        nameservers = ["10.10.30.254"]
        net = {
            bridge = "vmbr0"
            gateway = "10.10.30.254"
            vlan = 30
            trunks = "10;20"
        }
        disk = {
            size = 32
            store = "vm"
        }
    }
    "alpine-351" = {
        vmid = 351
        node = "pve-39"
        template = 3050
        memory = 2048
        domain = "public"
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
        domain = "public"
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
        domain = "public"
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
        domain = "public"
        cpu = {
            cores = 4
        }
        address = "10.255.10.11"
        nameservers = ["10.255.10.254"]
        net = {
            bridge = "vxlan0"
            gateway = "10.255.10.254"
            vlan = 10
        }
        disk = {
            size = 32
        }
        packages = [
            "ripgrep"
        ]
    }
}
