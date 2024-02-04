# Getting started

## Setting up Debian


### Fix missing serial devices

```bash
apt-get remove --auto-remove brltty
```

[https://unix.stackexchange.com/a/713263](https://unix.stackexchange.com/a/713263)


### Increase open file limit

Add the following to this file: `/etc/security/limits.conf`

```txt
*       soft    nofile          1048576
*       hard    nofile          1048576
root    soft    nofile          1048576
root    hard    nofile          1048576
```

Add the following to this file: `nano /etc/sysctl.conf`

```txt
fs.inotify.max_user_instances = 1280
fs.inotify.max_user_watches = 10028400
```

**Not sure if I need to modify the following**:

Add `DefaultLimitNOFILE=1048576` in `/etc/systemd/system.conf` and `/etc/systemd/user.conf` below `[manager]`

## Setting up Kubernetes

### Install the cluster

```bash
k0sctl apply
k0sctl kubeconfig > ~/.kube/config
```

### Restore Sealed Secret key

(Restore sealed-secret.yaml from Backup)

```bash
k apply -f sealed-secret.yaml
```

### Install ArgoCD

```bash
cd ops/argocd
k create ns ops
k kustomize --enable-helm | k apply -f -
```

From now on everything else will be installed / setup by ArgoCD
