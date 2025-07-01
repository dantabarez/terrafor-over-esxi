resource "vsphere_virtual_machine" "from_ova" {
  name             = var.vm_name
  resource_pool_id = data.vsphere_resource_pool.default.id
  datastore_id     = data.vsphere_datastore.datastore.id
  host_system_id   = data.vsphere_host.host.id
  datacenter_id    = data.vsphere_datacenter.dc.id

  ovf_deploy {
    remote_ovf_url            = var.ova_path
    disk_provisioning         = "thin"
    allow_unverified_ssl_cert = true
  }

  network_interface {
    network_id = data.vsphere_network.vm_network.id
  }

  wait_for_guest_net_timeout = 0
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
