output "vm_id" {
  value = vsphere_virtual_machine.from_ova.id
}

output "vm_name" {
  value = vsphere_virtual_machine.from_ova.name
}
