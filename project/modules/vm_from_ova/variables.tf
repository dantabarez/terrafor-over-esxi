variable "vm_name" {
  description = "Nombre de la máquina virtual"
  type        = string
}

variable "ova_path" {
  description = "Ruta HTTP/S del archivo OVA a importar"
  type        = string
}

variable "datacenter_name" {
  default     = "ha-datacenter"
  description = "Nombre del datacenter"
  type        = string
}

variable "datastore_name" {
  description = "Nombre del datastore donde se desplegará la VM"
  type        = string
}

variable "host_name" {
  description = "Nombre o IP del host ESXi"
  type        = string
}

variable "network_name" {
  default     = "VM Network"
  description = "Nombre de la red virtual"
  type        = string
}

variable "resource_pool_name" {
  default     = "Resources"
  description = "Nombre del resource pool"
  type        = string
}
