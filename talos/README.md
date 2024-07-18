# Talos Setup

## Required Tools

* [talhelper](https://github.com/budimanjojo/talhelper)
* [go-task](https://github.com/go-task/task)
* [talosctl](https://www.talos.dev/latest/learn-more/talosctl/)
* [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
* [cilium-cli](https://github.com/cilium/cilium-cli)

## Initial Setup

Generate initial secrets using: `task gensecrets`

After that you can join the fresh nodes using:

Note: The new VMs are unconfigured and got a random IP from DHCP, hence we need to check in Proxmox VM Console which IP the VM actually has.

```bash
# CP
IP=192.168.1.xx HOST=cp-1 task join
IP=192.168.1.xx HOST=cp-2 task join
IP=192.168.1.xx HOST=cp-3 task join
# Worker
IP=192.168.1.xx HOST=worker-1 task join
IP=192.168.1.xx HOST=worker-2 task join
IP=192.168.1.xx HOST=worker-3 task join
```

After applying all configuration the nodes should be rebooted and more or less ready. Now we can bootstrap the cluster once:

```bash
task bootstrap
```

After that we should have a kubeconfig file in the current directory. If not, or you want to generate later again you can run

```bash
task genconfig
```

This command also outputs your current nodes.

Since we're using a Virtual high-available IP for the control plane we should modify the generated kubeconfig. Adjust the IP to the Talos `/machine/network/interfaces/0/vip` IP.

```bash
export KUBECONFIG="$PWD/kubeconfig"
```

Now we can see all nodes using kubectl:

```bash
k get nodes
NAME             STATUS     ROLES           AGE     VERSION
talos-cp-1       NotReady   control-plane   3m26s   v1.30.1
talos-cp-2       NotReady   control-plane   3m6s    v1.30.1
talos-cp-3       NotReady   control-plane   3m14s   v1.30.1
talos-worker-1   NotReady   <none>          3m24s   v1.30.1
talos-worker-2   NotReady   <none>          3m22s   v1.30.1
talos-worker-3   NotReady   <none>          3m20s   v1.30.1
```

As you can see the nodes are all `NotReady`. This is expected since we are still missing a CNI. In our talconfig.yaml I actually set CNI to `none`. We're going to install [cilium](https://cilium.io/).

## Install CNI

We're using cilium as CNI as it provides many powerful features for us. We install it using the install-tools task.

```bash
task install-tools
```
