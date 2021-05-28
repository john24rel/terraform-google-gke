data "google_container_engine_versions" "cluster_version" {
  location       = "${var.google_region}"
  version_prefix = "${var.cluster_version}"
  project        = "${var.google_project_id}"

  
}
output "cluster_version" {
  value = "${data.google_container_engine_versions.cluster_version.latest_node_version}"
}

provider "google" {
  credentials = "${file("${var.google_credentials}")}" #GOOGLE_CREDENTIALS to the path of a file containing the credential JSON
  project     = "${var.google_project_id}"
}

resource "google_container_cluster" "create" {
  min_master_version = "${data.google_container_engine_versions.cluster_version.latest_node_version}"
  name               = "${var.cluster_name}"
  network            = "${var.cluster_network}"
  subnetwork         = "${var.subnetwork}"
  location           = "${var.google_region}"
  project            = "${var.google_project_id}"
 
 node_pool {
    name               = "${var.node_pool}"
    version            = "${var.cluster_version}"
    initial_node_count = "${var.cluster_node_count}"
    management {
    auto_repair        = "${var.auto_repair}"
    auto_upgrade       = "${var.auto_upgrade}"
    }
 node_config {
    image_type       = "${var.image_type}"
    disk_size_gb     = "${var.disk_size_in_gb}"
    preemptible      = "${var.preemptible_nodes}"
    machine_type     = "${var.machine_type}"
    labels           = "${var.labels}"
     
 
    }
  }
}
