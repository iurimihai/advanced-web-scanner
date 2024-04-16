#!/usr/bin/env bash

echo "Installing ArgoCD..."
kustomize build argocd | kubectl apply -f -
# kubectl apply -f root-appset.yaml
kubectl apply -f resources.yaml
echo "Done!"
