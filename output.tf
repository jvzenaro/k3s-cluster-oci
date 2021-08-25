output "cluster_public_ips" {
  value = [oci_core_instance.cluster_master_node01.public_ip,
    oci_core_instance.cluster_master_node02.public_ip,
    oci_core_instance.cluster_worker_node01.public_ip,
  oci_core_instance.cluster_worker_node02.public_ip]
}

output "cluster_private_ips" {
  value = [oci_core_instance.cluster_master_node01.private_ip,
    oci_core_instance.cluster_master_node02.private_ip,
    oci_core_instance.cluster_worker_node01.private_ip,
  oci_core_instance.cluster_worker_node02.private_ip]
}

output "mysql_private_ip" {
  value = oci_core_instance.k3s_mysql.private_ip
}


output "vcn_id" {
  value = oci_core_vcn.k3s_vcn.id
}

output "compartment_id" {
  value = oci_identity_compartment.k3s_compartment.compartment_id
}
