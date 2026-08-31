# ☸️ Kubernetes & Cloud-Native Reference

A complete reference guide for Kubernetes cluster management, local development with **Kind**, package management using **Helm**, and production-grade manifest templates.

## 🗺️ Command Reference / Guía de Comandos

#### 📌 Table of contents / Tabla de contenidos
- [Tooling Installation Guides](#tooling-installation-guides--instalación-de-herramientas)
- [Cluster Setup with Kind](#cluster-setup-with-kind--configuración-de-cluster-con-kind)
- [Kubectl Command Reference](#kubectl-command-reference--guía-de-comandos-kubectl)
- [Package Management with Helm](#package-management-with-helm--gestión-de-paquetes-con-helm)
- [Troubleshooting & Debugging](#troubleshooting--debugging--diagnóstico-y-depuración)

---

### Tooling Installation Guides / Instalación de Herramientas

#### 🛠️ kubectl, Kind & Helm Installation (Linux / WSL2)

```bash
# Install kubectl (Kubernetes CLI) / Instalar kubectl
curl -LO "[https://dl.k8s.io/release/$(curl](https://dl.k8s.io/release/$(curl) -L -s [https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl](https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl)"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Kind (Kubernetes in Docker) / Instalar Kind
curl -Lo ./kind [https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64](https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64)
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Install Helm (Kubernetes Package Manager) / Instalar Helm
curl [https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3](https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3) | bash
```

---

### Cluster Setup with Kind / Configuración de Cluster con Kind

```bash
# Create cluster using custom multi-node configuration / Crear cluster usando configuración personalizada
kind create cluster --config kind/kind-3nodes-config.yaml --name devops-lab

# List active Kind clusters / Listar clusters de Kind activos
kind get clusters

# Set kubectl context to Kind cluster / Configurar el contexto de kubectl hacia Kind
kubectl cluster-info --context kind-devops-lab

# Load local Docker image into Kind cluster / Cargar una imagen Docker local en el cluster
kind load docker-image my-app:v1.0.0 --name devops-lab

# Delete Kind cluster / Eliminar el cluster de Kind
kind delete cluster --name devops-lab
```

---

### Kubectl Command Reference / Guía de Comandos Kubectl

#### Cluster & Context Management / Gestión de Cluster y Contextos

```bash
# Display cluster info / Mostrar información general del cluster
kubectl cluster-info

# List all cluster nodes with details / Listar nodos del cluster con detalles
kubectl get nodes -o wide

# Display current context / Mostrar contexto actual
kubectl config current-context

# Switch to a different context / Cambiar de contexto
kubectl config use-context devops-lab
```

#### Resource Inspection & Creation / Inspección y Creación de Recursos

```bash
# Apply declarative manifests from a folder / Aplicar manifiestos de un directorio
kubectl apply -f manifests/base/

# Delete resources defined in manifests / Eliminar recursos definidos en manifiestos
kubectl delete -f manifests/base/

# List Pods in a specific namespace / Listar Pods en un namespace específico
kubectl get pods -n devops-app -o wide

# Stream real-time logs from a Pod / Ver logs en tiempo real de un Pod
kubectl logs -f deployment/app-deployment -n devops-app

# Stream logs from a specific container in a multi-container Pod / Logs de un contenedor específico
kubectl logs -f pod-name -c container-name -n devops-app

# Execute interactive shell inside running Pod / Entrar a la consola de un Pod
kubectl exec -it deployment/app-deployment -n devops-app -- /bin/sh
```

---

### Package Management with Helm / Gestión de Paquetes con Helm

```bash
# Add official Helm repository / Añadir repositorio oficial de Helm
helm repo add ingress-nginx [https://kubernetes.github.io/ingress-nginx](https://kubernetes.github.io/ingress-nginx)
helm repo update

# Search charts in registered repositories / Buscar charts en los repositorios
helm search repo nginx

# Install release overriding default values / Instalar un release aplicando valores personalizados
helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace \
  -f helm/values-override.yaml

# List installed releases / Listar releases instalados
helm list -A

# Upgrade release to new configuration / Actualizar release con nueva configuración
helm upgrade ingress-nginx ingress-nginx/ingress-nginx -f helm/values-override.yaml

# Rollback release to previous revision / Revertir release a revisión anterior
helm rollback ingress-nginx 1

# Uninstall release / Desinstalar release
helm uninstall ingress-nginx -n ingress-nginx
```

---

### Troubleshooting & Debugging / Diagnóstico y Depuración

```bash
# Describe resource details and events / Describir detalles y eventos del recurso
kubectl describe pod -l app=devops-app -n devops-app

# Temporary port-forward to access Service locally / Redirigir puerto local a un Servicio
kubectl port-forward svc/app-service 8080:80 -n devops-app

# Run temporary debug Pod with curl / Ejecutar Pod temporal de diagnóstico con curl
kubectl run debug-pod --rm -i --tty --image=curlimages/curl -- sh

# View resource consumption (CPU/Memory) / Ver consumo de recursos (Requiere Metrics Server)
kubectl top nodes
kubectl top pods -n devops-app
```