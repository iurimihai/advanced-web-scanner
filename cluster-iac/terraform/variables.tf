variable "bucket_region" {
  default = "eu-central-1"
}

variable "proxmox_api_url" {}
variable "proxmox_user" {}
variable "proxmox_password" {}
variable "proxmox_otp" {}
variable "proxmox_debug" {
  default = false
}

variable "qemu_template" {}
variable "pool" {}
variable "target_node" {}

variable "ssh_file_path" {}
variable "ciuser" {}
variable "cipassword" {}

variable "bastion" {
  type = object({
    cores  = number
    sockets = number
    memory = number
    disk   = number
    ip     = any
  })
}

variable "controllers" {
  type = list(object({
    cores  = number
    sockets = number
    memory = number
    disk   = number
    ip     = string
  }))
}

variable "workers" {
  type = list(object({
    cores  = number
    sockets = number
    memory = number
    disk   = number
    ip     = string
  }))
}
