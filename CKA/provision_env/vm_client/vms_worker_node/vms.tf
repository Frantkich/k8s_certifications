resource "azurerm_linux_virtual_machine" "vms" {
  count                           = var.vms_count
  name                            = "wk-vm-${count.index}"
  resource_group_name             = var.resource_group_name
  location                        = var.resource_group_location	
  size                            = "Standard_DS2_v2"
  admin_username                  = "adminuser"
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.nic[count.index].id]

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.ssh_public_key
  }

  os_disk {
    name                 = "wk-osdisk-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  custom_data = filebase64("./assets/scripts/install-k8s.sh")
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "vms_shutdown" {
  count              = var.vms_count
  virtual_machine_id = azurerm_linux_virtual_machine.vms[count.index].id
  location           = var.resource_group_location
  enabled            = true

  daily_recurrence_time = "2000"
  timezone              = "Central Europe Standard Time"

  notification_settings {
    enabled = false
  }
}