output "servers" {
  value = {
    for k, v in var.servers : k => {
      vmid    = v.vmid
      node    = v.node_name
      address = v.address
    }
  }
}

output "bootstrap_node" {
  value = local.bootstrap_address
}

output "k3s_token" {
  value     = local.k3s_token
  sensitive = true
}

output "pi_join_command" {
  value = "curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=<k3s-version> K3S_URL=https://${local.bootstrap_address}:6443 K3S_TOKEN=<token> sh -s - server"
}
