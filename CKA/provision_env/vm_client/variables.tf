variable "rg_location" {
  type        = string
  description = "The location/region where the resource group will be created."  
}

variable "rg_name" {
  type        = string
  description = "Name of the resource group."
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
