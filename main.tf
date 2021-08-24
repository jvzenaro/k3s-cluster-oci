data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = var.ad_number
}

resource "oci_identity_compartment" "k3s_compartment" {
  #Required
  compartment_id = var.tenancy_ocid
  description    = "Compartiment for Cluster of K3s"
  name           = "Cluster-K3s"
}

