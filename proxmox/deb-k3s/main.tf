resource "proxmox_virtual_environment_vm" "k3s" {
  for_each = var.servers

  name      = each.key
  vm_id     = each.value.vmid
  node_name = each.value.node_name

  clone {
    vm_id     = each.value.template_vmid
    node_name = each.value.node_name
    full      = true
  }

  cpu {
    cores = var.cpu_cores
    type  = var.cpu_type
  }

  memory {
    dedicated = var.memory
    floating  = 0
  }

  disk {
    datastore_id = var.disk_datastore
    interface    = "scsi0"
    size         = var.disk_size
    discard      = "on"
    ssd          = true
  }

  network_device {
    bridge  = var.net_bridge
    vlan_id = var.net_vlan_id
    model   = "virtio"
  }

  initialization {
    datastore_id = var.disk_datastore

    ip_config {
      ipv4 {
        address = "${each.value.address}/${var.net_prefix}"
        gateway = var.net_gateway
      }
    }

    dns {
      servers = var.nameservers
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
    datastore_id = var.disk_datastore
    type         = "4m"
  }

  lifecycle {
    ignore_changes = [clone]
  }
}
