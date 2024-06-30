# Proxmox Setup

This folder contains all IaC that setup all the VMs within Proxmox.

This is very much WIP and I'm not happy about the current IaC due to two issues:

* You cannot define a dynamic provider within an `for_each` loop. So I had to split up the deployment in 3 seperate modules. This will be fixed in OpenTF 1.9.0 but in the meantime I had to use duplicated code.
* The Proxmox provider is currently a bit buggy. I'm unable to configure `hostpci` and once configured the `tofu plan` throws an error, even when set to ignore it. 
