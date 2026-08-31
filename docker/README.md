# 🐳 Docker & Containerization Reference

A production-grade reference guide covering Docker CLI management, multi-stage builds, network isolation, volumes, and Docker Compose orchestration templates.

---

## 🗺️ Command Reference / Guía de Comandos

#### 📌 Table of contents / Tabla de contenidos
- [Platform Installation Guides](#%EF%B8%8F-platform-installation-guides--guías-de-instalación)
- [Container Lifecycle Management](#container-lifecycle-management--gestión-del-ciclo-de-vida-de-contenedores)
- [Image Management](#image-management--gestión-de-imágenes)
- [Inspection & Troubleshooting](#inspection--troubleshooting--inspección-y-diagnóstico)
- [Networks & Volumes](#networks--volumes--redes-y-volúmenes)
- [System Cleanup](#system-cleanup--limpieza-del-sistema)
- [Docker Compose Commands](#docker-compose-commands--comandos-de-docker-compose)

---

### ⚒️ Platform Installation Guides / Guías de Instalación

#### 🐧 Ubuntu / Debian (Official Repository / Repositorio Oficial)

```bash
# Uninstall conflicting or legacy packages / Desinstalar paquetes antiguos
sudo apt-get remove -y docker docker-engine docker.io containerd runc

# Update package index and install prerequisites / Actualizar e instalar dependencias
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

# Add Docker official GPG key / Añadir la clave GPG oficial de Docker
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL [https://download.docker.com/linux/ubuntu/gpg](https://download.docker.com/linux/ubuntu/gpg) | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Set up repository / Configurar repositorio de Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] [https://download.docker.com/linux/ubuntu](https://download.docker.com/linux/ubuntu) \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine and Plugins / Instalar Docker Engine y plugins
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Manage Docker as non-root user / Configurar usuario sin root
sudo usermod -aG docker $USER
# Note: Log out and back in for changes to take effect / Nota: Reiniciar sesión para aplicar cambios
```

#### 🪟 Windows 11 / WSL2 (Ubuntu)

```bash
# Option 1: Docker Desktop Integration (Recommended for Desktop UI) / Integración con Docker Desktop
# 1. Download Docker Desktop installer from [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)
# 2. Enable 'Use the WSL 2 based engine' in Settings -> General
# 3. Enable integration under Settings -> Resources -> WSL Integration -> Enable Ubuntu

# Option 2: Native Docker Engine inside WSL2 Ubuntu (CLI-only / Ligero)
# Execute the Ubuntu script above, then start the service manually:
sudo service docker start
```

#### 🍎 macOS (Homebrew / Apple Silicon & Intel)

```bash
# Install Docker Desktop via Homebrew Cask / Instalar Docker Desktop con Homebrew
brew install --cask docker

# Alternative: Colima (Lightweight CLI runtime without Docker Desktop) / Alternativa ligera CLI
brew install colima docker docker-compose
colima start --cpu 2 --memory 4
```

---

### Container Lifecycle Management / Gestión del Ciclo de Vida de Contenedores
```bash
# Run container in background mapping ports and naming it / Ejecutar contenedor en segundo plano con puerto y nombre
docker run -d --name web-server -p 8080:80 nginx:alpine

# Run interactive container with pseudo-TTY and remove on exit / Ejecutar contenedor interactivo y auto-eliminar al salir
docker run --rm -it ubuntu:22.04 bash

# List active containers / Listar contenedores en ejecución
docker ps

# List all containers (including stopped ones) / Listar todos los contenedores (incluidos los detenidos)
docker ps -a

# Stop running container gracefully / Detener contenedor de forma suave
docker stop web-server

# Start stopped container / Iniciar contenedor detenido
docker start web-server

# Force stop container / Forzar la detención del contenedor
docker kill web-server

# Remove container / Eliminar contenedor
docker rm web-server

# Force remove running container / Forzar la eliminación de un contenedor activo
docker rm -f web-server
```

---

### Image Management / Gestión de Imágenes

```bash
# Build image from Dockerfile tagger with name and version / Construir imagen desde Dockerfile etiquetándola
docker build -t my-app:v1.0.0 .

# Build image specifying custom Dockerfile path / Construir imagen usando un Dockerfile específico
docker build -f Dockerfile-multistage -t my-app:prod .

# List locally cached images / Listar imágenes locales
docker images

# Pull image from Docker Hub / Descargar imagen desde Docker Hub
docker pull redis:alpine

# Push image to registry / Subir imagen a un registro (Hub/ECR)
docker push my-repo/my-app:v1.0.0

# Remove local image / Eliminar imagen local
docker rmi my-app:v1.0.0

# Inspect image history and layers / Inspeccionar el historial y capas de la imagen
docker history my-app:v1.0.0
```

---

### Inspection & Troubleshooting / Inspección y Diagnóstico

```bash
# Stream real-time container logs / Ver logs en tiempo real
docker logs -f web-server

# View last 100 log entries with timestamps / Ver las últimas 100 líneas de logs con fecha/hora
docker logs --tail 100 -t web-server

# Execute interactive shell inside running container / Ejecutar consola interactiva en un contenedor activo
docker exec -it web-server /bin/sh

# Inspect container configuration and IP addresses / Inspeccionar configuración e IPs del contenedor
docker inspect web-server

# Display container resource utilization (CPU, RAM, Net I/O) / Monitorizar recursos en tiempo real
docker stats
```

---

### Networks & Volumes / Redes y Volúmenes

```bash
# Create custom bridge network / Crear red personalizada de tipo bridge
docker network create app-network

# List available networks / Listar redes disponibles
docker network ls

# Inspect network details and connected containers / Inspeccionar detalles de red y contenedores conectados
docker network inspect app-network

# Create named volume / Crear volumen persistente con nombre
docker volume create db_data

# List all volumes / Listar volúmenes existentes
docker volume ls

# Remove volume / Eliminar volumen
docker volume rm db_data
```

---

### System Cleanup / Limpieza del Sistema

```bash
# Remove stopped containers, unused networks, and dangling images / Limpiar recursos en desuso
docker system prune -f

# Total cleanup including unused volumes and unreferenced images / Limpieza total incluyendo volúmenes sin uso
docker system prune -a --volumes -f
```

---

### Docker Compose Commands / Comandos de Docker Compose

```bash
# Start stack in background building images if necessary / Levantar stack en segundo plano construyendo imágenes
docker compose up -d --build

# View stack logs / Ver logs de todo el stack
docker compose logs -f

# List containers in the current stack / Listar contenedores del stack actual
docker compose ps

# Execute command inside a stack service / Ejecutar comando en un servicio del stack
docker compose exec app-service npm test

# Stop and remove containers, networks created by stack / Detener y eliminar contenedores y redes del stack
docker compose down

# Stop stack and remove associated volumes / Detener el stack y eliminar volúmenes persistentes
docker compose down -v
```