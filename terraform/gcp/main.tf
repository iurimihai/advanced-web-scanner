# locals {
#   zones = ["${var.region}-a"]
# }

# module "gke" {
#   source  = "terraform-google-modules/kubernetes-engine/google"
#   version = "27.0.0"

#   project_id = var.project_id

#   name   = var.name
#   region = var.region
#   zones  = local.zones

#   network    = var.network
#   subnetwork = var.subnetwork

#   ip_range_pods     = ""
#   ip_range_services = ""

#   # master_authorized_networks = [
#   #   {
#   #     cidr_block   = data.google_compute_subnetwork.subnetwork.ip_cidr_range
#   #     display_name = "VPC"
#   #   },
#   # ]

#   horizontal_pod_autoscaling = true

#   node_pools = [
#     {
#       name               = "default-node-pool"
#       machine_type       = var.machine_type
#       node_locations     = join(",", local.zones)
#       min_count          = 1
#       max_count          = 3
#       # local_ssd_count    = 10
#       # disk_type          = "pd-standard"
#       # image_type         = "COS_CONTAINERD"
#       auto_repair        = true
#       auto_upgrade       = true
#       service_account    = var.service_account
#       preemptible        = false
#       initial_node_count = 1
#     },
#   ]

#   node_pools_oauth_scopes = {
#     all = []

#     default-node-pool = [
#       "https://www.googleapis.com/auth/cloud-platform",
#     ]
#   }

#   node_pools_labels = {
#     all = {}

#     default-node-pool = {
#       default-node-pool = true
#     }
#   }

#   node_pools_metadata = {
#     all = {}

#     default-node-pool = {
#       node-pool-metadata-custom-value = "my-node-pool"
#     }
#   }

#   node_pools_taints = {
#     all = []

#     default-node-pool = [
#       {
#         key    = "default-node-pool"
#         value  = true
#         effect = "PREFER_NO_SCHEDULE"
#       },
#     ]
#   }

#   node_pools_tags = {
#     all = []

#     default-node-pool = [
#       "default-node-pool",
#     ]
#   }
# }


# # module "vpc" {
# #   source  = "terraform-google-modules/network/google"
# #   version = "~> 7.3"

# #   project_id   = var.project_id
# #   network_name = "vpc"
# # }



module "gke" {
  source = "terraform-google-modules/kubernetes-engine/google//examples/simple_autopilot_public"
  project_id = var.project_id
  region = var.region
}