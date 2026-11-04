resource "proxmox_virtual_environment_vm" "alpine" {
  for_each = var.servers

  name      = each.key
  vm_id     = each.value.vmid
  node_name = each.value.node

  migrate = true

  clone {
    vm_id     = each.value.template
    node_name = each.value.node
    full      = true
  }

  cpu {
    cores = each.value.cpu.cores
    type  = each.value.cpu.type
  }

  memory {
    dedicated = each.value.memory
    floating  = 0
  }

  disk {
    datastore_id = each.value.disk.store
    interface    = "scsi0"
    size         = each.value.disk.size
    discard      = "on"
    ssd          = true
  }

  network_device {
    bridge  = each.value.net.bridge
    vlan_id = each.value.net.vlan
    model   = "virtio"
    trunks  = each.value.net.trunks
  }

  initialization {
    datastore_id = each.value.disk.store

    ip_config {
      ipv4 {
        address = "${each.value.address}/${each.value.net.prefix}"
        gateway = each.value.net.gateway
      }
    }

    dns {
      servers = each.value.nameservers
    }

    user_data_file_id = proxmox_virtual_environment_file.user_data[each.key].id
  }

  agent {
    enabled = true
  }

  operating_system {
    type = "l26"
  }

  machine = "q35"
  bios    = "ovmf"

  efi_disk {
    datastore_id = each.value.disk.store
    type         = "4m"
  }

  lifecycle {
    ignore_changes = [clone, initialization]
  }
}
