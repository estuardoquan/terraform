snippet_store = "proxmox"

default_bootcmd = [
    "sh -c 'growpart /dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0 2 || true'",
    "sh -c '[ $(vgs --noheadings -o vg_free_count vg0 | tr -d ) -gt 0 ] && lvextend -r -l +100%FREE vg0/lv_root || true'"
]

default_packages = [
    "npm",
    "nodejs",
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
            size = 8
        }
        packages = [
            "podman",
            "unzip",
        ]
        runcmd = ["systemctl mask tmp.mount"]
    }
}
