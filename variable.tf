
variable "google_project_id" {
  description = "account project id"
}
variable "google_region" {
  description = "location of your cluster"
}
variable "cluster_version" {
  description = "version of the cluster"
}
variable "cluster_node_count" {
  description = "desired node count"
}
variable "google_credentials" {
  description = "your google servise account"
}
variable "cluster_network" {
  default = "default"
}
variable "cluster_name" {
  description = "unique name of the cluster"
}

variable "subnetwork" {
  default = "default"
}

variable "machine_type" {
  default = "n1-standard-2"
}
variable  "min_master_version" {
  description = "version of your mater"
}

variable  "initial_node_count" {
  description = "initial node count"
}







