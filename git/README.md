# 🔀 Git & Version Control System Reference

A comprehensive reference guide for everyday Git operations, advanced branch strategies (GitFlow vs. Trunk-Based), interactive rebasing, undoing changes safely, conflict resolution, and Git Hooks automation.

---

## 🗺️ Command Reference / Guía de Comandos

#### 📌 Table of contents / Tabla de contenidos
- [Platform Installation & Initial Setup](#platform-installation--initial-setup--instalación-y-configuración)
- [Basic Lifecycle Commands](#basic-lifecycle-commands--ciclo-de-vida-básico)
- [Branching & Merging Strategies](#branching--merging-strategies--estrategia-de-ramas)
- [Advanced Rebasing & History Rewriting](#advanced-rebasing--history-rewriting--rebase-avanzado)
- [Undoing Changes & Recovery](#undoing-changes--recovery--deshacer-cambios-y-recuperación)
- [Stashing & Temporary Storage](#stashing--temporary-storage--guardado-temporal)

---

### Platform Installation & Initial Setup / Instalación y Configuración

#### 🐧 Installation / Instalación

```bash
# Ubuntu / Debian
sudo apt update && sudo apt install -y git

# macOS (Homebrew)
brew install git

# Windows (WSL2)
sudo apt update && sudo apt install -y git
# Windows terminal
winget install --id Git.Git -e --source winget
```

---

### Global Configuration & SSH Keys / Configuración Global y Claves SSH

```bash
# Configure user details / Configurar usuario y email
git config --global user.name "Miguel Amoros"
git config --global user.email "miguel@example.com"

# Set default branch name / Definir rama por defecto
git config --global init.defaultBranch main

# Set default editor and line endings / Editor por defecto y fin de línea (LF en Linux)
git config --global core.editor "vim"
git config --global core.autocrlf input

# Generate SSH Key pair for GitHub/GitLab / Generar clave SSH
ssh-keygen -t ed25519 -C "miguel@example.com"
# Display public key to add to Git provider / Ver clave pública
cat ~/.ssh/id_ed25519.pub

# Check global configuration / Ver toda la configuración global
git config --global --list
```

---

### Basic Lifecycle Commands / Ciclo de Vida Básico

```bash
# Initialize repository / Inicializar repositorio en carpeta actual
git init

# Clone repository / Clonar repositorio remoto
git clone git@github.com:mamoros-dev/repository_name.git

# Stage specific file or all changes / Añadir archivos al área de preparación (staging)
git add file.txt
git add .

# Commit staged changes / Confirmar cambios preparados
git commit -m "feat(auth): implement JWT token authentication"

# View repository status / Ver estado del repositorio
git status -s

# View formatted commit history log / Ver historial de commits gráfico y limpio
git log --oneline --graph --decorate --all

# Inspect detailed differences / Ver diferencias respecto al último commit
git diff
```

---

### Branching & Merging Strategies / Estrategia de Ramas

```bash
# List local and remote branches / Listar ramas locales y remotas
git branch -a

# Create and switch to new branch / Crear y cambiar a una nueva rama
git switch -c feature/add-login-api
# Alternative legacy syntax / Sintaxis equivalente:
git checkout -b feature/add-login-api

# Switch to existing branch / Cambiar de rama
git switch main

# Merge branch into current branch with no-fast-forward / Fusión manteniendo historial
git merge --no-ff feature/add-login-api

# Delete branch locally and remotely / Borrar rama local y remota
git branch -d feature/add-login-api
git push origin --delete feature/add-login-api
```

---

### Advanced Rebasing & History Rewriting / Rebase Avanzado

```bash
# Rebase feature branch onto updated main / Sincronizar rama aplicando cambios sobre main
git fetch origin
git rebase origin/main

# Interactive rebase of last 4 commits (squash, reword, fixup) / Modificar los últimos 4 commits
git rebase -i HEAD~4

# Abort rebase in case of conflicts / Abortar un rebase durante un conflicto
git rebase --abort

# Continue rebase after resolving conflicts / Continuar rebase tras resolver conflictos
git add .
git rebase --continue

# Cherry-pick a specific commit from another branch / Aplicar un commit específico de otra rama
git cherry-pick a1b2c3d4
```

---

### Undoing Changes & Recovery / Deshacer Cambios y Recuperación

```bash
# Discard uncommitted changes in a file / Descartar cambios no guardados en un archivo
git checkout -- file.txt
# Modern alternative / Sintaxis moderna:
git restore file.txt

# Unstage file keeping local modifications / Quitar archivo de staging manteniendo cambios
git restore --staged file.txt

# Amend last commit message or add forgotten files / Modificar el último commit
git commit --amend --no-edit

# Soft reset (undo commit, keep changes in staging) / Deshacer commit manteniendo staging
git reset --soft HEAD~1

# Hard reset (completely discard commits and uncommitted changes) / Deshacer todo a un commit
git reset --hard origin/main

# Revert published commit creating a new inverse commit / Revertir commit publicado de forma segura
git revert c4d3e2f1

# Recover deleted commits or lost references / Buscar commits perdidos (Historial local)
git reflog
```

---

### Stashing & Temporary Storage / Guardado Temporal

```bash
# Save uncommitted work to stash with description / Guardar trabajo en progreso
git stash save "WIP: implementation of payment gateway"

# List saved stashes / Listar stashes guardados
git stash list

# Apply most recent stash and remove it / Aplicar el último stash y borrarlo
git stash pop

# Apply specific stash without removing it / Aplicar stash específico
git stash apply stash@{1}

# Drop a specific stash / Borrar un stash específico
git stash drop stash@{0}
```