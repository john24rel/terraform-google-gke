variable "google_project_id" {
  description = "- (Required)  Google account project id."
}

variable "google_region" {
  type        = string
  description = "- (Required) Google region where the cluster will be deployed."
}

variable "cluster_version" {
  type        = string
  description = "- (Required) Version of the cluster."
}

variable "cluster_node_count" {
  type        = string
  description = "- (Required) Number of nodes for the cluster."
}

variable "initial_node_count" {
  type        = string
  description = "- (Required) Number of default nodes for the cluster."
  default     = 1
}

variable "min_desired_count" {
  type        = string
  description = "- (Required) Number of minimum desired nodes for the cluster."
}

variable "max_desired_count" {
  type        = string
  description = "- (Required) Number of maximum desired nodes for the cluster."
}

variable "google_credentials" {
  type        = string
  description = "- (Required) your google service account `example.json`"
}

variable "cluster_network" {
  type        = string
  default     = "default"
  description = "- (Optional) The name or self_link of the Google Compute Engine network to which the cluster is connected. For Shared VPC, set this to the self link of the shared network."
}

variable "cluster_name" {
  type        = string
  description = "- (Required) The name of the cluster, unique within the project and location."
}

variable "subnetwork" {
  type        = string
  default     = "default"
  description = "- (Optional) The name or self_link of the Google Compute Engine subnetwork in which the cluster's instances are launched."
}

variable "machine_type" {
  type        = string
  default     = "n1-standard-2"
  description = "- (Optional) The name of a Google Compute Engine machine type. Defaults to n1-standard-1. "
}

variable "labels" {
  description = "- (Optional) Key Value Pairs of Labels to add to the nodes in the pool"
  type        = map

  default = {
    labels = "fuchicorp-project"
  }
}

variable "disk_size_in_gb" {
  description = "- (Optional) Disk size, in GB, for the nodes in the pool."
  default     = "10"
}

variable "image_type" {
  default     = "COS"
  description = "image type"
}

variable "auto_repair" {
  description = "- (Optional) Whether the nodes will be automatically repaired"
  default     = true
}

variable "auto_upgrade" {
  description = "- (Optional) Whether the nodes will be automatically upgraded"
  default     = false
}

variable "node_version" {
  description = "- (Optional) The name of the GKE cluster to bind this node pool."
  default     = "1.17"
}

variable "min_master_version" {
  description = "- (Optional) The kubernetes version for the nodes in the pool. This should match the Kubernetes version of the GKE cluster."
  default     = "1.17"
}

variable "preemptible_nodes" {
  description = "- (Optional) Whether to use preemptible nodes"
  default     = false
}

variable "node_pool" {
  description = "- (Optional) Name of node pool"
  default     = "default-pool"
}

variable "gce_ssh_user" {
  description = "- (Optional) ssh user"
  default     = "default-user"
}

variable "gce_ssh_pub_key_file" {
  description = "- (Optional) ssh pub key file"
  default     = "~/.ssh/id_rsa.pub"
}

variable "spot_instance" {
  description = "- (Optional) optional for spot instances"
  default     = "true"
}

variable "enable_private_nodes" {
  description = "- (Optional) Indicates that the cluster's nodes do not have external IP addresses."
  default     = "false"
}

variable "enable_private_endpoint" {
  description = "- (Optional) Enables the private cluster feature, creating a private endpoint on the cluster. In a private cluster, nodes only have RFC 1918 private addresses and communicate with the master's private endpoint via private networking."
  default     = "false"
}

variable "master_ipv4_cidr_block" {
  description = "- (Required) Specifies an internal IP address range for the control plane. This setting is permanent for this cluster and must be unique within the VPC."
  default = "172.16.0.16/28"
}

variable "gcloud_region" {
  type        = string
  description = "-  Region where the router resides. Cloud NAT region."
}

variable "firewall_name" {
  type        = string
  description = "- (Required) Firewall name. Provided by the client when the resource is created. The name must be 1-63 characters long, and comply with RFC1035." 
  default = "allow-ssh"
}

variable "router_name" {
  type        = string
  description = "- (Required) Cloud NAT router name. Provided by the client when the resource is created. The name must be 1-63 characters long, and comply with RFC1035." 
  default = "nat-router"
}

variable "cloud_nat_name" {
  type        = string
  description = "- (Required) Name of the Cloud NAT. Provided by the client when the resource is created. The name must be 1-63 characters long, and comply with RFC1035." 
  default = "nat-config"
}

variable "source_subnetwork_ip_ranges_to_nat" {
  description = "- (Required) NAT should be configured per Subnetwork.If ALL_SUBNETWORKS_ALL_IP_RANGES, all of the IP ranges in every Subnetwork are allowed to Nat."
  default = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

