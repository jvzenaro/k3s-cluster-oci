output "cluster_master_public_ip" {
  value = oci_core_instance.cluster-master-node01.public_ip
}

output "cluster_private_ips" {
  value = [oci_core_instance.cluster-master-node01.private_ip,
    oci_core_instance.cluster-master-node02.private_ip,
    oci_core_instance.cluster-worker-node01.private_ip,
  oci_core_instance.cluster-worker-node02.private_ip]
}

output "mysql_private_ip" {
  value = oci_core_instance.k3s-mysql.private_ip
}


output "vcn_id" {
  value = oci_core_vcn.k3s_vcn.id
}

output "compartment_id" {
  value = oci_identity_compartment.k3s_compartment.compartment_id
}
