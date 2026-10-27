# Contributing

Merci de votre intérêt pour les projets de **tozano-ai-labs** ! Ce document décrit le processus de contribution en mode **InnerSource**.

## Modèle "trusted committer"

- **Trusted committer** : seul le propriétaire du dépôt (moi) a les droits de fusion. 
- Les contributions externes sont bienvenues sous forme de *Pull Requests* depuis un fork ou une branche selon les autorisations.
- **Fusion manuelle uniquement**. Aucun *auto-merge*. 
- **Mode de fusion cible** : *squash*. Le titre de la PR devient le message de commit sur `main` et **doit** respecter le format de commit ci-dessous.

## Comment proposer un changement

1. Créez une branche à partir de `main` (dans votre fork ou selon les règles du dépôt).
2. Implémentez votre changement en respectant les règles du dépôt.
3. Ajoutez ou mettez à jour les tests si nécessaire.
4. Ouvrez une Pull Request en utilisant le modèle fourni (`PULL_REQUEST_TEMPLATE.md`).
5. Un *trusted committer* relira et fusionnera manuellement.

## Format des commits et des titres de PR

Tous les commits et titres de PR doivent respecter le format défini dans **[ai-template](https://github.com/tozano-ai-labs/ai-template)** :

```text
<gitmoji> <type>(<scope>): <description>
```

- **Gitmoji** en premier (cf. table dans ai-template)
- **Type** : `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `perf`, `style`, `build`, `ci`, `security`, `revert`, `i18n`, `logs`
- **Scope** : nomme l'étape de développement ou le module (`api`, `ui`, `stream`, `deps`, `build`, `docker`, `ia`, `rgpd`, `docs`, ...)
- **Description** : en anglais, impératif, sans point final, 72 caractères max
- **Un changement logique par commit**

Voir `ai-template/docs/commits.md` et le skill `commit-message` pour plus de détails.

## Règles importantes

- **L'IA ne pousse jamais.** Les agents IA préparent le code et les commits, mais ne poussent pas vers le dépôt distant.
- **Aucun changement sans test.** Y compris pour les dépôts de configuration (prévoir une validation automatisée).
- **Aucun secret en clair.** Utilisez les variables d'environnement.
- **Squash obligatoire.** Le titre de la PR doit donc être parfaitement formaté car il deviendra le message de commit sur `main`.
- **Dependabot** : les PR Dependabot sont fusionnées manuellement, aucun *auto-merge*.
- **RGPD** : soyez attentif aux données personnelles, aux prompts/logs IA.

## Ressources

- [ai-template](https://github.com/tozano-ai-labs/ai-template) - Règles communes et templates
- [Issues](https://github.com/tozano-ai-labs) - Signaler des bugs ou proposer des fonctionnalités
- [Discussions](https://github.com/orgs/tozano-ai-labs/discussions) - Questions et discussions générales
