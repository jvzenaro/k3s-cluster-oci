output "cluster_public_ips" {
  value = [oci_core_instance.cluster_master.public_ip,
    oci_core_instance.cluster_worker_1.public_ip,
    oci_core_instance.cluster_worker_2.public_ip,
  oci_core_instance.cluster_worker_3.public_ip]
}

output "cluster_private_ips" {
  value = [oci_core_instance.cluster_master.private_ip,
    oci_core_instance.cluster_worker_1.private_ip,
    oci_core_instance.cluster_worker_2.private_ip,
  oci_core_instance.cluster_worker_3.private_ip]
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
