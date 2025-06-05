provider "vsphere" {
  user           = "root"
  password       = "53a7114e17!"
  vsphere_server = "192.168.100.92"
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "ha-datacenter"
}

data "vsphere_datastore" "datastore" {
  name          = "datastore1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_host" "host" {
  name          = "your-esxi-hostname" # ← cambia esto al hostname real del ESXi (no IP)
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "ubuntu_vm" {
  name             = "ubuntu-vm"
  resource_pool_id = data.vsphere_host.host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 2048
  guest_id = "ubuntu64Guest"

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    size             = 20
    eagerly_scrub    = false
    thin_provisioned = true
  }

  cdrom {
    datastore_id = data.vsphere_datastore.datastore.id
    path         = "ubuntu-22.04.5-live-server-amd64.iso"  # ← Asegúrate de que este ISO esté en el datastore
  }


  firmware = "bios"
}