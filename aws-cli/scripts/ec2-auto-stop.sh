#!/bin/bash
# Cost optimization script to stop non-production EC2 instances
# Optimización de costos: script para detener instancias EC2 no productivas

ENVIRONMENT_TAG="dev"

echo "🔍 Locating running EC2 instances with Environment=${ENVIRONMENT_TAG}..."

INSTANCE_IDS=$(aws ec2 describe-instances \
  --filters "Name=tag:Environment,Values=${ENVIRONMENT_TAG}" "Name=instance-state-name,Values=running" \
  --query "Reservations[*].Instances[*].InstanceId" \
  --output text)

if [ -n "$INSTANCE_IDS" ]; then
    echo "🛑 Stopping instances: $INSTANCE_IDS"
    aws ec2 stop-instances --instance-ids $INSTANCE_IDS
else
    echo "✅ No running instances found to stop."
fi