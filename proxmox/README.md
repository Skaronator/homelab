# Proxmox Setup

This folder contains all IaC that setup all the VMs within Proxmox.

The IaC is responsible for:

* Downloading Talos ISO on all 3 Nodes
* Setup Talos Control Plane and Talos Worker Node VM on each Node, 2 VMs x 3 Nodes = 6 VMs

The IaC in its current form is not perfect because we cannot define a dynamic provider within an `for_each` loop.
So I had to split up the deployment in 3 seperate modules. This will be fixed in OpenTF 1.9.0 but in the meantime I had to use duplicated code.
