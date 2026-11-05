locals {
  github_private_key = sensitive(file(pathexpand(var.github_ssh_key_file)))
  github_public_key  = chomp(file(pathexpand("${var.github_ssh_key_file}.pub")))
  ssh_public_key = chomp(file(pathexpand("${var.ssh_key_file}.pub")))
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
      ssh_public_key      = local.ssh_public_key
      github_private_key  = local.github_private_key
      github_public_key   = local.github_public_key
      swap_size           = each.value.swap.size
      swap_max            = each.value.swap.max
      default_packages    = var.default_packages
      packages            = each.value.packages
      default_cmd         = var.default_runcmd
      cmd                 = each.value.runcmd
    })
  }
}
