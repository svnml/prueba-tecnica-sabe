#!/bin/bash
set -e

# verificar si existe el parametro TAG
if [ -z "$1" ]; then
  echo "Missing TAG: $0 <tag>"
  exit 1
fi

TAG="$1"

# aplicar deployment con el tag de imagen especificado
sed "s|httpd:IMAGE_TAG|httpd:${TAG}|g" k8s/deployment.yaml | kubectl apply -f -

# inicializar rolling update
kubectl rollout restart deployment/frontend

# mostrar status del rollout
kubectl rollout status deployment/frontend

# verificar los pods actuales
kubectl get pods