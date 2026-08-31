#!/bin/bash
# Deployment script executed inside the GitLab CI deploy stage
# Script de despliegue ejecutado dentro de la etapa de despliegue de GitLab CI
set -e

ENV="${ENVIRONMENT:-production}"
echo "🚀 Initiating deployment sequence for environment: ${ENV}"
echo "Commit SHA: ${CI_COMMIT_SHORT_SHA}"

# Simulated deployment steps (e.g. triggering webhook or running remote SSH command)
echo "✅ Validating environment variables..."
if [ -z "$CI_REGISTRY_IMAGE" ]; then
    echo "❌ ERROR: CI_REGISTRY_IMAGE is not set."
    exit 1
fi

echo "📦 Pulling latest image: ${CI_REGISTRY_IMAGE}:latest"
echo "🎉 Deployment to ${ENV} completed successfully!"