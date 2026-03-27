#!/bin/bash
# scripts/deploy.sh

set -e  # stop en cas d'erreur

# Chemin vers le dossier Terraform
TF_DIR="../infrastructure"

echo "🔹 Initialisation de Terraform..."
cd $TF_DIR
terraform init

echo "🔹 Planification Terraform..."
terraform plan -out=tfplan

echo "🔹 Application Terraform..."
terraform apply tfplan

echo "🔹 Déploiement terminé ✅"

# Optionnel : si tu veux configurer Kubernetes via kubectl ou ArgoCD
# echo "🔹 Déploiement des manifests K8s..."
# kubectl apply -f ../services/k8s/

# Optionnel : lancer scripts de configuration VM ou BDD
# echo "🔹 Configuration des VM..."
# bash ../scripts/config_vm.sh

echo "🚀 Tout est prêt !"
