resource "proxmox_virtual_environment_vm" "default" {
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
  
  dynamic "disk" {
    for_each = { for d in try(proxmox_virtual_environment_vm.data[each.key].disk, []) : d.interface => d }
    content {
      datastore_id      = disk.value.datastore_id
      path_in_datastore = disk.value.path_in_datastore
      file_format       = disk.value.file_format
      size              = disk.value.size
      interface         = disk.key
      discard           = "on"
      ssd               = "off"
    }
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
    ignore_changes = [
      clone, 
      initialization[0].user_data_file_id
    ]
  }
}

resource "proxmox_virtual_environment_vm" "data" {
  for_each = { for name, server in var.servers : name => server if length(server.disks) > 0 }

  name      = "${each.key}-data"
  node_name = each.value.node
  started   = false
  on_boot   = false

  dynamic "disk" {
    for_each = each.value.disks
    content {
      datastore_id = disk.value.store
      interface    = disk.key
      size         = disk.value.size
    }
  }
}
