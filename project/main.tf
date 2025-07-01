terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.12.0"
    }
  }
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

# module "vm_desde_ova_vm1" {
#   source             = "./modules/vm_from_ova"
#   vm_name            = "ubuntu_noble"
#   ova_path           = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.ova"
#   datastore_name     = var.datastore_name
#   datacenter_name    = "ha-datacenter"
#   host_name          = "192.168.1.10"
#   network_name       = "VM Network"
#   resource_pool_name = "Resources"
# }

module "vm_from_template_vm1" {
  source               = "./modules/vm_from_template"
  vm_name              = "ubuntu_template_vm1"
  template_name        = "ubuntu-template"
  datacenter_name      = "ha-datacenter"
  datastore_name       = var.datastore_name
  host_name            = "192.168.1.10"
  network_name         = "VM Network"
  vm_cpu               = 2
  vm_memory            = 4096
  disk_size            = 50
  network_adapter_type = "vmxnet3"
  allow_unverified_ssl = true
}


