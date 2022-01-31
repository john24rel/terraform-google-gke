module "gke_cluster" {
    source  = "../../"
    cluster_name = "fuchicorp-cluster"  # name of your cluster
    google_region = "us-central1-c"  # region you wanna deploy to
    google_project_id =  "fsadykov-project"  #your project id
    cluster_node_count = "2" 
    min_desired_count = "2"
    max_desired_count = "5"
    cluster_version = "1.19"
    google_credentials = "./google-credentials.json" # service account
    image_type        = "COS"
    disk_size_in_gb   = "10"
    machine_type      = "n1-standard-2"
    auto_repair     = true
    auto_upgrade    = false
    gce_ssh_user    = "default-user"
    labels            = {
        "label" = "fuchicorp-project"
    }
}
