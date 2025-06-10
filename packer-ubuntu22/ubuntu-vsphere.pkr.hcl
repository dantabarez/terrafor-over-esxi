packer {
  required_plugins {
    vsphere = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}

source "vsphere-iso" "ubuntu" {
  vcenter_server      = "192.168.100.99"
  username            = "administrator@vsphere.local"
  password            = "53a7114e17DT!"
  insecure_connection = true

  datacenter     = "Datacenter"
  cluster        = "Cluster"
  datastore      = "datastore1"
  vm_name        = "ubuntu-22.04-template"
  guest_os_type  = "ubuntu64Guest"
  convert_to_template = true

  iso_paths      = ["[datastore1] iso/ubuntu-22.04.5-live-server-amd64.iso"]
  communicator   = "ssh"
  ssh_username   = "test"
  ssh_password   = "test"
  ssh_timeout    = "20m"

  boot_wait      = "5s"
  boot_command = [
    "<esc><wait>",
    "auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
    "debian-installer=en_US auto locale=en_US ",
    "hostname=ubuntu ",
    "fb=false debconf/frontend=noninteractive ",
    "<enter>"
  ]

  http_directory = "http"

  # Definir el disco en la configuración de discos
  disk_size = 20480

  # Configurar la red
  network = "VM Network"
  network_card = "vmxnet3"
}

build {
  sources = ["source.vsphere-iso.ubuntu"]
}
