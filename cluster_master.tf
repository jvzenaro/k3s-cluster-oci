

resource "oci_core_instance" "cluster-master-node01" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = oci_identity_compartment.k3s_compartment.compartment_id
  display_name        = "cluster-master-node01"
  shape               = "VM.Standard.A1.Flex"
  shape_config {
    memory_in_gbs = 4
    ocpus         = 1
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.k3s_vcn_public_subnet.id
    display_name     = "Vnic Cluster Master Node 01"
    assign_public_ip = true
    hostname_label   = "cluster-master-1"
  }

  source_details {
    source_type = "image"
    source_id   = var.images["arm"]
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
}

resource "oci_core_instance" "cluster-master-node02" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = oci_identity_compartment.k3s_compartment.compartment_id
  display_name        = "cluster-master-node02"
  shape               = "VM.Standard.A1.Flex"
  shape_config {
    memory_in_gbs = 4
    ocpus         = 1
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.k3s_vcn_private_subnet.id
    display_name     = "Vnic Cluster Master Node 02"
    hostname_label   = "cluster-master-2"
    assign_public_ip = false
  }

  source_details {
    source_type = "image"
    source_id   = var.images["arm"]
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
}
