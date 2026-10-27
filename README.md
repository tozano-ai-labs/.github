# README

Ce dépôt `.github` est le dépôt organisationnel spécial de **tozano-ai-labs**. Il centralise la configuration commune à tous les dépôts de l'organisation.

## Ce qui est hérité par les autres dépôts

GitHub applique automatiquement certains fichiers depuis le dépôt `.github` de l'organisation :

| Fichier/élément | Héritage | Description |
| --- | --- | --- |
| `PULL_REQUEST_TEMPLATE.md` | Automatique | Modèle de Pull Request utilisé par défaut dans tous les dépôts de l'organisation |
| `CONTRIBUTING.md` | Automatique | Guide de contribution affiché dans certains contextes GitHub |
| `SECURITY.md` | Automatique | Politique de sécurité affichée dans l'onglet Security |
| `CODE_OF_CONDUCT.md` | Automatique | Code de conduite de l'organisation |
| `SUPPORT.md` | Automatique | Guide de support |
| `profile/README.md` | Automatique | Affiché sur la page d'accueil de l'organisation |
| `.github/ISSUE_TEMPLATE/*` | Automatique | Modèles d'issues disponibles dans tous les dépôts |
| `.github/FUNDING.yml` | Automatique | Liens de financement (si présent) |

## Ce qui N'EST PAS hérité automatiquement

Certains éléments doivent être copiés ou appliqués manuellement :

| Élément | Statut | Notes |
| --- | --- | --- |
| `labels.yml` | Manuel | Doit être appliqué via `scripts/sync-labels.sh` à chaque dépôt |
| `scripts/sync-labels.sh` | Manuel | Script d'application des labels, à utiliser localement ou dans un workflow dédié |
| `workflows/*.yml` | Manuel | Les workflows ne sont pas automatiquement hérités. Utiliser `shared-workflows` pour des workflows réutilisables |
| `.yamllint.yml` | Manuel | Configuration locale par dépôt si nécessaire |
| Règles de branches/protections | Manuel | Configurées dans les paramètres GitHub de chaque dépôt |

## Structure

```text
.github/
├── .github/
│   ├── ISSUE_TEMPLATE/     # Modèles d'issues (bug.yml, feature.yml, config.yml)
│   └── workflows/          # Workflows CI de ce dépôt
├── profile/
│   └── README.md           # README de l'organisation
├── scripts/
│   └── sync-labels.sh      # Script d'application des labels
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
│   labels.yml              # Définition des labels standard
│   PULL_REQUEST_TEMPLATE.md
│   README.md               # Ce fichier
│   SECURITY.md
│   SUPPORT.md
```

## Utilisation

### Appliquer les labels à un dépôt

```bash
./scripts/sync-labels.sh owner/repo
./scripts/sync-labels.sh owner/repo --dry-run  # Simulation
```

Prérequis : [GitHub CLI](https://cli.github.com/) installé et authentifié (`gh auth login`).

### Bonnes pratiques

- Ce dépôt est public (recommandé pour un dépôt `.github` d'organisation)
- Les modifications sont appliquées manuellement aux dépôts existants selon les besoins
- Les règles communes sont définies dans [ai-template](https://github.com/tozano-ai-labs/ai-template)
- Mode de fusion : **squash** obligatoire
- **Aucun auto-merge** (y compris Dependabot)
- **L'IA ne pousse jamais**
