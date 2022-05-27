# A Terraform module to create a subset of cloud components
# Copyright (C) 2022 Skaylink GmbH

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# For questions and contributions please contact info@iq3cloud.com

variable "resource_group_name" {
  type        = string
  description = "The resource group, where the virtual machine should be deployed"
}

variable "mgmt_resource_group" {
  type        = string
  description = "The resource group where log analytics, backup policies, recovery vault and storage account for logging is located"
  default     = "iq3-basemanagement"
}

variable "vm_name" {
  type        = string
  description = "The name of the virtual machine. This will be the prefix for all related items"

  validation {
    condition     = length(var.vm_name) >= 3 && length(var.vm_name) <= 15
    error_message = "The vm_name length must be between 3 and 15 characters."
  }
}

#########################
# Network Configuration #
#########################
variable "vnet_resource_group_name" {
  type        = string
  description = "The resource group where network components are located"
}

variable "vnet_name" {
  type        = string
  description = "The virtual network of the virtual machine"
}

variable "vnet_subnet_name" {
  type        = string
  description = "The subnet inside the virtual network of the virtual machine"
}

variable "application_security_groups" {
  type        = list(string)
  description = "A list of application security groups to assign to the VM"
  default     = []
}

####################
# VM Configuration #
####################
variable "vm_size" {
  type        = string
  description = "The size of the virtual machine"
}

variable "vm_encryption_key_vault_name" {
  type        = string
  description = "The key vault with the encryption key"
}

variable "vm_encryption_key_name" {
  type        = string
  description = "The name of the encryption key inside the key vault"
}

variable "vm_sku" {
  type        = string
  description = "The SKU of the Windows image"
  default     = "2019-Datacenter"
}

variable "vm_version" {
  type        = string
  description = "The version of the Windows VM image"
  default     = "latest"
}

variable "vm_publisher" {
  type        = string
  description = "The publisher of the Windows VM image"
  default     = "MicrosoftWindowsServer"
}

variable "vm_offer" {
  type        = string
  description = "The offer of the Windows VM image"
  default     = "WindowsServer"
}

variable "vm_enable_disk_encryption" {
  type        = bool
  description = "The offer of the Windows VM image"
  default     = true
}

variable "vm_recovery_vault" {
  type        = string
  description = "The recovery vault to configure virtual machine for Backup in base management (using DefaultPolicy). Make sure that your run context has Contributor rights on the Recovery Vault."
}

###################################
# Monitoring and Patch management #
###################################

variable "la_workspace_name" {
  type        = string
  description = "The name of the log analytics workspace"
}

variable "iaas_logging_account_name" {
  type        = string
  description = "The logging Account to enable Patch Management for virtual machine"
}

###############
# Domain Join #
###############
variable "domain_join_settings" {
  type = object({
    domain_name             = string
    username_key_vault_name = string
    password_key_vault_name = string
    ou_path                 = string
  })
  default     = null
  description = "Pass a Domain Name, OU Path, as well as the names of secrets for username and password of an Active Directory user that is allowed to domain join virtual machines. The secrets are taken out of the key vault that was defined in the variable vm_encryption_key_vault_name"
}
