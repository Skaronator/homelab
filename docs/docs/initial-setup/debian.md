# Setting up Debian (Host OS)

## Increasing default open file and watch limit

!!! info "Why this is nessecary?"
    Kubernetes environments frequently encounter file handle exhaustion because multiple processes running
    under the same user need to open numerous files simultaneously and use filesystem watchers (fswatch/inotify)
    to monitor configuration changes, logs, and resources.
    
    The default Debian limits (~1024 file handles, low inotify watchers) are insufficient for Kubernetes
    clusters where container runtimes, API components, and applications can easily exceed these quotas.
    
    These increased limits prevent "too many open files" errors and ensure proper filesystem monitoring for Kubernetes controllers and logging systems.

Add the following content to the config files

```txt title="/etc/security/limits.conf"
*       soft    nofile          1048576
*       hard    nofile          1048576
root    soft    nofile          1048576
root    hard    nofile          1048576
```

```txt title="/etc/sysctl.conf"
fs.inotify.max_user_instances = 1280
fs.inotify.max_user_watches = 10028400
```

Run this command after adjusting the config: `sysctl -p`

**Not sure if I need to modify the following**:

```txt title="/etc/systemd/system.conf"
# Below [manager] block!
DefaultLimitNOFILE=1048576
```

```txt title="/etc/systemd/user.conf"
# Below [manager] block!
DefaultLimitNOFILE=1048576
```

## Increase ZFS Arc Size

By default Arc size is quite small for my system. I'm on 128 GB and would like to have at least half of that for ZFS.

```txt title="/etc/modprobe.d/zfs.conf"
# Set Max ARC size => 80 == 85899345920 Bytes
options zfs zfs_arc_max=85899345920

# Set Min ARC size => 64GB == 68719476736
options zfs zfs_arc_min=68719476736
```

After modifying this file make sure to regenerate the initramfs.

```bash
$ update-initramfs -u -k all
```

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
