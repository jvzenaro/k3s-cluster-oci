resource "local_file" "hosts-ini" {
  content = templatefile("${path.module}/templates/hosts.tpl",
    {
      master_ips = [oci_core_instance.cluster_master_node01.public_ip, oci_core_instance.cluster_master_node02.public_ip],
      worker_ips = [oci_core_instance.cluster_worker_node01.public_ip, oci_core_instance.cluster_worker_node02.public_ip]
    }
  )
  filename = "${path.module}/provision/inventory/hosts.ini"
}
