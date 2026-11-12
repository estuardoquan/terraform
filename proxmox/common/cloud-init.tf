locals {
  github_private_key = sensitive(file(pathexpand(var.github_ssh_key_file)))
  github_public_key  = chomp(file(pathexpand("${var.github_ssh_key_file}.pub")))
  ssh_public_key = chomp(file(pathexpand("${var.ssh_key_file}.pub")))
  disk_bootcmd = {
    for name, server in var.servers : name => [
      for k, v in server.disks :
      "/usr/local/sbin/lvm-bootcmd.sh ${k} ${v.lvm.vg} ${join(" ", [for lv, o in v.lvm.lv : "${lv}=${o.size}"])}"
    ]
  }
  disk_mounts = {
    for name, server in var.servers : name => concat([
      for k, v in server.disks : [
        for lv, o in v.lvm.lv : ["/dev/${v.lvm.vg}/${lv}", o.mount, "ext4", "defaults,nofail", "0", "2"] if o.mount != null
      ]
    ]...)
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
      swap                = each.value.swap_size
      mounts              = local.disk_mounts[each.key]
      bootcmd             = concat(local.disk_bootcmd[each.key], each.value.bootcmd)
      packages            = concat(var.default_packages, each.value.packages)
      runcmd              = each.value.runcmd
      ssh_public_key      = local.ssh_public_key
      github_private_key  = local.github_private_key
      github_public_key   = local.github_public_key
    })
  }
}
