# Talos Setup

## Initial Setup

Generate node config using: `talhelper genconfig`

Switch to the newly generated folder and set the env variable to talosctl:

```bash
cd clusterconfig
export TALOSCONFIG="$PWD/talosconfig"
```

After that you can join the nodes using:

```bash
# CP
talosctl apply --file homelab-talos-cp-1.yaml -i -n 192.168.1.xx
talosctl apply --file homelab-talos-cp-2.yaml -i -n 192.168.1.xx
talosctl apply --file homelab-talos-cp-3.yaml -i -n 192.168.1.xx
# Worker
talosctl apply --file homelab-talos-worker-1.yaml -i -n 192.168.1.xx
talosctl apply --file homelab-talos-worker-2.yaml -i -n 192.168.1.xx
talosctl apply --file homelab-talos-worker-3.yaml -i -n 192.168.1.xx
```

After everything is more or less running we can bootstrap etcd on **one** of the control plane nodes:

```bash
talosctl bootstrap --nodes talos-cp-1
```

After bootstrapping we can generate a kubectl config:

```bash
talosctl kubeconfig --nodes talos-cp-1 .
```

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

We're using cilium as CNI as it provides many powerful features for us.

```bash
kubectl create namespace network

```
