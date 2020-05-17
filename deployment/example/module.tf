module "gke_cluster" {
    source = "../../"
    cluster_name = "cluster-gke"
    google_region = "us-central1"
    min_master_version = "1"
    initial_node_count = "1"
    google_project_id = "" # project name here
    cluster_node_count = "2"
    cluster_version = "1.15"
    google_credentials = "/.fuchicorp-service-account.json" # service account 
}
