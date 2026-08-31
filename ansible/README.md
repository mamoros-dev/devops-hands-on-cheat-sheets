# ⚙️ Ansible Configuration Management & Automation

A production-ready reference guide for automated server provisioning, application deployment, dynamic inventories, role structures, and secrets management using **Ansible Vault**.

---

## 🗺️ Command Reference / Guía de Comandos

### Platform Installation Guides / Guías de Instalación

#### 🐧 Ubuntu / Debian (Official PPA)

```bash
# Update repository index and install software-properties-common / Actualizar e instalar dependencias
sudo apt-get update
sudo apt-get install -y software-properties-common

# Add official Ansible PPA / Añadir repositorio PPA oficial
sudo add-apt-repository --yes --update ppa:ansible/ansible

# Install Ansible / Instalar Ansible
sudo apt-get install -y ansible

# Install optional community collections / Instalar colecciones de la comunidad (ej. AWS)
ansible-galaxy collection install amazon.aws community.general
```

#### 🪟 Windows 11 (via WSL2 Ubuntu)

```bash
# Ansible control node is natively supported inside WSL2 Ubuntu
# Executing inside WSL2 Ubuntu environment:
sudo apt update && sudo apt install -y python3-pip python3-paramiko
pip3 install ansible boto3 botocore
```

---

### CLI Command Reference / Comandos Esenciales

```Bash
# Ping all hosts in static inventory / Comprobar conectividad con todos los hosts
ansible all -m ping -i inventory/hosts.ini

# Run ad-hoc command to check disk space / Ejecutar comando ad-hoc
ansible webservers -m shell -a "df -h" -i inventory/hosts.ini

# Syntax check a playbook / Verificar sintaxis de un playbook
ansible-playbook playbooks/site.yml --syntax-check

# Dry-run execution (check mode) / Modo prueba sin aplicar cambios reales
ansible-playbook playbooks/site.yml -i inventory/hosts.ini --check --diff

# Execute master playbook / Ejecutar el playbook maestro
ansible-playbook playbooks/site.yml -i inventory/hosts.ini

# Execute using AWS EC2 Dynamic Inventory / Ejecutar usando inventario dinámico
ansible-playbook playbooks/site.yml -i inventory/aws_ec2.yml
```

---

### Ansible Vault & Secrets Management / Gestión de Secretos

```bash
# Create an encrypted variables file / Crear un archivo encriptado
ansible-vault create inventory/group_vars/all/vault.yml

# Encrypt an existing file / Encriptar un archivo existente
ansible-vault encrypt inventory/group_vars/production/vault.yml

# Edit an encrypted file / Editar un archivo encriptado
ansible-vault edit inventory/group_vars/all/vault.yml

# Run playbook prompting for vault password / Ejecutar playbook pidiendo contraseña de Vault
ansible-playbook playbooks/site.yml -i inventory/hosts.ini --ask-vault-pass

# Run playbook using a vault password file / Usar archivo de clave para automatización CI/CD
ansible-playbook playbooks/site.yml -i inventory/hosts.ini --vault-password-file ~/.vault_pass
``` 