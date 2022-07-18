data "google_container_engine_versions" "cluster_version" {
  location       = var.google_region
  version_prefix = var.cluster_version
  project        = var.google_project_id
}

output "cluster_version" {
  value = data.google_container_engine_versions.cluster_version.latest_node_version
}

provider "google" {
  credentials = file(var.google_credentials) #GOOGLE_CREDENTIALS to the path of a file containing the credential JSON
  project     = var.google_project_id
  version     = "4.23.0"
}

provider "google-beta" {
  credentials = file(var.google_credentials) #GOOGLE_CREDENTIALS to the path of a file containing the credential JSON
  project     = var.google_project_id
  version     = "4.4.0"
}


resource "google_container_cluster" "create" {
  provider                 = google-beta
  min_master_version       = data.google_container_engine_versions.cluster_version.latest_node_version
  node_version             = data.google_container_engine_versions.cluster_version.latest_node_version
  name                     = var.cluster_name
  network                  = var.cluster_network
  subnetwork               = var.subnetwork
  location                 = var.google_region
  project                  = var.google_project_id
  initial_node_count       = var.initial_node_count

  private_cluster_config {
    enable_private_nodes   = var.enable_private_nodes
    master_ipv4_cidr_block = var.master_ipv4_cidr_block
    enable_private_endpoint= var.enable_private_endpoint
  }

  ip_allocation_policy {}
}

# [START vpc_firewall_nat_gke]
resource "google_compute_firewall" "rules" {
  project = var.google_project_id
  name    = var.firewall_name 
  network = var.cluster_network
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
# [END vpc_firewall_nat_gke]      


# [START cloudnat_router_nat_gke]
resource "google_compute_router" "router" {
  project = var.google_project_id
  name    = var.router_name
  network = var.cluster_network
  region  = var.gcloud_region
}
# [END cloudnat_router_nat_gke]

# [START cloudnat_nat_gke]
module "cloud-nat" {
  source                             = "terraform-google-modules/cloud-nat/google"
  version                            = "~> 2.2.1"
  project_id                         = var.google_project_id
  region                             = var.gcloud_region
  router                             = google_compute_router.router.name
  name                               = var.cloud_nat_name 
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat
}
# [END cloudnat_nat_gke]

resource "google_container_node_pool" "spot_nodes" {
    name               = "spot-nodes"
    node_count         = var.cluster_node_count
    cluster            = google_container_cluster.create.id
    provider           = google-beta

    management {
      auto_repair  = var.auto_repair
      auto_upgrade = var.auto_upgrade
    }

    autoscaling {
      min_node_count = var.min_desired_count
      max_node_count = var.max_desired_count
    }

    node_config {
      image_type   = var.image_type
      disk_size_gb = var.disk_size_in_gb
      preemptible  = var.preemptible_nodes
      machine_type = var.machine_type
      labels       = var.labels
      spot         = var.spot_instance

      metadata = {
        ssh-keys                 = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
        disable-legacy-endpoints = true
      }
    } 
  } 
  
// # [START vpc_firewall_nat_gke]
// resource "google_compute_firewall" "rules" {
//   project = var.google_project_id
//   name    = "allow-ssh"
//   network = var.cluster_network
//   allow {
//     protocol = "tcp"
//     ports    = ["22"]
//   }
//   source_ranges = ["35.235.240.0/20"]
// }
// # [END vpc_firewall_nat_gke]      


// # [START cloudnat_router_nat_gke]
// resource "google_compute_router" "router" {
//   project = var.google_project_id
//   name    = "nat-router"
//   network = var.cluster_network
//   region  = "us-west1"
// }
// # [END cloudnat_router_nat_gke]

// # [START cloudnat_nat_gke]
// module "cloud-nat" {
//   source                             = "terraform-google-modules/cloud-nat/google"
//   version                            = "~> 2.2.1"
//   project_id                         = var.google_project_id
//   region                             = "us-west1"
//   router                             = google_compute_router.router.name
//   name                               = "nat-config"
//   source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
// }
// # [END cloudnat_nat_gke]




