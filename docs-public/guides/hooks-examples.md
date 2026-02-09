# Guide : exemples de hooks Git

**Niveau** : Intermédiaire/Avancé
**Prérequis** : Connaître les bases de Git et bash

---

## Introduction

Ce guide présente des **exemples pratiques** de hooks Git pour automatiser votre workflow.

**Hook existant** : `pre-commit` (validation Markdown)

**Hooks supplémentaires** : pre-push, post-commit, prepare-commit-msg, commit-msg

---

## Hooks disponibles

### Hooks client-side

| Hook | Déclenchement | Usage |
|------|---------------|-------|
| **pre-commit** | Avant commit | Validation, linting, tests |
| **prepare-commit-msg** | Avant édition message | Template commit |
| **commit-msg** | Après édition message | Validation format |
| **post-commit** | Après commit | Notifications, docs |
| **pre-push** | Avant push | Tests complets, build |
| **post-merge** | Après merge | npm install, migrations |

### Hooks server-side

| Hook | Déclenchement | Usage |
|------|---------------|-------|
| **pre-receive** | Avant réception push | Validation serveur |
| **post-receive** | Après réception push | Déploiement, CI/CD |
| **update** | Par branche pushed | Validation par branche |

**Note** : Ce guide se concentre sur hooks **client-side**.

---

## Hook pre-push : Tests avant push

### Objectif

Lancer les tests avant de pusher pour éviter de casser la CI.

### Localisation

`.git-hooks/pre-push` (template versionné)

### Code complet

```bash
#!/bin/bash

# Hook pre-push : Lancer tests avant push
# Localisation : .git/hooks/pre-push

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}[pre-push] Lancement des tests...${NC}"

# Vérifier si package.json existe
if [ ! -f "package.json" ]; then
  echo -e "${YELLOW}[pre-push] Pas de package.json, skip${NC}"
  exit 0
fi

# Vérifier si script test existe
if ! grep -q '"test"' package.json; then
  echo -e "${YELLOW}[pre-push] Pas de script test, skip${NC}"
  exit 0
fi

# Lancer les tests
npm run test

# Vérifier résultat
if [ $? -ne 0 ]; then
  echo -e "${RED}[pre-push] ✗ Tests échoués${NC}"
  echo -e "${YELLOW}Corrigez les tests avant de pusher${NC}"
  echo ""
  echo -e "${YELLOW}Pour bypasser (déconseillé) :${NC}"
  echo "  git push --no-verify"
  exit 1
fi

echo -e "${GREEN}[pre-push] ✓ Tests réussis${NC}"
exit 0
```

### Installation

```bash
# Copier template
cp .git-hooks/pre-push .git/hooks/pre-push

# Rendre exécutable
chmod +x .git/hooks/pre-push
```

### Usage

```bash
git push origin main

# Output:
# [pre-push] Lancement des tests...
# ✓ 42 tests passés
# [pre-push] ✓ Tests réussis
```

### Bypass (si nécessaire)

```bash
git push --no-verify origin main
```

---

## Hook post-commit : Notification

### Objectif

Afficher un message après chaque commit ou mettre à jour documentation.

### Code complet

```bash
#!/bin/bash

# Hook post-commit : Notifications et documentation
# Localisation : .git/hooks/post-commit

# Couleurs
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Récupérer infos du commit
COMMIT_MSG=$(git log -1 --pretty=%B)
COMMIT_HASH=$(git log -1 --pretty=%h)
FILES_CHANGED=$(git diff-tree --no-commit-id --name-only -r HEAD | wc -l)

# Afficher résumé
echo -e "${GREEN}✓ Commit créé : ${COMMIT_HASH}${NC}"
echo -e "${BLUE}Message : ${COMMIT_MSG}${NC}"
echo -e "${BLUE}Fichiers modifiés : ${FILES_CHANGED}${NC}"

# Optionnel : Mettre à jour CHANGELOG automatiquement
if [ -f "CHANGELOG.MD" ]; then
  # Extraire type de commit (feat, fix, docs, etc.)
  COMMIT_TYPE=$(echo "$COMMIT_MSG" | grep -oE "^(feat|fix|docs|style|refactor|test|chore)" || echo "other")

  # Ajouter dans section [Non publié]
  # (Implémentation simplifiée, voir script complet pour version robuste)
  echo -e "${BLUE}CHANGELOG.MD mis à jour (section: ${COMMIT_TYPE})${NC}"
fi

# Optionnel : Notification desktop (macOS)
if command -v osascript &> /dev/null; then
  osascript -e "display notification \"Commit ${COMMIT_HASH} créé\" with title \"Git Commit\""
fi

exit 0
```

