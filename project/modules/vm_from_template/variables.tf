variable "allow_unverified_ssl" {
  description = "Allow unverified SSL certificates"
  type        = bool
  default     = true
}

# Infrastructure variables
variable "datacenter_name" {
  description = "Name of the datacenter"
  type        = string
}

variable "datastore_name" {
  description = "Name of the datastore"
  type        = string
}

variable "network_name" {
  description = "Name of the network"
  type        = string
}

variable "host_name" {
  description = "Name of the ESXi host"
  type        = string
}

variable "template_name" {
  description = "Name of the VM template"
  type        = string
}

# VM configuration variables
variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "vm_cpu" {
  description = "Number of CPUs for the VM"
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "Memory in MB for the VM"
  type        = number
  default     = 2048
}

variable "disk_size" {
  description = "Disk size in GB (optional, uses template size if not specified)"
  type        = number
  default     = null
}

variable "network_adapter_type" {
  description = "Network adapter type"
  type        = string
  default     = "vmxnet3"
}
