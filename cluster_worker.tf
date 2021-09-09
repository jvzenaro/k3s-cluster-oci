resource "oci_core_instance" "cluster_worker_1" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = oci_identity_compartment.k3s_compartment.compartment_id
  display_name        = "cluster_worker_1"
  shape               = "VM.Standard.A1.Flex"
  shape_config {
    memory_in_gbs = 6
    ocpus         = 1
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.k3s_vcn_private_subnet.id
    display_name     = "Vnic Cluster Worker - 1"
    assign_public_ip = true
    hostname_label   = "worker1"
  }

  source_details {
    source_type = "image"
    source_id   = var.images["arm"]
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
}

resource "oci_core_instance" "cluster_worker_2" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = oci_identity_compartment.k3s_compartment.compartment_id
  display_name        = "cluster_worker_2"
  shape               = "VM.Standard.A1.Flex"
  shape_config {
    memory_in_gbs = 6
    ocpus         = 1
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.k3s_vcn_private_subnet.id
    display_name     = "Vnic Cluster Worker - 2"
    assign_public_ip = true
    hostname_label   = "worker2"
  }

  source_details {
    source_type = "image"
    source_id   = var.images["arm"]
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
}

resource "oci_core_instance" "cluster_worker_3" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = oci_identity_compartment.k3s_compartment.compartment_id
  display_name        = "cluster_worker_3"
  shape               = "VM.Standard.A1.Flex"
  shape_config {
    memory_in_gbs = 6
    ocpus         = 1
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.k3s_vcn_private_subnet.id
    display_name     = "Vnic Cluster Worker - 3"
    hostname_label   = "worker3"
    assign_public_ip = true
  }

  source_details {
    source_type = "image"
    source_id   = var.images["arm"]
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
}
