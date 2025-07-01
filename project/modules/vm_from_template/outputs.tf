output "vm_id" {
  description = "ID of the created virtual machine"
  value       = vsphere_virtual_machine.vm.id
}

output "vm_name" {
  description = "Name of the created virtual machine"
  value       = vsphere_virtual_machine.vm.name
}

output "vm_ip" {
  description = "IP address of the virtual machine"
  value       = vsphere_virtual_machine.vm.default_ip_address
}

output "vm_uuid" {
  description = "UUID of the virtual machine"
  value       = vsphere_virtual_machine.vm.uuid
}
