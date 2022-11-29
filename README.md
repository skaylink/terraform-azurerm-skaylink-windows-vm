# Skaylink Terraform module; Windows VM

This module will deploy a Windows virtual machine on Azure with logging and backup policies. It will also install diagnositics extensions for the VM.

### Prerequisites

This module requires GET Permission for Keys on management key vault prior to being used.

> If you intend to deploy a Windows Server 2022 the encryption key you reference **has** to be more than 2048 bits, we have tested with 4096 bits, which is confirmed to work.