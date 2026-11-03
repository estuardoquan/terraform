locals {
  ssh_public_key = chomp(file(pathexpand(var.ssh_public_key_file)))
  github_private_key = sensitive(file(pathexpand(var.github_ssh_key_file)))
  github_public_key  = chomp(file(pathexpand("${var.github_ssh_key_file}.pub")))
}

resource "proxmox_virtual_environment_file" "user_data" {
  for_each = var.servers

  content_type = "snippets"
  datastore_id = each.value.snippet.store
  node_name    = each.value.snippet.node

  source_raw {
    file_name = "cloud-init-${each.key}.yaml"
    data = templatefile("${path.module}/templates/user.yaml.tftpl", {
      hostname            = each.key
      username            = var.username
      nameservers         = each.value.nameservers
      ssh_public_key      = local.ssh_public_key
      github_private_key  = local.github_private_key
      github_public_key   = local.github_public_key
      nsupdate_key_secret = var.nsupdate_key_secret
    })
  }
}
