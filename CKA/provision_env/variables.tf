variable "rg_location" {
  type        = string
  description = "Location for all resources."
  default     = "West Europe"
}

variable "rg_name" {
  type        = string
  description = "Name of the resource group."
  default     = "training-CKA-rg"
}

variable "cp_vm_count" {
  type        = number
  description = "Number of control-plane nodes VMs to create."
  default     = 1
}

variable "wk_vm_count" {
  type        = number
  description = "Number of worker nodes VMs to create."
  default     = 1
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID."
}