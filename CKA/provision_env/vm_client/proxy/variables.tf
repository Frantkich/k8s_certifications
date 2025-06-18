variable "rg_location" {
  type        = string
  description = "The location/region where the resource group will be created."  
}

variable "rg_name" {
  type        = string
  description = "Name of the resource group."
}

variable "public_key" {
  type        = string
  description = "Public key to be used to connect to the VM."
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet where the VM will be deployed."
}