resource "oci_core_instance" "k3s_mysql" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = oci_identity_compartment.k3s_compartment.compartment_id
  display_name        = "k3s_mysql"
  shape               = "VM.Standard.E2.1.Micro"
  shape_config {
    memory_in_gbs = 1
    ocpus         = 1
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.k3s_vcn_private_subnet.id
    display_name     = "Vnic Mysql"
    assign_public_ip = false
    hostname_label   = "k3s_mysql"
  }

  source_details {
    source_type = "image"
    source_id   = var.images["amd"]
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
}
