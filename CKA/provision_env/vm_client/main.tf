resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = var.rg_name
  location            = var.rg_location
}

resource "azurerm_subnet" "subnet" {
  name                 = "k8s-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.128.0/24"]
}

resource "azurerm_ssh_public_key" "ssh_key_client" {
  name                = "user_public_key"
  resource_group_name = var.rg_name
  location            = var.rg_location
  public_key          = file("./assets/ssh_keys/id_rsa.pub")
}

resource "tls_private_key" "ssh_key_k8s" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

module "vms_worker_node" {
  source = "./vms_worker_node"
  resource_group_name     = var.rg_name
  resource_group_location = var.rg_location
  vms_count               = var.wk_vm_count
  ssh_public_key          = tls_private_key.ssh_key_k8s.public_key_openssh
  subnet_id               = azurerm_subnet.subnet.id
}

module "vms_cp_node" {
  source = "./vms_cp_node"
  resource_group_name     = var.rg_name
  resource_group_location = var.rg_location
  vms_count               = var.cp_vm_count
  ssh_public_key          = tls_private_key.ssh_key_k8s.public_key_openssh
  subnet_id               = azurerm_subnet.subnet.id
}

# module "vm_proxy" {
#   source = "./proxy"
#   rg_name = var.rg_name
#   rg_location = var.rg_location
#   public_key = azurerm_ssh_public_key.ssh_key_client.public_key
#   subnet_id  = azurerm_subnet.subnet.id
# }