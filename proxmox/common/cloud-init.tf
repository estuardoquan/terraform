locals {
  github_private_key = sensitive(file(pathexpand(var.github_ssh_key_file)))
  github_public_key  = chomp(file(pathexpand("${var.github_ssh_key_file}.pub")))
  ssh_public_key = chomp(file(pathexpand("${var.ssh_key_file}.pub")))
  disks_bootcmd = flatten([
    for k, v in each.value.disks : [
      "d=/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-${k}",
      "vgs vg_${k} >/dev/null 2>&1 || { pvcreate -y \"$d\" && vgcreate vg_${k} \"$d\"; }",
      "lvs vg_${k}/lv_${k} >/dev/null 2>&1 || lvcreate -y -n lv_${k} -l 100%FREE vg_${k}",
      "blkid -L ${k} >/dev/null || mkfs.ext4 -L ${k} /dev/vg_${k}/lv_${k}",
    ]
  ])
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
      default_packages    = var.default_packages
      default_runcmd      = var.default_runcmd
      default_bootcmd     = var.default_bootcmd
      bootcmd             = each.value.bootcmd
      packages            = each.value.packages
      runcmd              = each.value.runcmd
      ssh_public_key      = local.ssh_public_key
      github_private_key  = local.github_private_key
      github_public_key   = local.github_public_key
    })
  }
}
