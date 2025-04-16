terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }

  backend "s3" {
    bucket = "terraform-proxmox-k8s"
    key    = "nodes/virtual-machines.tfstate"
    region = "eu-central-1"
  }
}

provider "proxmox" {
    pm_tls_insecure = true
    pm_api_url = var.proxmox_api_url
    pm_user = var.proxmox_user
    pm_password = var.proxmox_password
    pm_otp = var.proxmox_otp

    pm_debug = var.proxmox_debug
}
