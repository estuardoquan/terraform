resource "random_password" "k3s_token" {
  length  = 48
  special = false
}

locals {
  k3s_token = var.k3s_token != "" ? var.k3s_token : random_password.k3s_token.result

  bootstrap_name    = one([for k, v in var.servers : k if v.bootstrap])
  bootstrap_address = one([for k, v in var.servers : v.address if v.bootstrap])

  ssh_public_key = chomp(file(pathexpand(var.ssh_public_key_file)))
}

resource "proxmox_virtual_environment_file" "user_data" {
  for_each = var.servers

  content_type = "snippets"
  datastore_id = var.snippet_datastore
  node_name    = var.snippet_node

  source_raw {
    file_name = "cloud-init-${each.key}.yaml"
    data = templatefile("${path.module}/templates/user-data.yaml.tftpl", {
      hostname          = each.key
      username          = var.username
      ssh_public_key    = local.ssh_public_key
      k3s_token         = local.k3s_token
      bootstrap         = each.value.bootstrap
      bootstrap_address = local.bootstrap_address
      tls_sans          = [for s in var.servers : s.address]
    })
  }
}
