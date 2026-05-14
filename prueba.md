# Prueba Técnica – DevOps Junior

## Objetivo

Desplegar una aplicación web frontend en un clúster de Kubernetes. La aplicación debe:

- Usar la imagen `httpd:alpine` (servidor web Apache).
- Tener **3 réplicas**.
- Incluir las **labels** `app: frontend` y `tier: web`.
- Mostrar una página HTML personalizada que incluya el nombre del pod que sirve la petición.
- Ser accesible desde fuera del clúster mediante un **Ingress** con el host `devops-test.local`.
- Ser desplegada desde un archivo en bash/sh

## Requisitos previos

- Acceso a un clúster Kubernetes (puede ser local con Minikube, Kind, Docker Desktop, o un cloud managed).
- `kubectl` configurado y funcionando.
- **El clúster debe tener habilitado un controlador de Ingress** (por ejemplo, el addon de Ingress en Minikube o el equivalente en la distro de k8s).

## Entregables

El candidato deberá entregar los siguientes archivos YAML (o un solo archivo con `---`):

1. **ConfigMap** con la página HTML personalizada.
2. **Deployment** que use el ConfigMap para montar el contenido.
3. **Service** de tipo ClusterIP.
4. **Ingress**.
5. **Repositorio en GitHub** con las instrucciones de instalación y requisitos

Además, deberá proporcionar los comandos utilizados para verificar el correcto funcionamiento.

## Instrucciones para el candidato

### 1. ConfigMap con el contenido HTML

Crea un ConfigMap llamado `frontend-html` que contenga un archivo `index.html` con el siguiente contenido:

```html
<!DOCTYPE html>
<html>
<head><title>Prueba DevOps</title></head>
<body>
<h1>Bienvenido a la prueba técnica</h1>
<p>Servido desde el pod: <strong style="color:red;">{{HOSTNAME}}</strong></p>
<p>Replica actual: consulta la variable de entorno HOSTNAME.</p>
</body>
</html>

### 2. Entregar un archivo bash/sh que haga el despliegue de la aplicación sin downtime

Crear un script en bash/sh que al ejecutar haga el cambio de los manifiestos sin necesidad de downtime.
El script debe recibir un parametro de tag que indique que tag de httpd se desplgeara
