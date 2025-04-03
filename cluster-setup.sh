#!/usr/bin/env bash

echo "Installing ArgoCD..."
kustomize build argocd | kubectl apply -f -

kubectl apply -f projects.yaml
kubectl apply -f applications.yaml

echo "Done!"
