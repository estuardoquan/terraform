resource "terraform_data" "cloud_init_restart" {
  for_each = var.servers

  depends_on = [proxmox_virtual_environment_vm.alpine]

  lifecycle {
    replace_triggered_by = [proxmox_virtual_environment_file.user_data[each.key]]
  }

  provisioner "local-exec" {
    command = "ssh \
    -i ${var.ssh_key_file} \
    -l ${var.proxmox_ssh_user} \
    ${each.value.node} 'qm shutdown ${each.value.vmid} && qm start ${each.value.vmid}'"
  }
}
