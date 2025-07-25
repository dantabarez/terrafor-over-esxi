provider "vsphere" {
  user                 = "administrator@vsphere.local"
  password             = "53a7114e17DT!"
  vsphere_server       = "192.168.100.99"
  allow_unverified_ssl = true
}

# Datacenter
data "vsphere_datacenter" "dc" {
  name = "Datacenter"
}

# Datastore
data "vsphere_datastore" "datastore" {
  name          = "datastore1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Network
data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Host
data "vsphere_host" "host" {
  name          = "192.168.100.92"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Template Ubuntu
data "vsphere_virtual_machine" "template" {
  name          = "ubuntu-template"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Template RedHat
data "vsphere_virtual_machine" "redhat_template" {
  name          = "redhat-template"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Virtual Machine Ubuntu
resource "vsphere_virtual_machine" "ubuntu_vm" {
  name             = "ubuntu-web-server"
  resource_pool_id = data.vsphere_host.host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 2048
  guest_id = data.vsphere_virtual_machine.template.guest_id

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks[0].size
    thin_provisioned = data.vsphere_virtual_machine.template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }

  firmware = data.vsphere_virtual_machine.template.firmware

  customize {
    linux_options {
      host_name = "ubuntu-web-server"
      domain    = "local"
    }
    network_interface {
      ipv4_address = "192.168.100.111"
      ipv4_netmask = 24
    }
    ipv4_gateway = "192.168.100.1"
  }
}

# Virtual Machine Frontend (RedHat)
resource "vsphere_virtual_machine" "frontend_vm" {
  name             = "frontend"
  resource_pool_id = data.vsphere_host.host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 2048
  guest_id = data.vsphere_virtual_machine.redhat_template.guest_id

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.redhat_template.disks[0].size
    thin_provisioned = data.vsphere_virtual_machine.redhat_template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.redhat_template.id
  }

  firmware = data.vsphere_virtual_machine.redhat_template.firmware

  customize {
    linux_options {
      host_name = "frontend"
      domain    = "local"
    }
    network_interface {
      ipv4_address = "192.168.100.112"
      ipv4_netmask = 24
    }
    ipv4_gateway = "192.168.100.1"
  }
}

# Virtual Machine Backend (RedHat)
resource "vsphere_virtual_machine" "backend_vm" {
  name             = "backend"
  resource_pool_id = data.vsphere_host.host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 2048
  guest_id = data.vsphere_virtual_machine.redhat_template.guest_id

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.redhat_template.disks[0].size
    thin_provisioned = data.vsphere_virtual_machine.redhat_template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.redhat_template.id
  }

  firmware = data.vsphere_virtual_machine.redhat_template.firmware

  customize {
    linux_options {
      host_name = "backend"
      domain    = "local"
    }
    network_interface {
      ipv4_address = "192.168.100.113"
      ipv4_netmask = 24
    }
    ipv4_gateway = "192.168.100.1"
  }
}
