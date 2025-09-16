#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

kubectl create ns sealed-secrets || true
kubectl create ns argocd || true

kubectl apply -f "$SCRIPT_DIR/../sealed-secret-backup.yaml"
kubectl kustomize --enable-helm "$SCRIPT_DIR/../kubernetes/argocd/argocd" | kubectl apply -f -
kubectl kustomize --enable-helm "$SCRIPT_DIR/../kubernetes/argocd/argocd-apps" | kubectl apply -f -
