locals {
  data_disks = merge([
    for name, server in var.servers : {
      for k, v in server.disks : "${name}-${k}" => {
        server = name
        node   = server.node
        vmid   = server.vmid + 1000 * tonumber(trimprefix(k, "scsi"))
        key    = k
        size   = v.size
        store  = v.store
      }
    }
  ]...)
}

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
  
  disk {
    datastore_id = each.value.disk.store
    interface    = "scsi0"
    size         = each.value.disk.size
    discard      = "on"
    ssd          = true
  }
  dynamic "disk" {
    for_each = each.value.disks
    content {
      datastore_id      = disk.value.datastore_id
      interface         = disk.key
      size              = disk.value.size
      discard           = "on"
      ssd               = true
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
  for_each = local.data_disks

  name      = "${each.value.server}-data-${each.value.key}"
  vm_id     = each.value.vmid
  node_name = each.value.node
  started   = false
  on_boot   = false

  disk {
    datastore_id = each.value.store
    interface    = each.value.key
    size         = each.value.size
  }
}