### Installation

```bash
cp .git-hooks/post-commit .git/hooks/post-commit
chmod +x .git/hooks/post-commit
```

### Usage

```bash
git commit -m "feat: Ajouter authentification"

# Output:
# ✓ Commit créé : a3f2b1c
# Message : feat: Ajouter authentification
# Fichiers modifiés : 5
# CHANGELOG.MD mis à jour (section: feat)
```

---

## Hook prepare-commit-msg : Template commit

### Objectif

Pré-remplir le message de commit avec un template ou ajouter automatiquement le numéro de ticket.

### Cas d'usage 1 : Template

```bash
#!/bin/bash

# Hook prepare-commit-msg : Template de commit
# Localisation : .git/hooks/prepare-commit-msg

COMMIT_MSG_FILE=$1
COMMIT_SOURCE=$2

# Seulement pour nouveaux commits (pas ammend, merge, etc.)
if [ -z "$COMMIT_SOURCE" ]; then
  # Vérifier si message est vide ou template par défaut
  if ! grep -q "^[a-zA-Z]" "$COMMIT_MSG_FILE"; then
    # Insérer template
    cat > "$COMMIT_MSG_FILE" << 'EOF'
type(scope): Description courte

Description détaillée (optionnel)

Closes #ISSUE_NUMBER

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
  fi
fi
```

### Cas d'usage 2 : Auto-ajout numéro ticket

```bash
#!/bin/bash

# Hook prepare-commit-msg : Ajouter numéro ticket depuis branche
# Localisation : .git/hooks/prepare-commit-msg

COMMIT_MSG_FILE=$1
COMMIT_SOURCE=$2

# Récupérer nom de la branche
BRANCH_NAME=$(git symbolic-ref --short HEAD 2>/dev/null)

# Extraire numéro de ticket (ex: feature/PROJ-123-description)
TICKET=$(echo "$BRANCH_NAME" | grep -oE '[A-Z]+-[0-9]+')

if [ -n "$TICKET" ]; then
  # Vérifier si ticket pas déjà dans message
  if ! grep -q "$TICKET" "$COMMIT_MSG_FILE"; then
    # Ajouter au début du message
    sed -i.bak "1s/^/[$TICKET] /" "$COMMIT_MSG_FILE"
  fi
fi
```

### Installation

```bash
cp .git-hooks/prepare-commit-msg .git/hooks/prepare-commit-msg
chmod +x .git/hooks/prepare-commit-msg
```

### Usage

```bash
# Sur branche feature/PROJ-123-auth
git commit

# Éditeur s'ouvre avec :
# [PROJ-123]
#
# (cursor ici, vous tapez le message)
```

---

## Hook commit-msg : Validation format

### Objectif

Valider que le message de commit respecte un format (ex: Conventional Commits).

### Code complet

