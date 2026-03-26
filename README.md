# DiscordTranslator

Plateforme microservices pour traduction et traitement de messages/audio Discord.

## Architecture cible

- `services/`
  - `bot-discord`
  - `fastapi-gateway`
  - `asr-engine`
  - `spark-processor`
  - `kafka-broker`
- `infrastructure/terraform`: provisionning AWS (VPC, EKS, S3)
- `infrastructure/k8s`: déploiement Kubernetes (`base` + `overlays/dev|preprod|prod`)
- `cicd/jenkins`: build et promotion d'images
- `cicd/argocd`: déploiement GitOps vers Kubernetes
- `cicd/rundeck`: runbooks opérationnels (restart, relance)

## CI/CD

- Jenkins construit et pousse les images, puis met à jour les overlays.
- ArgoCD synchronise l'état du cluster depuis Git.
- Rundeck exécute des opérations manuelles encadrées (RBAC namespace).

## Environnements

- `dev`: expérimentation rapide
- `preprod`: validation avant production
- `prod`: environnement utilisateur stable

## Note importante

Le fichier `infrastructure/docker-compose.yml` est conservé pour historique local, mais la source de vérité de déploiement est Kubernetes dans `infrastructure/k8s`.
