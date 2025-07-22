variable "vm_name" {
  description = "Nombre de la máquina virtual"
  type        = string
}

variable "ova_path" {
  description = "Ruta del archivo OVA a importar"
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

# Nuevas variables para configuración de red
variable "vm_ip_address" {
  description = "Dirección IP estática para la VM"
  type        = string
}

variable "vm_netmask" {
  description = "Máscara de red para la VM"
  type        = string
  default     = "24"
}

variable "vm_gateway" {
  description = "Gateway para la VM"
  type        = string
}

variable "vm_dns_servers" {
  description = "Servidores DNS para la VM"
  type        = list(string)
  default     = ["8.8.8.8", "8.8.4.4"]
}