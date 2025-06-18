variable "vms_count" {
  type        = number
  description = "Number of control-plane nodes VMs to create."
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key to use for VMs."
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet to use for VMs."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}