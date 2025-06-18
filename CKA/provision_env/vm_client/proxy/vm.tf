resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "proxy-vm"
  resource_group_name             = var.rg_name
  location                        = var.rg_location	
  size                            = "Standard_DS1_v2"
  admin_username                  = "adminuser"
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.nic.id]
  
  admin_ssh_key {
    username   = "adminuser"
    public_key = var.public_key
  }

  os_disk {
    name                 = "proxy-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  custom_data = base64encode(<<-EOF
#!/bin/bash
apt-get update
EOF
  )
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "vm_shutdown" {
  virtual_machine_id = azurerm_linux_virtual_machine.vm.id
  location           = var.rg_location
  enabled            = true

  daily_recurrence_time = "2000"
  timezone              = "Central Europe Standard Time"

  notification_settings {
    enabled = false
  }
}
