# terraform-google-gke
Terraform module for GKE with custom buckets 

To create a terraform module for gke you should specify  


source = "insert source here" #in our case ../../
cluster_name = "" # (required) please create a unique name
google_region = "" # (optional) you can specify location of your cluster us-east1, us-central1, etc. 
min_master_version = "" #(optional) you can specify min version of the master
initial_node_count = "" # (optional) how many nodes we have inittially
google_project_id = "" # (optional) please put your project id (this is optional)
cluster_node_count = "" # (optional)
cluster_version = "" # (optional) for example "1.15"
google_credentials = "" # (optional) you should put the name of the file with creadentials 

Please fill out the following arguments

name - (Required) The name of the cluster, unique within the project and location.

location - (Optional) The location (region or zone) in which the cluster master will be created, as well as the default node location. 

node_locations - (Optional)

initial_node_count - (Optional) The number of nodes to create in this cluster's default node pool. 

min_master_version - (Optional) The minimum version of the master.

node_pool - (Optional) List of node pools associated with this cluster. 

Project - (Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used.

Service_account - (Optional) The service account to be used by the Node VMs. If not specified, the "default" service account is used.


After filling out all necessary fields go to example folder and run:
```
terraform init
terraform apply
``` 