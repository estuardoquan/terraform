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
                mount = "/home"
                size = 20
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

default_bootcmd = [
    "pv=$(pvs --noheadings -o pv_name -S vg_name=vg0 | tr -d ' ' | head -n 1)",
    "part=$(basename \"$(readlink -f \"$pv\")\")",
    "growpart \"/dev/$(basename \"$(readlink -f /sys/class/block/$part/..)\")\" \"$(cat /sys/class/block/$part/partition)\" || true",
    "[ \"$(vgs --noheadings -o vg_free_count vg0 | tr -d ' ')\" -gt 0 ] && lvextend -r -l +100%FREE vg0/root || true",
]

default_packages = [
    "neovim",
    "nodejs",
    "npm",
    "stow",
    "tmux",
    "unzip",
]
