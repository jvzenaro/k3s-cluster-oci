output "master_public_ip" {
  value = oci_core_instance.cluster-master-node01.public_ip
}

output "vcn_id" {
  value = oci_core_vcn.k3s_vcn.id
}

output "compartment_id" {
  value = oci_identity_compartment.k3s_compartment.compartment_id
}
