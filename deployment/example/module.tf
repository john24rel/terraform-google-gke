module "gke_cluster" {
    source  = "../../"
    cluster_name = "fuchicorp-cluster"  # name of your cluster
    google_region = "us-west1-b"  # region you wanna deploy to
    google_project_id =  "pure-imagery-318217"  #your project id
    cluster_node_count = "3" 
    cluster_version = "1.18"
    google_credentials = "./fuchicorp-service-account.json" # service account
    image_type        = "COS"
    disk_size_in_gb   = "50"
    # machine_type      = "n1-standard-2"
    auto_repair     = true
    auto_upgrade    = false
    labels            = {
        "label" = "fuchicorp-project"
    }
}
