module "kubernetes-engine" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "27.0.0"

  project_id = var.project

  name = var.name

  network = var.network
  subnetwork = var.subnetwork

  ip_range_pods = var.ip_range_pods
  ip_range_services = var.ip_range_services
}
