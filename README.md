Despliegue de una aplicación web frontend en Kubernetes usando "httpd:alpine" con pagina HTML que muestra el nombre del pod que sirve cada petición

### Versiones probadas

| Herramienta    | Versión |
| -------------- | ------- |
| Minikube       | v1.38.1 |
| Kubernetes     | v1.35.1 |
| kubectl        | v1.36.0 |
| Docker Desktop | Any     |
### Estructura del repositorio
.
├── deploy.sh                             # Script de despliegue
├── k8s                                         # Directorio de manifiestos
│   ├── configmap.yaml           # HTML personalizado
│   ├── deployment.yaml        # Deployment con 3 réplicas y rolling update
│   ├── ingress.yaml                  # Ingress con host en devops-test.local
│   └── service.yaml                  # Service tipo ClusterIP
└── README.md

### Requisitos para instalar este repositorio

1. Tener Docker Desktop activo
2.  Instalar **minikube** 
```
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
minikube version

```
2. Instalar **kubectl**
```
curl -LO https://dl.k8s.io/release/v1.36.0/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/kubectl
kubectl version --client

```
3. Clonar el repositorio
```
git clone https://github.com/svnml/prueba-tecnica-sabe.git
cd prueba-tecnica-sabe
```
4.  Desplegar la aplicación
```
# Dar permisos de ejecución a los script
chmod +x install.sh
chmod +x deploy.sh

# Ejecutar el instalador indicando el tag de imagen
./install.sh alpine
```
```
# Tags alternativos
./install.sh 2.4.67-alpine
./install.sh 2.4-alpine
./install.sh latest-alpine
```
	El script realiza automáticamente los siguientes pasos:
		1. Arranca minikube si no está en ejecución
		2. Habilita el addon Ingress
		3. Espera que el controlador de "ingress-nginx" esté listo
		4. Aplica los manifiestos (ConfigMap, Service, Ingress, Deployment)
		5. Espera el rollout sin downtime y revisa los pods desplegados

Una vez instalada la aplicación con *minikube tunnel* corriendo, podemos realizar los Rolling Updates ejecutando en otra terminal:
```
./deploy.sh alpine   # O cualquier otra etiqueta soportada por httpd
```


### Verificaciones manuales

Estado y logs de los pods
```
kubectl get pods -l app=frontend
```
```
kubectl logs -l app=frontend
```
Service e Ingress
```
kubectl get svc frontend
```
```
kubectl get ingress frontend
```

Acceder a la aplicación
```
curl http://devops-test.local
```
o acceder a la aplicación con el navegador en http://devops-test.local# prueba-tecnica-sabe