```bash
#!/bin/bash

# Hook commit-msg : Valider format Conventional Commits
# Localisation : .git/hooks/commit-msg

COMMIT_MSG_FILE=$1
COMMIT_MSG=$(cat "$COMMIT_MSG_FILE")

# Couleurs
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Pattern Conventional Commits
# Type: feat, fix, docs, style, refactor, test, chore
# Format: type(scope): description
PATTERN="^(feat|fix|docs|style|refactor|test|chore)(\(.+\))?: .{10,}"

# Vérifier format
if ! echo "$COMMIT_MSG" | head -1 | grep -qE "$PATTERN"; then
  echo -e "${RED}✗ Format de commit invalide${NC}"
  echo ""
  echo -e "${YELLOW}Format attendu :${NC}"
  echo "  type(scope): description"
  echo ""
  echo -e "${YELLOW}Types valides :${NC}"
  echo "  feat     : Nouvelle fonctionnalité"
  echo "  fix      : Correction de bug"
  echo "  docs     : Documentation"
  echo "  style    : Formatage (pas de changement de code)"
  echo "  refactor : Refactorisation"
  echo "  test     : Ajout/modification de tests"
  echo "  chore    : Tâches diverses (deps, config)"
  echo ""
  echo -e "${YELLOW}Exemples :${NC}"
  echo "  feat(auth): Ajouter login avec JWT"
  echo "  fix(api): Corriger erreur 500 sur /users"
  echo "  docs(readme): Mettre à jour installation"
  echo ""
  echo -e "${YELLOW}Votre message :${NC}"
  echo "  $COMMIT_MSG"
  echo ""
  echo "Pour bypasser (déconseillé) : git commit --no-verify"
  exit 1
fi

# Vérifier longueur description (> 10 caractères)
DESCRIPTION=$(echo "$COMMIT_MSG" | head -1 | sed 's/^[^:]*: //')
if [ ${#DESCRIPTION} -lt 10 ]; then
  echo -e "${RED}✗ Description trop courte (min 10 caractères)${NC}"
  echo "Description actuelle : $DESCRIPTION (${#DESCRIPTION} caractères)"
  exit 1
fi

# Tout est OK
exit 0
```

### Installation

```bash
cp .git-hooks/commit-msg .git/hooks/commit-msg
chmod +x .git/hooks/commit-msg
```

### Usage

```bash
# Mauvais format
git commit -m "Update README"
# ✗ Format de commit invalide
# Format attendu : type(scope): description

# Bon format
git commit -m "docs(readme): Mettre à jour section installation"
# ✓ Commit créé
```

---

## Hook post-merge : npm install

### Objectif

Lancer `npm install` automatiquement après un merge si package.json a changé.

### Code complet

```bash
#!/bin/bash

# Hook post-merge : npm install si package.json modifié
# Localisation : .git/hooks/post-merge

# Couleurs
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

# Vérifier si package.json a changé
if git diff-tree -r --name-only --no-commit-id ORIG_HEAD HEAD | grep -q "package.json"; then
  echo -e "${BLUE}[post-merge] package.json modifié${NC}"
  echo -e "${BLUE}[post-merge] Lancement de npm install...${NC}"

  npm install

  if [ $? -eq 0 ]; then
    echo -e "${GREEN}[post-merge] ✓ npm install réussi${NC}"
  else
    echo -e "${RED}[post-merge] ✗ npm install échoué${NC}"
    echo "Vérifiez manuellement les dépendances"
  fi
fi

# Vérifier si migrations DB ont changé
if git diff-tree -r --name-only --no-commit-id ORIG_HEAD HEAD | grep -q "prisma/migrations"; then
  echo -e "${BLUE}[post-merge] Migrations détectées${NC}"
  echo -e "${BLUE}[post-merge] Lancement de prisma migrate...${NC}"

  npx prisma migrate dev
fi

exit 0
```

### Installation

```bash
cp .git-hooks/post-merge .git/hooks/post-merge
chmod +x .git/hooks/post-merge
```

### Usage

```bash
git pull origin main

# Output (si package.json modifié):
# [post-merge] package.json modifié
# [post-merge] Lancement de npm install...
# added 5 packages in 2s
# [post-merge] ✓ npm install réussi
```

---

## Hook pre-push avancé : Build + Tests

### Objectif

Vérifier que build et tests passent avant push.

### Code complet

