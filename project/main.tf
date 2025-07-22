terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.12.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}



module "vm_from_ova_vm1" {
  source             = "./modules/vm_from_ova"
  vm_name            = "ubuntu_noble"
  ova_path           = "C:\\Users\\claud\\Documents\\Projects\\Terraform\\Ubuntu64-bit-19.ova"
  datastore_name     = var.datastore_name
  datacenter_name    = "ha-datacenter"
  host_name          = "192.168.1.10"
  network_name       = "VM Network"
  resource_pool_name = "Resources"
  vm_ip_address      = "192.168.140.130"
  vm_netmask         = "24"
  vm_gateway         = "192.168.140.1"
}
module "vm_from_ova_vm1" {
  source             = "./modules/vm_from_ova"
  vm_name            = "ubuntu_noble"
  ova_path           = "C:\\Users\\claud\\Documents\\Projects\\Terraform\\Ubuntu64-bit-19.ova"
  datastore_name     = var.datastore_name
  datacenter_name    = "ha-datacenter"
  host_name          = "192.168.1.10"
  network_name       = "VM Network"
  resource_pool_name = "Resources"
  vm_ip_address      = "192.168.140.130"
  vm_netmask         = "24"
  vm_gateway         = "192.168.140.1"
}
module "vm_from_ova_vm1" {
  source             = "./modules/vm_from_ova"
  vm_name            = "ubuntu_noble"
  ova_path           = "C:\\Users\\claud\\Documents\\Projects\\Terraform\\Ubuntu64-bit-19.ova"
  datastore_name     = var.datastore_name
  datacenter_name    = "ha-datacenter"
  host_name          = "192.168.1.10"
  network_name       = "VM Network"
  resource_pool_name = "Resources"
  vm_ip_address      = "192.168.140.130"
  vm_netmask         = "24"
  vm_gateway         = "192.168.140.1"
}

# Ejecutar Ansible después de crear la VM
resource "null_resource" "ansible_elk_provisioning" {
  depends_on = [module.vm_from_ova_vm1]

  # Disparador para re-ejecutar cuando cambie la VM
  triggers = {
    vm_id = module.vm_from_ova_vm1.vm_id
  }

  # Esperar a que la VM esté disponible via SSH
  # provisioner "local-exec" {
  #   command = "ping -n 10 ${module.vm_from_ova_vm1.vm_ip} > nul 2>&1"
  # }

  # Actualizar el inventario de Ansible con la IP de la VM
  # provisioner "local-exec" {
  #   command = <<-EOT
  #     echo [elk_servers] > ansible\\inventory_dynamic.ini
  #     echo ${module.vm_from_ova_vm1.vm_ip} ansible_user=test ansible_ssh_pass=test ansible_become_pass=test ansible_python_interpreter=/usr/bin/python3 ansible_ssh_common_args='-o StrictHostKeyChecking=no' >> ansible\\inventory_dynamic.ini
  #   EOT
  # }

  # Ejecutar el playbook de Ansible para ELK
  # provisioner "local-exec" {
  #   command     = "ansible-playbook -i ansible\\inventory_dynamic.ini ansible\\vm1\\vm_elk.yml"
  #   working_dir = path.module
  # }
}

# module "vm_from_template_vm1" {
#   source               = "./modules/vm_from_template"
#   vm_name              = "ubuntu_template_vm1"
#   template_name        = "ubuntu-template"
#   datacenter_name      = "ha-datacenter"
#   datastore_name       = var.datastore_name
#   host_name            = "192.168.1.10"
#   network_name         = "VM Network"
#   vm_cpu               = 2
#   vm_memory            = 4096
#   disk_size            = 50
#   network_adapter_type = "vmxnet3"
#   allow_unverified_ssl = true
# }


