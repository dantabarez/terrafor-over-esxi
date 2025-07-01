variable "vsphere_user" {
  description = "vSphere username"
  type        = string
}

variable "vsphere_password" {
  description = "vSphere password"
  type        = string
  sensitive   = true
}

variable "datastore_name" {
  description = "Name of the datastore where the VM will be deployed"
  type        = string
  default     = "datastore1"
}

variable "vsphere_server" {
  description = "vSphere server IP or FQDN"
  type        = string
}

