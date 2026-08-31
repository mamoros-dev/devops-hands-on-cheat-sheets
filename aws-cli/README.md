# ☁️ AWS CLI (Amazon Web Services) Reference

A production-ready reference guide covering AWS CLI v2 installation across operating systems, multi-profile authentication, IAM policies, and daily management of core AWS services (EC2, S3, VPC, EKS, RDS).

---

## 🗺️ Command Reference / Guía de Comandos

### Platform Installation Guides / Guías de Instalación

#### 🐧 Linux x86_64 / WSL2

```bash
# Download official installer zip / Descargar el instalador oficial
curl "[https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip](https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip)" -o "awscliv2.zip"

# Unzip and run update/install script / Descomprimir e instalar
unzip awscliv2.zip
sudo ./aws/install

# Verify installation / Verificar la versión instalada
aws --version
```

#### 🪟 Windows (PowerShell / CMD)

```bash
# Install via msiexec installer / Instalar mediante MSI
msiexec.exe /i [https://awscli.amazonaws.com/AWSCLIV2.msi](https://awscli.amazonaws.com/AWSCLIV2.msi) /qn

# Or install via winget / O mediante winget
winget install Amazon.AWSCLI
```

#### 🍎 macOS

```bash
# Download pkg installer and execute / Descargar e instalar el paquete
curl "[https://awscli.amazonaws.com/AWSCLIV2.pkg](https://awscli.amazonaws.com/AWSCLIV2.pkg)" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
```

---

### Authentication & Profiles / Autenticación y Perfiles

```bash
# Interactive setup for default profile / Configuración interactiva del perfil por defecto
aws configure

# Interactive setup for a specific Named Profile / Configurar un perfil específico
aws configure --profile devops-prod

# Configure AWS SSO (Single Sign-On / IAM Identity Center) / Autenticación con SSO
aws configure sso

# Login using SSO profile / Iniciar sesión con perfil SSO
aws sso login --profile devops-prod

# Verify current identity and active account / Verificar usuario/rol activo
aws sts get-caller-identity

# Execute any command using a specific profile / Ejecutar comando especificando el perfil
aws s3 ls --profile devops-prod
```

---

### S3 (Simple Storage Service) Commands / Comandos S3

```bash
# List all buckets in the account / Listar todos los buckets
aws s3 ls

# Create a new private bucket / Crear un nuevo bucket privado
aws s3 mb s3://my-devops-backup-bucket-2026 --region eu-west-1

# Sync local directory to S3 bucket (Backup) / Sincronizar directorio local a S3
aws s3 sync ./logs s3://my-devops-backup-bucket-2026/logs/ --delete

# Download file from S3 / Descargar archivo desde S3
aws s3 cp s3://my-devops-backup-bucket-2026/config.json ./config.json

# Remove file or folder recursively / Eliminar un objeto o carpeta en S3
aws s3 rm s3://my-devops-backup-bucket-2026/logs/ --recursive
```

---

### EC2 & VPC Commands / Comandos EC2 y Redes

```bash
# Describe running EC2 instances with state and IP / Listar instancias EC2 activas
aws ec2 describe-instances \
  --filters "Name=instance-state-name,Values=running" \
  --query "Reservations[*].Instances[*].[InstanceId, State.Name, PublicIpAddress, PrivateIpAddress, Tags[?Key=='Name'].Value|[0]]" \
  --output table

# Start or stop a specific EC2 instance / Iniciar o detener una instancia
aws ec2 start-instances --instance-ids i-0123456789abcdef0
aws ec2 stop-instances --instance-ids i-0123456789abcdef0

# List Security Groups and inbound rules / Listar Security Groups
aws ec2 describe-security-groups --query "SecurityGroups[*].[GroupId, GroupName, Description]" --output table
```

---

### EKS & Container Services / Servicios de Contenedores

```Bash
# Update local kubeconfig to connect to EKS cluster / Actualizar kubeconfig para conectar a EKS
aws eks update-kubeconfig --region eu-west-1 --name devops-prod-cluster

# Login to Amazon ECR (Elastic Container Registry) / Autenticarse contra el registro ECR
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 123456789012.dkr.ecr.eu-west-1.amazonaws.com
```
