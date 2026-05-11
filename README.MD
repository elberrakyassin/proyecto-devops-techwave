TechWave Solutions - DevOps Ecosystem
Este repositorio contiene la implementación completa del ciclo de vida DevOps para la aplicación web de TechWave Solutions. Incluye la contenerización, el aprovisionamiento de infraestructura en Azure (AKS), el pipeline de CI/CD y el stack completo de observabilidad.

🛠 Stack Tecnológico
App: Node.js

Cloud: Azure (AKS)

IaC: Terraform

CI/CD: GitHub Actions

Observabilidad: Prometheus, Grafana, Loki & OpenTelemetry.

🔐 Requisitos Previos y Credenciales
Antes de desplegar, asegúrate de tener instaladas las siguientes herramientas:

Azure CLI

Terraform

kubectl

Docker Desktop

Configuración de Secretos
Para que el pipeline de GitHub Actions funcione, debes configurar los siguientes "Repository Secrets" en GitHub:

AZURE_CREDENTIALS: Salida JSON del comando az ad sp create-for-rbac.

DOCKER_HUB_USERNAME: Tu usuario de Docker Hub.

DOCKER_HUB_TOKEN: Token de acceso personal de Docker Hub.

KUBE_CONFIG: (Opcional) Configuración de acceso al clúster si se gestiona fuera de Azure CLI.

🚀 Pasos para el Despliegue
1. Infraestructura con Terraform
Desde la carpeta terraform/:

Bash
terraform init
terraform plan
terraform apply -auto-approve
2. Conexión al clúster
Configura tu contexto local para apuntar al clúster creado en Azure:

Bash
az aks get-credentials --resource-group <NOMBRE_RG> --name <NOMBRE_AKS>
3. Despliegue de la Aplicación y Observabilidad
Aplica los manifiestos de Kubernetes en orden:

Bash
# 1. Namespace y Monitorización
kubectl apply -f k8s/monitoring-stack.yaml

# 2. Aplicación (Blue-Green)
kubectl apply -f k8s/techwave-app.yaml

# 3. OpenTelemetry Collector
kubectl apply -f k8s/otel-collector.yaml
kubectl apply -f k8s/otel-monitor.yaml
📊 Acceso a la Observabilidad
Para visualizar las métricas y logs en Grafana:

Obtén la contraseña de admin:
kubectl get secret --namespace monitoring monitoring-grafana -o jsonpath="{.data.admin-password}" | base64 --decode

Realiza un port-forward:
kubectl port-forward svc/monitoring-grafana 3000:80 -n monitoring

Accede a http://localhost:3000

🔄 Estrategia Blue-Green
Para realizar un cambio de versión sin downtime, actualiza el tag de la imagen en el deployment green y, una vez validado, cambia el selector del Service:

Bash
kubectl patch service techwave-service -p '{"spec":{"selector":{"version":"v2"}}}'
¿Qué añadir a la memoria sobre este README?
En tu memoria PDF, en el apartado de "Manual de Instalación", puedes mencionar:

"Se ha incluido un archivo README.md en la raíz del repositorio que sirve como guía rápida de despliegue. Este archivo detalla no solo los comandos necesarios para replicar la infraestructura, sino también la gestión crítica de Secretos de GitHub y credenciales de Azure, asegurando que el proceso de CI/CD sea transparente y seguro para cualquier administrador del sistema."