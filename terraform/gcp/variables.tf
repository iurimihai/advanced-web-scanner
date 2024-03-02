variable "region" {
  type    = string
  default = "europe-west3"
}

# variable "zone" {
#   type    = string
#   default = "us-east1"
# }

variable "project_id" {
  type    = string
  default = "strange-oxide-393506"
}

variable "network" {
  type    = string
  default = "default"
}

variable "subnetwork" {
  type    = string
  default = "default"
}

variable "ip_range_pods" {
  type    = string
  default = "ip-range-pods"
}

variable "ip_range_services" {
  type    = string
  default = "ip-range-services"
}

variable "name" {
  type    = string
  default = "mgmt-cluster"
}

variable "service_account" {
  type    = string
  default = "terraform-gke@strange-oxide-393506.iam.gserviceaccount.com"
}

variable "machine_type" {
  type = string
  default = "e2-highmem-2"
}
