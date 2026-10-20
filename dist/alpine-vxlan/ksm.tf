resource "terraform_data" "allow_ksm" {
  for_each = var.servers

  triggers_replace = [
    proxmox_virtual_environment_vm.alpine[each.key].id,
  ]

  provisioner "local-exec" {
    command = "ssh ${var.proxmox_ssh_user}@${each.value.node_name} qm set ${each.value.vmid} --allow-ksm ${each.value.ksm}"
  }
}
