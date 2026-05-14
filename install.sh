#!/bin/bash
set -e

# verificar si existe el parametro TAG
if [ -z "$1" ]; then
  echo "Missing TAG: $0 <tag>"
  exit 1
fi

TAG="$1"

# inicializar minikube si no esta corriendo
if ! minikube status | grep -q "Running"; then
  minikube start
fi

# habilitar ingress addon si no esta habilitado
if ! minikube addons list | grep "ingress " | grep -q "enabled"; then
  minikube addons enable ingress
fi

# esperar al ingress controller y al webhook de admision
kubectl wait pod \
  --namespace ingress-nginx \
  --for=condition=ready \
  -l app.kubernetes.io/component=controller \
  --timeout=120s
sleep 5

# aplicar manifiestos
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml

# aplicar deployment con el tag de imagen especificado
sed "s|httpd:IMAGE_TAG|httpd:${TAG}|g" k8s/deployment.yaml | kubectl apply -f -

# inicializar rolling update
kubectl rollout restart deployment/frontend

# mostrar status del rollout
kubectl rollout status deployment/frontend

# verificar los pods actuales
kubectl get pods

# 
minikube tunnel


