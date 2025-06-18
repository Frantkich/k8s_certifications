output "connections" {
  value = {
    vms = [
      for vm in azurerm_linux_virtual_machine.vms : {
        name       = vm.name
        user       = vm.admin_username
        private_ip = vm.private_ip_address
      }
    ]
  }
}