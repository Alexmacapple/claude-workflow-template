# Règles Git

Conventions pour les commits, branches et gestion de version. Cette rule est toujours active (pas de `paths` = chargee systematiquement).

---

## Messages de commit

### Langue : français

Tous les messages de commit doivent être en français.

BON :
```bash
git commit -m "Ajout du système de notifications"
```

MAUVAIS :
```bash
git commit -m "Add notification system"
```

---

### Structure des messages

**Format** :
```
[Type optionnel] Description concise (50 caractères max)

Détails optionnels :
- Point 1
- Point 2
- Point 3
```

**Types recommandés** :
- (Aucun type) : Changement standard
- `Ajout` : Nouvelle fonctionnalité
- `Correction` : Bug fix
- `Refactor` : Refactorisation sans changement fonctionnel
- `Docs` : Documentation uniquement
- `Config` : Configuration, dépendances, setup

BON :
```bash
git commit -m "Ajout du mode YOLO par défaut

Modifications :
- Alias claude dans ~/.zshrc
- Documentation dans CLAUDE.MD
- PRD-001 créé pour tracer la décision"
```

BON (simple) :
```bash
git commit -m "Correction du bug d'authentification"
```

MAUVAIS :
```bash
git commit -m "fixed stuff"
git commit -m "WIP"
git commit -m "aaaaaa"
```

---

### Style

**Impératif présent** (comme si vous donnez un ordre)

BON :
```
Ajoute la fonctionnalité X
Corrige le bug Y
Supprime le fichier Z
```

MAUVAIS :
```
Ajouté la fonctionnalité X (passé)
Ajout de la fonctionnalité X (nom)
J'ai ajouté la fonctionnalité X (personnel)
```

**Pas de point final** à la première ligne

BON :
```
Ajout du système de cache
```

MAUVAIS :
```
Ajout du système de cache.
```

**Première ligne concise** : 50 caractères maximum

**Corps du message** : 72 caractères par ligne maximum

---

### Contenu

**Décrivez le POURQUOI, pas seulement le QUOI**

BON :
```
Optimisation des requêtes base de données

Justification :
- Les requêtes N+1 causaient des timeouts
- Ajout de eager loading pour réduire les requêtes
- Performance améliorée de 60%
```

MAUVAIS :
```
Changements dans le code
```

**Listez les modifications importantes**

BON :
```
Configuration Claude YOLO + Alias zshrc + Structure PRD

Modifications :
- ~/.zshrc : alias claude et alias zshrc
- CLAUDE.MD : section Mode YOLO
- STRUCTURE.txt : nouveaux alias
- prd-meta-workflow/ : PRD-001, README, BACKLOG
```

---

## Commits spéciaux

### Premier commit

```bash
git commit -m "Configuration initiale du workspace Claude

Structure créée :
- CLAUDE.MD, README.MD, STRUCTURE.txt
- .claude/ (skills, agents, rules, commands)
- docs-perso/ et docs-public/
- active/, templates/, archive/"
```

### Merge / Pull

```bash
git commit -m "Fusion de la branche feature-X

Intégration :
- Nouvelle fonctionnalité Y
- Tests ajoutés
- Documentation mise à jour"
```

### Hotfix

```bash
git commit -m "Correction urgente du bug critique Z

Problème :
- Application crashait au démarrage
- Erreur de parsing dans config.json

Solution :
- Validation ajoutée
- Gestion d'erreur améliorée"
```

---

## Branches

### Nommage

**Format** : `type/description-courte`

**Types** :
- `feature/` : Nouvelle fonctionnalité
- `fix/` : Correction de bug
- `refactor/` : Refactorisation
- `docs/` : Documentation
- `config/` : Configuration

BON :
```
feature/notifications
fix/auth-bug
refactor/api-cleanup
docs/readme-update
```

MAUVAIS :
```
nouvelle-feature (pas de type)
FEATURE/NOTIFICATIONS (majuscules)
fix_auth_bug (underscore au lieu de tiret)
```

**Langue** : Français ou anglais (cohérent dans le projet)

---

## .gitignore

### Organisation

Grouper par catégories avec commentaires

BON :
```gitignore
# Claude Code local configurations
claude.local.md
*.local.md

# Documentation personnelle (privée, non versionnée)
docs-perso/

# OS Files
.DS_Store

# IDE
.vscode/
.idea/
```

### Patterns

- Toujours commenter les sections
- Un pattern par ligne
- Paths relatifs à la racine du repo

---

## Bonnes pratiques

### Commits atomiques

Un commit = une modification logique

BON :
- Commit 1 : "Ajout du système de cache"
- Commit 2 : "Mise à jour de la documentation du cache"

MAUVAIS :
- Commit 1 : "Ajout cache + fix bug auth + update readme"

### Commits fréquents

Committer souvent pour :
- Faciliter la review
- Faciliter le rollback
- Historique clair

### Vérifier avant de committer

```bash
git status      # Vérifier les fichiers
git diff        # Vérifier les changements
git add ...     # Ajouter sélectivement
git commit      # Committer avec message clair
```

---

## Application

Ces règles s'appliquent automatiquement quand Claude :
- Crée des commits
- Propose des messages de commit
- Modifie .gitignore
- Gère des branches

Claude doit TOUJOURS respecter ces conventions pour garantir un historique Git propre et cohérent.
