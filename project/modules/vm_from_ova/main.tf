resource "vsphere_virtual_machine" "from_ova" {
  name             = var.vm_name
  resource_pool_id = data.vsphere_resource_pool.default.id
  datastore_id     = data.vsphere_datastore.datastore.id
  host_system_id   = data.vsphere_host.host.id
  datacenter_id    = data.vsphere_datacenter.dc.id
  //hardware_version = 19

  ovf_deploy {
    //remote_ovf_url            = var.ova_path
    local_ovf_path            = var.ova_path
    disk_provisioning         = "thin"
    allow_unverified_ssl_cert = true
  }

  network_interface {
    network_id   = data.vsphere_network.vm_network.id
    adapter_type = "vmxnet3"
  }

  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0

  # Configuración adicional para asegurar que VMware Tools funcione
  run_tools_scripts_after_power_on        = true
  run_tools_scripts_after_resume          = true
  run_tools_scripts_before_guest_shutdown = true
}


# Configuración de IP estática mediante SSH (requiere que la VM tenga SSH habilitado)
resource "null_resource" "configure_static_ip" {
  depends_on = [vsphere_virtual_machine.from_ova]

  # Esperar a que la VM esté disponible
  provisioner "local-exec" {
    command     = "Start-Sleep -Seconds 30"
    interpreter = ["PowerShell", "-Command"]
  }

  # Conexión SSH para configurar la IP
  connection {
    type     = "ssh"
    host     = vsphere_virtual_machine.from_ova.default_ip_address # IP temporal (DHCP)
    user     = "claudio"                                           # Usuario SSH de la OVA
    password = "claudio"                                           # Contraseña SSH de la OVA
  }

  # Comandos para configurar IP estática (ejemplo para Ubuntu)
  provisioner "remote-exec" {
    inline = [
      "sudo nmcli con mod 'System ens192' ipv4.addresses ${var.vm_ip_address}/${var.vm_netmask}",
      "sudo nmcli con mod 'System ens192' ipv4.gateway ${var.vm_gateway}",
      "sudo nmcli con mod 'System ens192' ipv4.dns '${join(" ", var.vm_dns_servers)}'",
      "sudo nmcli con mod 'System ens192' ipv4.method manual",
      "sudo nmcli con down 'System ens192' && sudo nmcli con up 'System ens192'",
      "sudo hostnamectl set-hostname ${var.vm_name}"
    ]
  }
}

data "vsphere_datacenter" "dc" {
  name = var.datacenter_name
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_host" "host" {
  name          = var.host_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "vm_network" {
  name          = var.network_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "default" {
  name          = var.resource_pool_name
  datacenter_id = data.vsphere_datacenter.dc.id
}
