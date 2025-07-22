output "vm_id" {
  value = vsphere_virtual_machine.from_ova.id
}

output "vm_name" {
  value = vsphere_virtual_machine.from_ova.name
}

output "vm_ip" {
  value       = vsphere_virtual_machine.from_ova.default_ip_address != null ? vsphere_virtual_machine.from_ova.default_ip_address : "IP no disponible aún"
  description = "IP address of the virtual machine"
}

output "vm_guest_ip_addresses" {
  value       = vsphere_virtual_machine.from_ova.guest_ip_addresses != null ? vsphere_virtual_machine.from_ova.guest_ip_addresses : []
  description = "All IP addresses of the virtual machine"
}
