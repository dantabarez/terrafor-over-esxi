output "vm_name_id" {
  description = "ID de la máquina virtual creada"
  value       = module.vm_from_ova_vm1.vm_id
}
output "vm_name" {
  description = "Nombre de la máquina virtual creada"
  value       = module.vm_from_ova_vm1.vm_name
}

output "vm_ip_address" {
  description = "Dirección IP de la máquina virtual"
  value       = module.vm_from_ova_vm1.vm_ip
}

# Output alternativo usando guest IP addresses si default_ip_address no está disponible
output "vm_all_ips" {
  description = "Todas las direcciones IP de la máquina virtual"
  value       = module.vm_from_ova_vm1.vm_guest_ip_addresses
}

# output "elasticsearch_url" {
#   description = "URL para acceder a Elasticsearch"
#   value       = can(regex("^\\d+\\.\\d+\\.\\d+\\.\\d+$", module.vm_from_ova_vm1.vm_ip)) ? "http://${module.vm_from_ova_vm1.vm_ip}:9200" : "Esperando IP de la VM..."
# }

# output "kibana_url" {
#   description = "URL para acceder a Kibana"
#   value       = can(regex("^\\d+\\.\\d+\\.\\d+\\.\\d+$", module.vm_from_ova_vm1.vm_ip)) ? "http://${module.vm_from_ova_vm1.vm_ip}:5601" : "Esperando IP de la VM..."
# }

output "elk_credentials" {
  description = "Credenciales de acceso al stack ELK"
  value = {
    elasticsearch_user = "elastic"
    elasticsearch_password = "elastic123"
    kibana_user = "elastic"
    kibana_password = "elastic123"
  }
  sensitive = true
}

# Output con instrucciones si la IP no está disponible
# output "next_steps" {
#   description = "Próximos pasos si la IP no está disponible"
#   value = can(regex("^\\d+\\.\\d+\\.\\d+\\.\\d+$", module.vm_from_ova_vm1.vm_ip)) ? "VM lista. Puedes proceder con Ansible." : "Ejecuta 'terraform refresh' para actualizar la IP de la VM"
# }