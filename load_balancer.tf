resource "oci_load_balancer" "k3s_load_balancer" {
  #Required
  compartment_id = oci_identity_compartment.k3s_compartment.compartment_id
  display_name   = "k3s_load_balancer"
  shape          = "flexible"

  subnet_ids = [
    oci_core_subnet.k3s_vcn_public_subnet.id
  ]

  shape_details {
    #Required
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }
}

resource "oci_load_balancer_backend_set" "k3s_load_balancer_backend_set" {
  name             = "k3sLbBackendSet"
  load_balancer_id = oci_load_balancer.k3s_load_balancer.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port              = "80"
    protocol          = "HTTP"
    url_path          = "/"
    retries           = 3
    interval_ms       = 10000
    timeout_in_millis = 5000
  }
}

resource "oci_load_balancer_hostname" "k3s_load_balancer_hostname" {
  #Required
  hostname         = var.hostname
  load_balancer_id = oci_load_balancer.k3s_load_balancer.id
  name             = "hostname"
}

resource "oci_load_balancer_listener" "k3s_load_balancer_listener" {
  load_balancer_id         = oci_load_balancer.k3s_load_balancer.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.k3s_load_balancer_backend_set.name
  hostname_names           = [oci_load_balancer_hostname.k3s_load_balancer_hostname.name]
  port                     = 80
  protocol                 = "HTTP"

  connection_configuration {
    idle_timeout_in_seconds = "240"
  }
}

resource "oci_load_balancer_backend" "k3s_load_balancer_cluster_master_01" {
  #Required
  backendset_name  = oci_load_balancer_backend_set.k3s_load_balancer_backend_set.name
  ip_address       = oci_core_instance.cluster_master_node01.private_ip
  load_balancer_id = oci_load_balancer.k3s_load_balancer.id
  port             = "80"
}

resource "oci_load_balancer_backend" "k3s_load_balancer_cluster_master_02" {
  #Required
  backendset_name  = oci_load_balancer_backend_set.k3s_load_balancer_backend_set.name
  ip_address       = oci_core_instance.cluster_master_node02.private_ip
  load_balancer_id = oci_load_balancer.k3s_load_balancer.id
  port             = "80"
}

resource "oci_load_balancer_backend" "k3s_load_balancer_cluster_worker_01" {
  #Required
  backendset_name  = oci_load_balancer_backend_set.k3s_load_balancer_backend_set.name
  ip_address       = oci_core_instance.cluster_worker_node01.private_ip
  load_balancer_id = oci_load_balancer.k3s_load_balancer.id
  port             = "80"
}

resource "oci_load_balancer_backend" "k3s_load_balancer_cluster_worker_02" {
  #Required
  backendset_name  = oci_load_balancer_backend_set.k3s_load_balancer_backend_set.name
  ip_address       = oci_core_instance.cluster_worker_node02.private_ip
  load_balancer_id = oci_load_balancer.k3s_load_balancer.id
  port             = "80"
}
