FROM debian:12.2

COPY --from=alpine/helm:3.13.2 /usr/bin/helm /usr/bin/helm
COPY --from=bitnami/kubectl:1.28.3 /opt/bitnami/kubectl/bin/kubectl /usr/bin/kubectl
COPY --from=ghcr.io/yannh/kubeconform:v0.6.3 /kubeconform /usr/bin/kubeconform


# We need ca-certificates for tls certs to download helm charts
# We need git for kustomize to download git charts
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates git && \
    apt-get clean autoclean && \
    rm -fr /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/*

ENTRYPOINT [ "/bin/bash" ]
