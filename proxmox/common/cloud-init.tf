locals {
  github_private_key = sensitive(file(pathexpand(var.github_ssh_key_file)))
  github_public_key  = chomp(file(pathexpand("${var.github_ssh_key_file}.pub")))
  ssh_public_key = chomp(file(pathexpand("${var.ssh_key_file}.pub")))
  disk_bootcmd = {
    for name, server in var.servers : name => flatten([
      for k, v in server.disks : [
        "d=/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-${k}",
        "vgs vg_${k} >/dev/null 2>&1 || { pvcreate -y \"$d\" && vgcreate vg_${k} \"$d\"; }",
        "lvs vg_${k}/lv_${k} >/dev/null 2>&1 || lvcreate -y -n lv_${k} -l 100%FREE vg_${k}",
        "blkid -L ${k} >/dev/null || mkfs.ext4 -L ${k} /dev/vg_${k}/lv_${k}",
      ]
    ])
  }
  disk_mounts = {
    for name, server in var.servers : name => [
      for k, v in server.disks : ["LABEL=${k}", v.mount, "ext4", "defaults,nofail", "0", "2"] if v.mount != null
    ]
  }
}

resource "proxmox_virtual_environment_file" "user_data" {
  for_each = var.servers

  content_type = "snippets"
  datastore_id = var.snippet_store
  node_name    = var.snippet_node

  source_raw {
    file_name = "cloud-init-${each.key}.yaml"
    data = templatefile("${path.module}/templates/user.yaml.tftpl", {
      hostname            = each.value.domain == "" ? each.key : "${each.key}.${each.value.domain}" 
      username            = each.value.username
      nameservers         = each.value.nameservers
      swap_size           = each.value.swap_size
      disk_mounts         = local.disk_mounts[each.key]
      default_bootcmd     = var.default_bootcmd
      default_packages    = var.default_packages
      default_runcmd      = var.default_runcmd
      default_lv          = var.default_lv
      disk_bootcmd        = local.disk_bootcmd[each.key]
      bootcmd             = each.value.bootcmd
      packages            = each.value.packages
      runcmd              = each.value.runcmd
      ssh_public_key      = local.ssh_public_key
      github_private_key  = local.github_private_key
      github_public_key   = local.github_public_key
    })
  }
}
