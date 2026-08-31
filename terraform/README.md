# 🏗️ Terraform Infrastructure as Code (IaC) Reference

A modular reference guide for provisioning infrastructure on AWS using Terraform, workspace/environment organization, state locking via S3/DynamoDB, and reusable modules.

---

## 🗺️ Command Reference / Guía de Comandos


### Platform Installation Guides / Guías de Instalación

#### 🐧 Ubuntu / Debian (HashiCorp Official Repository)

```bash
# Install prerequisites / Instalar dependencias
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl

# Add HashiCorp GPG key / Añadir la clave GPG de HashiCorp
curl -fsSL [https://apt.releases.hashicorp.com/gpg](https://apt.releases.hashicorp.com/gpg) | sudo apt-key add -

# Add repository / Añadir repositorio
sudo apt-add-repository "deb [arch=amd64] [https://apt.releases.hashicorp.com](https://apt.releases.hashicorp.com) $(lsb_release -cs) main"

# Install Terraform / Instalar Terraform
sudo apt-get update && sudo apt-get install terraform
```

### CLI Command Reference / Comandos Esenciales

```Bash
# Initialize working directory / Inicializar directorio y descargar proveedores
terraform init

# Format configuration files according to HCL standards / Formatear código HCL
terraform fmt -recursive

# Validate syntax and consistency / Validar sintaxis y coherencia
terraform validate

# Generate and show execution plan / Generar y visualizar plan de ejecución
terraform plan -out=tfplan

# Apply execution plan / Aplicar cambios en la infraestructura
terraform apply tfplan

# Destroy infrastructure managed by Terraform / Destruir la infraestructura
terraform destroy
```

### State & Backend Management / Gestión de Estado

```bash
# List resources in state file / Listar recursos administrados en el state
terraform state list

# Show detailed information for a resource in state / Mostrar detalle de un recurso
terraform state show module.aws_app_stack.aws_instance.web_server

# Refresh state against real infrastructure / Sincronizar estado con infra real
terraform apply -refresh-only
```