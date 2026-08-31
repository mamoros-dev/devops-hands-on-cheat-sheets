# 🚀 CI/CD & Automation Reference (GitHub Actions & GitLab CI)

A unified reference guide covering Continuous Integration and Continuous Deployment (CI/CD) practices, runner management, environment secrets handling, and production-ready configuration patterns for both GitHub Actions and GitLab CI/CD.

---

## 🗺️ Command Reference / Guía de Comandos

---

### Core CI/CD Concepts / Conceptos Fundamentales

- **Continuous Integration (CI):** Automates the build and testing phase upon every commit or pull request to detect bugs early.
- **Continuous Deployment (CD):** Automatically delivers tested code into production environments using GitOps strategies or direct deployment tools.
- **Runners / Agents:** Isolated workers (virtual machines or containers) that execute the job defined in the pipeline.
- **Secrets Management:** Secure storage of credentials (AWS Keys, SSH certificates, API tokens) injected into runtime without hardcoding.

---

### GitHub Actions Architecture / Arquitectura de GitHub Actions

GitHub Actions uses **YAML** workflows located in `.github/workflows/`.

### 🔑 Key Terminology:
- **Workflow:** Automated procedure composed of one or more jobs (triggered by `push`, `pull_request`, `schedule`, etc.).
- **Job:** A set of steps that execute on the same runner (e.g., `ubuntu-latest`).
- **Step:** An individual task within a job (run shell command or an action).
- **Action:** Pre-packaged reusable unit of code from the GitHub Marketplace (e.g., `actions/checkout@v4`).

---

### GitLab CI/CD Architecture / Arquitectura de GitLab CI/CD

GitLab CI/CD uses a single `.gitlab-ci.yml` configuration file placed at the root of the repository.

### 🔑 Key Terminology:
- **Pipeline:** Top-level component encompassing stages and jobs.
- **Stage:** Logical grouping of jobs executed sequentially (e.g., `stages: [test, build, deploy]`). Jobs within the same stage run in parallel.
- **Runner:** Agent registered with GitLab CI to run execution steps inside specified Docker images.

---

### Comparison: GitHub Actions vs GitLab CI

| Feature | GitHub Actions | GitLab CI/CD |
| :--- | :--- | :--- |
| **Config Location** | `.github/workflows/*.yml` | `.gitlab-ci.yml` |
| **Reusability** | Actions (Marketplace / Local) | Includes (`include: local/remote`) |
| **Execution Environment** | Hosted runners / Self-hosted | GitLab Runners (Docker / K8s / Shell) |
| **Secret Ingestion** | Secrets & Variables (Repository/Org) | CI/CD Variables (Protected/Masked) |