```bash
#!/bin/bash

# Hook pre-push : Build + Tests complets
# Localisation : .git/hooks/pre-push

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}═══════════════════════════════════════${NC}"
echo -e "${BLUE}  Pre-push : Vérifications${NC}"
echo -e "${BLUE}═══════════════════════════════════════${NC}"
echo ""

# 1. Vérifier branche
BRANCH=$(git symbolic-ref --short HEAD)
echo -e "${YELLOW}[1/4] Vérification branche : ${BRANCH}${NC}"

if [ "$BRANCH" = "main" ] || [ "$BRANCH" = "master" ]; then
  echo -e "${YELLOW}  [ATTENTION] Push vers branche principale${NC}"
  read -p "  Confirmer ? (y/N) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}  ✗ Push annulé${NC}"
    exit 1
  fi
fi

echo -e "${GREEN}  ✓ Branche OK${NC}"
echo ""

# 2. Linting
echo -e "${YELLOW}[2/4] Linting...${NC}"
if [ -f "package.json" ] && grep -q '"lint"' package.json; then
  npm run lint --silent
  if [ $? -ne 0 ]; then
    echo -e "${RED}  ✗ Linting échoué${NC}"
    exit 1
  fi
  echo -e "${GREEN}  ✓ Linting OK${NC}"
else
  echo -e "${BLUE}  ⊘ Pas de linting configuré${NC}"
fi
echo ""

# 3. Tests
echo -e "${YELLOW}[3/4] Tests...${NC}"
if [ -f "package.json" ] && grep -q '"test"' package.json; then
  npm run test --silent
  if [ $? -ne 0 ]; then
    echo -e "${RED}  ✗ Tests échoués${NC}"
    exit 1
  fi
  echo -e "${GREEN}  ✓ Tests OK${NC}"
else
  echo -e "${BLUE}  ⊘ Pas de tests configurés${NC}"
fi
echo ""

# 4. Build
echo -e "${YELLOW}[4/4] Build...${NC}"
if [ -f "package.json" ] && grep -q '"build"' package.json; then
  npm run build --silent
  if [ $? -ne 0 ]; then
    echo -e "${RED}  ✗ Build échoué${NC}"
    exit 1
  fi
  echo -e "${GREEN}  ✓ Build OK${NC}"
else
  echo -e "${BLUE}  ⊘ Pas de build configuré${NC}"
fi
echo ""

echo -e "${GREEN}═══════════════════════════════════════${NC}"
echo -e "${GREEN}  ✓ Toutes vérifications OK${NC}"
echo -e "${GREEN}═══════════════════════════════════════${NC}"

exit 0
```

---

## Intégration CI/CD

### Réutiliser hooks en CI

Les hooks Git peuvent être réutilisés dans votre pipeline CI/CD.

### Exemple GitHub Actions

```yaml
# .github/workflows/ci.yml
name: CI

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: 20

      - name: Install dependencies
        run: npm ci

      - name: Run pre-push checks
        run: |
          # Réutiliser logique du hook pre-push
          npm run lint
          npm run test
          npm run build
```

### Exemple : Valider commits

```yaml
# .github/workflows/commit-lint.yml
name: Commit Lint

on: [pull_request]

jobs:
  commitlint:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0

      - name: Validate commit messages
        run: |
          # Réutiliser logique du hook commit-msg
          for commit in $(git rev-list origin/main..HEAD); do
            MSG=$(git log --format=%B -n 1 $commit)
            if ! echo "$MSG" | grep -qE "^(feat|fix|docs|style|refactor|test|chore)(\(.+\))?: .{10,}"; then
              echo "✗ Invalid commit: $commit"
              echo "Message: $MSG"
              exit 1
            fi
          done
          echo "✓ All commits valid"
```

---

## Installation globale

### Créer dossier de templates

```bash
mkdir -p ~/.git-templates/hooks
```

### Copier hooks

```bash
cp ~/Claude/.git-hooks/* ~/.git-templates/hooks/
```

### Configurer Git

```bash
git config --global init.templateDir ~/.git-templates
```

### Usage

Tous les **nouveaux** repos auront automatiquement les hooks :

```bash
git init mon-nouveau-projet
# Les hooks sont déjà installés !
```

**Note** : Pour repos existants, relancer `cp .git-hooks/* .git/hooks/`

---

## Checklist installation hook

Avant de finaliser un hook :

- [ ] Créé dans `.git-hooks/` (template versionné)
- [ ] Copié vers `.git/hooks/` (hook actif)
- [ ] Rendu exécutable (`chmod +x`)
- [ ] Testé manuellement (`.git/hooks/hook-name`)
- [ ] Testé dans workflow Git
- [ ] Documenté dans ce guide
- [ ] Messages clairs et colorés
- [ ] Option bypass documentée (`--no-verify`)

---

## Ressources

- **Documentation Git Hooks** : https://git-scm.com/docs/githooks
- **Conventional Commits** : https://www.conventionalcommits.org/
- **Hook existant** : `.git-hooks/pre-commit` (validation Markdown)
- **Guide général** : `git-hooks-guide.md`

---

**Dernière mise à jour** : 2026-02-08
