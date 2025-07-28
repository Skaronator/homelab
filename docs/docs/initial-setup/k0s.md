# Setting up Kubernetes

Kubernetes can be installed in many different ways. Just like Linux has multiple distributions, so does Kubernetes.
I tried several distributions from Ansible Playbooks to Immutable Host systems—they all have their ups and downs.

I'm currently using k0s which is similar to k3s, but the out-of-the-box experience is way better suited for my use case.

## k0sctl CLI

k0s provides a CLI tool that is somewhat similar to OpenTofu and you can run on your PC in order to install, upgrade and backup the k0s cluster running elsewhere.

The tool is called k0sctl and [can be found on GitHub](https://github.com/k0sproject/k0sctl). Install instructions are on the [official homepage](https://docs.k0sproject.io/head/k0sctl-install/).

## The k0sctl.yaml config file

This file describes your cluster. Here are all the nodes and their associated IPs in this config file. 

You can either adopt my k0sctl.yaml file or generate your own with this command:

```bash
k0sctl init > k0sctl.yaml
```

After you've adjusted the config to your liking, you can run this command to deploy your cluster:

```bash
k0sctl apply
k0sctl kubeconfig > ~/.kube/config
```

## Restore Sealed Secret key

(Restore sealed-secret.yaml from Backup)

```bash
k apply -f sealed-secret.yaml
```

## Install ArgoCD

```bash
cd ops/argocd
k create ns ops
k kustomize --enable-helm | k apply -f -
```

From now on everything else will be installed / setup by ArgoCD
