locals {
  ssh_public_key = chomp(file(pathexpand(var.ssh_public_key_file)))
}

resource "proxmox_virtual_environment_file" "user_data" {
  for_each = var.servers

  content_type = "snippets"
  datastore_id = var.snippet_datastore
  node_name    = var.snippet_node

  source_raw {
    file_name = "cloud-init-${each.key}.yaml"
    data = templatefile("${path.module}/templates/user.yaml.tftpl", {
      hostname          = each.key
      username          = var.username
      nameservers       = var.nameservers
      ssh_public_key    = local.ssh_public_key
    })
  }
}
