#!/usr/bin/env bash
set -euo pipefail

# Script idempotent pour synchroniser les labels GitHub depuis labels.yml
# Usage: ./scripts/sync-labels.sh <owner/repo> [--dry-run]

if [ $# -lt 1 ]; then
  echo "Usage: $0 <owner/repo> [--dry-run]"
  exit 1
fi

REPO="$1"
DRY_RUN=false

if [ "${2:-}" = "--dry-run" ]; then
  DRY_RUN=true
  echo "[DRY-RUN] Mode simulation activé"
fi

# Vérifier que gh est installé et authentifié
if ! command -v gh &> /dev/null; then
  echo "Erreur: gh (GitHub CLI) n'est pas installé"
  exit 1
fi

if ! gh auth status &> /dev/null; then
  echo "Erreur: gh n'est pas authentifié. Exécutez 'gh auth login'"
  exit 1
fi

# Vérifier que yq ou python3 est disponible pour parser YAML
if ! command -v python3 &> /dev/null; then
  echo "Erreur: python3 requis pour parser labels.yml"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LABELS_FILE="${SCRIPT_DIR}/../labels.yml"

if [ ! -f "$LABELS_FILE" ]; then
  echo "Erreur: $LABELS_FILE introuvable"
  exit 1
fi

echo "Synchronisation des labels depuis $LABELS_FILE vers $REPO"

# Parser le YAML et appliquer les labels
python3 - "$LABELS_FILE" "$REPO" "$DRY_RUN" << 'PYTHON'
import sys
import json
import subprocess

labels_file = sys.argv[1]
repo = sys.argv[2]
dry_run = sys.argv[3] == 'True'

# Simple parser pour labels.yml (format spécifique)
labels = []
with open(labels_file, 'r', encoding='utf-8') as f:
    content = f.read()
    
# Extraire les labels (nom, couleur, description)
# Format: | `nom` | `couleur` | Description |
for line in content.split('\n'):
    if line.strip().startswith('|') and '`' in line and not line.strip().startswith('| Nom'):
        parts = [p.strip() for p in line.split('|')]
        if len(parts) >= 4:
            name = parts[1].strip('`')
            color = parts[2].strip('`').lstrip('#')
            desc = parts[3].strip()
            if name and color and len(color) == 6 and name != '---':
                labels.append((name, color, desc))

print(f"Nombre de labels à synchroniser: {len(labels)}")

for name, color, desc in labels:
    if dry_run:
        print(f"[DRY-RUN] gh label create/update: {name} #{color} - {desc}")
    else:
        # Essayer de créer, si existe déjà mettre à jour
        result = subprocess.run(
            ['gh', 'label', 'create', name, '--color', color, '--description', desc, '--repo', repo, '--force'],
            capture_output=True,
            text=True
        )
        if result.returncode == 0:
            print(f"✓ {name}")
        else:
            print(f"✗ {name}: {result.stderr.strip()}")
PYTHON

echo "Synchronisation terminée"
