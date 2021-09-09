resource "local_file" "hosts_ini" {
  content = templatefile("${path.module}/templates/hosts.ini.tpl",
    {
      master_ips = [oci_core_instance.cluster_master.public_ip],
      worker_ips = [oci_core_instance.cluster_worker_1.public_ip, oci_core_instance.cluster_worker_2.public_ip, oci_core_instance.cluster_worker_3.public_ip],
    }
  )
  filename = "${path.module}/provision/inventory/hosts.ini"
}

data "local_file" "provision_playbooks" {
  filename = "${path.module}/provision/playbooks/main.yml"
}

resource "null_resource" "k3s_deploy" {
  depends_on = [
    local_file.hosts_ini
  ]
  triggers = data.local_file.provision_playbooks

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.user_ssh} --private-key ${var.private_key_path} -i '${path.module}/provision/inventory/hosts.ini' ${path.module}/provision/playbooks/main.yml"
  }

}
