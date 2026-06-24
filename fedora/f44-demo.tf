resource "proxmox_vm_qemu" "f44_se_0" {
        name = var.name 
        description = "Fedora Server 44"
        vmid = var.vmid
        target_node = var.target_node

        bios = var.bios
        agent = var.agent
        clone = var.clone
        memory = var.memory
        scsihw = var.scsihw
        automatic_reboot = var.auto_reboot
        
        cpu {
            sockets = var.cpu["sockets"]
            cores = var.cpu["cores"]
        }

        network {
            id = 0
            model  = "virtio"
            bridge = var.network[0]
        }
        
        disks {
            scsi {
                scsi0 {
                    disk {
                        storage = var.storage
                        size    = var.disk_size
                    }
                }
            }
            ide {
                ide0 {
                    cloudinit {
                        storage = var.storage
                    }
                }
            }
        }

        efidisk {
            storage = var.storage
            efitype = "4m" 
        }

        os_type = "cloud_init"
        ciupgrade  = true

        ipconfig0 = "ip=10.30.0.216/24,gw=10.30.0.254"
        nameserver = "10.30.0.254"
        skip_ipv6  = true

        cicustom = "user=nas:snippets/f44-user.yaml"
}
