# Templates

Ce dossier contient des **templates réutilisables** pour démarrer rapidement de nouveaux projets.

---

## Templates disponibles

### 1. Projet fullstack

**Localisation** : `projet-fullstack/`

**Stack** : React + TypeScript + Node.js + Express + PostgreSQL + Prisma

**Hébergement** : Vercel (frontend) + Railway (backend)

**Usage** :
```bash
cp -r ~/Claude/templates/projet-fullstack ~/Claude/active/mon-projet
cd ~/Claude/active/mon-projet
# Renommer les *.template.md et personnaliser
```

**Idéal pour** : Applications web complètes avec authentification et base de données

---

### 2. Projet frontend

**Localisation** : `projet-frontend/`

**Stack** : React + TypeScript + Vite + TailwindCSS

**Hébergement** : Vercel ou Netlify

**Usage** :
```bash
cp -r ~/Claude/templates/projet-frontend ~/Claude/active/mon-app
cd ~/Claude/active/mon-app
# Renommer les *.template.md et personnaliser
```

**Idéal pour** : SPA, dashboards, applications frontend-only

---

### 3. Projet API REST

**Localisation** : `projet-api/`

**Stack** : Node.js + Express + TypeScript + PostgreSQL + Prisma

**Hébergement** : Railway ou Render

**Usage** :
```bash
cp -r ~/Claude/templates/projet-api ~/Claude/active/mon-api
cd ~/Claude/active/mon-api
# Renommer les *.template.md et personnaliser
```

**Idéal pour** : Backend API, microservices, services métier

---

### 4. Projet CLI

**Localisation** : `projet-cli/`

**Stack** : Node.js + TypeScript + Commander.js

**Distribution** : npm ou binaries standalone

**Usage** :
```bash
cp -r ~/Claude/templates/projet-cli ~/Claude/active/mon-cli
cd ~/Claude/active/mon-cli
# Renommer les *.template.md et personnaliser
```

**Idéal pour** : Outils en ligne de commande, automatisation, dev tools

---

## Utilisation générale

### 1. Copier le template

```bash
cp -r ~/Claude/templates/<template-name> ~/Claude/active/<project-name>
cd ~/Claude/active/<project-name>
```

### 2. Renommer les templates

```bash
mv BRIEF.template.md docs/BRIEF.md
mv STACK.template.md docs/STACK.md
mv CLAUDE.template.md CLAUDE.MD
mv .gitignore.template .gitignore
```

### 3. Remplacer les variables

Rechercher et remplacer dans tous les fichiers :

- `{{PROJECT_NAME}}` → nom-du-projet
- `{{AUTHOR}}` → Votre nom
- `{{DATE}}` → Date du jour (YYYY-MM-DD)
- `{{DESCRIPTION}}` → Description du projet
- Autres variables spécifiques au template

**Astuce VS Code** :
```
Cmd+Shift+F (macOS) ou Ctrl+Shift+F (Windows/Linux)
→ Rechercher : {{PROJECT_NAME}}
→ Remplacer : mon-projet
→ Replace All
```

### 4. Initialiser Git

```bash
git init
git add .
git commit -m "Initial commit - Structure projet

Créé à partir du template <template-name>.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

### 5. Installer les dépendances

```bash
npm install
npm run dev
```

---

## Contenu de chaque template

Chaque template contient :

### Documentation

- `README.MD` : Guide d'utilisation du template
- `BRIEF.template.md` : Cahier des charges à personnaliser
- `STACK.template.md` : Stack technique détaillée
- `CLAUDE.template.md` : Mémoire projet pour Claude Code

### Configuration

- `.gitignore.template` : Fichiers à ignorer par Git
- Variables à remplacer : `{{VAR_NAME}}`

### Structure

- Arborescence de dossiers pré-configurée
- Fichiers de base selon le type de projet

---

## Variables disponibles

Variables communes à tous les templates :

| Variable | Description | Exemple |
|----------|-------------|---------|
| `{{PROJECT_NAME}}` | Nom du projet (kebab-case) | mon-super-projet |
| `{{AUTHOR}}` | Nom de l'auteur | Alex |
| `{{DATE}}` | Date de création (YYYY-MM-DD) | 2026-02-08 |
| `{{DESCRIPTION}}` | Description du projet | Application de gestion de tâches |

Variables spécifiques selon le template (voir README.MD de chaque template).

---

## Créer un nouveau template

Si vous avez une structure de projet qui fonctionne bien :

### 1. Nettoyer le projet

```bash
# Supprimer fichiers spécifiques
rm -rf node_modules/ dist/ .env

# Supprimer données sensibles
```

### 2. Généraliser les configurations

Remplacer les valeurs spécifiques par des variables :

```markdown
# Avant
**Projet** : mon-projet-specifique

# Après
**Projet** : {{PROJECT_NAME}}
```

### 3. Documenter

Créer un `README.MD` expliquant :
- Usage du template
- Stack technique
- Variables à remplacer
- Prochaines étapes

### 4. Copier dans templates/

```bash
cp -r ~/Claude/active/mon-projet ~/Claude/templates/nouveau-template/
```

### 5. Mettre à jour ce README.MD

Ajouter une section décrivant le nouveau template.

---

## Bonnes pratiques

### Templates légers

- **Ne pas inclure** : `node_modules/`, builds, dépendances
- **Inclure** : Structure, configuration, documentation

### Variables claires

- Utiliser `{{VARIABLE}}` pour les placeholders
- Documenter toutes les variables dans le README.MD du template
- Fournir des exemples de valeurs

### Documentation complète

- README.MD : Guide d'utilisation
- BRIEF.template.md : Specs à compléter
- STACK.template.md : Stack détaillée
- CLAUDE.template.md : Mémoire projet

### Mise à jour régulière

- Améliorer les templates avec les learnings de projets
- Mettre à jour les versions des dépendances
- Documenter les changements

---

## Roadmap

Templates futurs à créer :

- `projet-mobile/` : React Native + Expo
- `projet-extension/` : Extension de navigateur
- `projet-electron/` : Application desktop
- `projet-serverless/` : Fonctions serverless (AWS Lambda, Vercel Functions)
- `projet-monorepo/` : Monorepo avec Turborepo ou Nx
- `projet-wordpress/` : Plugin ou thème WordPress
- `projet-lib/` : Bibliothèque npm réutilisable

---

**Dernière mise à jour** : 2026-02-08
**Version** : 1.0.0
