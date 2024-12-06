FROM public.ecr.aws/docker/library/alpine:3.21.0 AS builder

ENV VERSION=13.2
RUN apk add --no-cache curl xz \
    && mkdir -p /data \
    && curl -L https://github.com/home-assistant/operating-system/releases/download/${VERSION}/haos_ova-${VERSION}.qcow2.xz | xz -d > /data/hass.qcow2

FROM scratch

COPY --from=builder --chown=107:107 /data/hass.qcow2 /data/hass.qcow2
