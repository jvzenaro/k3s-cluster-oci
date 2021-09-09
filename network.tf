resource "oci_core_vcn" "k3s_vcn" {
  cidr_blocks    = ["10.0.0.0/16"]
  dns_label      = "k3svcn"
  compartment_id = oci_identity_compartment.k3s_compartment.compartment_id
  display_name   = "K3s Vcn"
}

resource "oci_core_internet_gateway" "k3s_vcn_internet_gateway" {
  compartment_id = oci_identity_compartment.k3s_compartment.compartment_id
  display_name   = "Internet Gateway"
  vcn_id         = oci_core_vcn.k3s_vcn.id
}

resource "oci_core_route_table" "k3s_vcn_route_table" {
  compartment_id = oci_identity_compartment.k3s_compartment.compartment_id
  vcn_id         = oci_core_vcn.k3s_vcn.id
  display_name   = "Route Table"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.k3s_vcn_internet_gateway.id
  }
}

resource "oci_core_security_list" "k3s_vcn_security_list_public" {
  compartment_id = oci_identity_compartment.k3s_compartment.compartment_id
  vcn_id         = oci_core_vcn.k3s_vcn.id
  display_name   = "Security List for Public Subnet"

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = "22"
      min = "22"
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = "80"
      min = "80"
    }
  }
  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }

}

resource "oci_core_security_list" "k3s_vcn_security_list_private" {
  compartment_id = oci_identity_compartment.k3s_compartment.compartment_id
  vcn_id         = oci_core_vcn.k3s_vcn.id
  display_name   = "Security List for Private Subnet"

  ingress_security_rules {
    protocol = "all"
    source   = "10.0.0.0/16"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
  }

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }
}

resource "oci_core_subnet" "k3s_vcn_public_subnet" {
  cidr_block        = "10.0.0.0/24"
  display_name      = "Public Subnet"
  dns_label         = "publicsubnet"
  security_list_ids = [oci_core_security_list.k3s_vcn_security_list_public.id]
  compartment_id    = oci_identity_compartment.k3s_compartment.compartment_id
  vcn_id            = oci_core_vcn.k3s_vcn.id
  route_table_id    = oci_core_route_table.k3s_vcn_route_table.id
  dhcp_options_id   = oci_core_vcn.k3s_vcn.default_dhcp_options_id
}

resource "oci_core_subnet" "k3s_vcn_private_subnet" {
  cidr_block        = "10.0.1.0/24"
  display_name      = "Private Subnet"
  dns_label         = "privatesubnet"
  security_list_ids = [oci_core_security_list.k3s_vcn_security_list_private.id]
  compartment_id    = oci_identity_compartment.k3s_compartment.compartment_id
  vcn_id            = oci_core_vcn.k3s_vcn.id
  route_table_id    = oci_core_route_table.k3s_vcn_route_table.id
  dhcp_options_id   = oci_core_vcn.k3s_vcn.default_dhcp_options_id
}
