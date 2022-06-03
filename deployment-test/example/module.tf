module "gke_cluster" {
  source             = "../../"
  cluster_name       = "fuchicorp-cluster"         # name of your cluster
  google_region      = "us-central1-c"             # region you wanna deploy to
  google_project_id  = "amazing-smile-350817"          #your project id
  cluster_node_count = "3"
  min_desired_count  = "3"
  max_desired_count  = "5"
  on_demand_node_count = "1"
  cluster_version    = "1.21"
  google_credentials = "~/google-credentials.json" # service account
  image_type         = "COS"
  disk_size_in_gb    = "10"
  machine_type       = "n1-standard-2"
  auto_repair        = false
  auto_upgrade       = false
  gce_ssh_user       = "default-user"
  spot_instance      = "true"
  labels = {
    "label" = "fuchicorp-project"
  }
}
# It maybe the set env script 
# It maybe the problem with versioning the provider
# Maybe the beta resources can not be used with stable providers resources 
# 