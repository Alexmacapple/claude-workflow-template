# Mon Premier Projet avec Claude - Guide Pratique

**Guide pas-à-pas pour créer et gérer votre premier projet dans le workspace Claude**

---

## Objectif

Ce guide vous accompagne dans la création de votre premier projet en utilisant le workflow Claude optimisé avec :
- Architecture en 3 niveaux (Skills → Agents → Rules)
- Mémoire hiérarchique
- Commandes personnalisées
- Bonnes pratiques documentées

---

## Prérequis

- Workspace Claude créé dans `~/Claude/`
- Claude Code installé et à jour (v2.1.37+)
- Mémoire personnelle créée (`~/.claude/CLAUDE.MD`)
- Documentation lue (`~/Claude/README.MD` et `~/Claude/CLAUDE.MD`)

---

## Étape 1 : se positionner dans le workspace

```bash
cd ~/Claude
```

**Vérification** :
```bash
pwd
# Devrait afficher le chemin de votre workspace (ex: /Users/votrenom/Claude)

ls -la
# Devrait montrer : README.md, claude.md, active/, .claude/, etc.
```

---

## Étape 2 : initialiser votre premier projet

### Option A : avec la commande /init (recommandé)

Dans Claude Code, exécutez :

```
/init mon-premier-projet
```

La commande va vous demander :
1. **Nom du projet** : `mon-premier-projet` (kebab-case)
2. **Description** : Ex: "Application web pour gérer mes tâches quotidiennes"
3. **Type de projet** : Ex: "web app"
4. **Stack technique** : Ex: "Node.js, React, PostgreSQL"

**Résultat** : Structure complète créée automatiquement dans `~/Claude/active/mon-premier-projet/`

### Option B : création manuelle

Si vous préférez créer manuellement :

```bash
mkdir -p ~/Claude/active/mon-premier-projet/{docs/ADR,src,tests,.claude/{agents,rules}}
cd ~/Claude/active/mon-premier-projet
```

---

## Étape 3 : définir les spécifications

### 3.1 créer le BRIEF (cahier des charges)

**Fichier** : `~/Claude/active/mon-premier-projet/docs/BRIEF.md`

```markdown
# BRIEF - Mon Premier Projet

## Contexte
Pourquoi ce projet existe ? Quel problème résout-il ?

Exemple :
> J'ai besoin d'une application pour suivre mes tâches quotidiennes
> car les outils existants sont trop complexes pour mes besoins.

## Objectifs
Que doit accomplir le projet ?

1. Créer, modifier, supprimer des tâches
2. Organiser par catégories
3. Interface simple et rapide
4. Accessible depuis mobile et desktop

## Fonctionnalités attendues

### MVP (Version 1)
- [ ] CRUD de tâches (Create, Read, Update, Delete)
- [ ] Catégorisation simple
- [ ] Interface responsive

### Future (Version 2+)
- [ ] Partage de listes
- [ ] Rappels/notifications
- [ ] Mode hors-ligne

## Contraintes
- Budget : Personnel (gratuit autant que possible)
- Délai : 2 semaines
- Compétences : Débutant en React, intermédiaire en JavaScript

## Critères de Succès
Comment savoir que le projet est réussi ?

- Je peux gérer mes tâches quotidiennes sans friction
- Le temps de chargement est < 2 secondes
- Utilisable sur mobile et desktop
- Code maintenable et testé

## Non-Objectifs
Ce que le projet NE fait PAS (pour éviter le scope creep)

- Collaboration temps-réel
- Intelligence artificielle
- Intégration avec 50 services externes
```

### 3.2 définir la STACK technique

**Fichier** : `~/Claude/active/mon-premier-projet/docs/STACK.md`

```markdown
# Stack Technique - Mon Premier Projet

## Frontend
- **Framework** : React 18.x
- **Styling** : TailwindCSS
- **State** : React Context API (simple pour MVP)
- **Build** : Vite

## Backend
- **Runtime** : Node.js 20.x
- **Framework** : Express.js
- **Base de données** : PostgreSQL 15
- **ORM** : Prisma

## DevOps & Outils
- **Package Manager** : npm
- **Linter** : ESLint
- **Formatter** : Prettier
- **Tests** : Vitest (frontend), Jest (backend)
- **Git** : GitHub
- **CI/CD** : GitHub Actions

## Architecture
- **Pattern** : REST API
- **Structure** : Monorepo (frontend + backend)

```
monorepo/
├── client/          # React app
├── server/          # Express API
└── shared/          # Code partagé (types, utils)
```

## Hébergement
- **Frontend** : Vercel (gratuit)
- **Backend** : Railway ou Render (gratuit)
- **Database** : Supabase (gratuit)

## Justifications

### Pourquoi React ?
- Compétences existantes
- Écosystème riche
- Bon pour MVP rapide

### Pourquoi PostgreSQL ?
- Relationnel = meilleur pour ce cas d'usage
- Gratuit sur Supabase
- Fiable et scalable

### Pourquoi Vite ?
- Plus rapide que Create React App
- Meilleure DX (Developer Experience)
- Config minimale
```

---

## Étape 4 : créer le claude.md local du projet

**Fichier** : `~/Claude/active/mon-premier-projet/claude.md`

```markdown
# Mon Premier Projet - Mémoire Projet

**Hérite de** :
- `~/.claude/CLAUDE.MD` (mémoire personnelle - conventions universelles)
- `~/Claude/CLAUDE.MD` (mémoire workspace - workflow spécifique)

## Identité du Projet

- **Nom** : Mon Premier Projet
- **Type** : Application web full-stack
- **Statut** : En développement (MVP)
- **Créé le** : 2026-02-08

## Vision

Application simple de gestion de tâches quotidiennes, sans complexité inutile.

## Stack

Voir `docs/STACK.md` pour détails complets.

**Résumé** :
- Frontend : React + Vite + TailwindCSS
- Backend : Node.js + Express + PostgreSQL
- Tests : Vitest + Jest

## Contraintes spécifiques

### Performance
- Chargement initial < 2s
- Interactions < 100ms

### Accessibilité
- WCAG AA minimum
- Navigation au clavier complète

### Sécurité
- Validation des inputs (frontend + backend)
- Protection CSRF
- Rate limiting sur l'API

## Organisation du Code

```
src/
├── client/
│   ├── components/      # Composants React
│   ├── hooks/          # Custom hooks
│   ├── pages/          # Pages de l'app
│   ├── services/       # API calls
│   └── utils/          # Utilitaires
├── server/
│   ├── routes/         # Routes Express
│   ├── controllers/    # Logique métier
│   ├── models/         # Modèles Prisma
│   ├── middleware/     # Middlewares
│   └── utils/          # Utilitaires
└── shared/
    ├── types/          # Types TypeScript partagés
    └── constants/      # Constants partagées
```

## Conventions de Nommage

### Composants React
- PascalCase : `TaskList.jsx`, `TaskItem.jsx`
- Un composant = un fichier

### Fonctions/Variables
- camelCase : `fetchTasks()`, `userId`

### Routes API
- kebab-case : `/api/tasks`, `/api/user-profile`

### Base de données
- snake_case : `user_id`, `created_at`

## Workflow de Développement

1. **Feature** → Créer branche `feature/nom-feature`
2. **Dev** → Développer avec tests
3. **Test** → Tous les tests passent
4. **Review** → Auto-review ou peer review
5. **Merge** → Merge dans `main`
6. **Deploy** → Auto-deploy via CI/CD

## Documentation

Toutes les décisions architecturales importantes sont documentées dans `docs/ADR/`.

Format ADR :
```
docs/ADR/
├── 001-choix-react.md
├── 002-structure-monorepo.md
└── 003-prisma-orm.md
```

## Dépendances clés

### Frontend
```json
{
  "react": "^18.2.0",
  "react-router-dom": "^6.20.0",
  "tailwindcss": "^3.4.0"
}
```

### Backend
```json
{
  "express": "^4.18.0",
  "prisma": "^5.7.0",
  "@prisma/client": "^5.7.0"
}
```

## Scripts utiles

```bash
# Installation
npm install

# Dev (lance frontend + backend)
npm run dev

# Tests
npm test

# Build
npm run build

# Lint
npm run lint
```

## Prochaines Étapes

- [ ] Setup initial du projet (npm, git)
- [ ] Configuration Prisma + PostgreSQL
- [ ] Création du schéma de base de données
- [ ] Setup React + Vite
- [ ] Premier composant TaskList
- [ ] Première route API `/api/tasks`
- [ ] Tests unitaires
- [ ] Déploiement MVP

## Notes de Développement

Utilisez `claude.local.md` (gitignored) pour vos notes personnelles,
credentials, et configurations locales.

**Template disponible** : `~/Claude/.claude/claude.local.template.md`
```bash
cp ~/Claude/.claude/claude.local.template.md ./claude.local.md
```

---

**Dernière mise à jour** : 2026-02-08
```

---

## Étape 5 : initialiser Git

```bash
cd ~/Claude/active/mon-premier-projet

# Initialiser Git
git init

# Créer .gitignore
cat > .gitignore << 'EOF'
# Voir ~/Claude/.gitignore pour la version globale

# Node
node_modules/
npm-debug.log*

# Environment
.env
.env.local
*.env

# Claude local
claude.local.md

# Build
dist/
build/

# IDE
.vscode/
.idea/

# OS
.DS_Store
EOF

# Premier commit
git add .
git commit -m "Initial commit: project structure

- Setup project structure
- Add BRIEF and STACK documentation
- Configure claude.md for project-specific rules"
```

---

## Étape 6 : développer avec Claude Code

### 6.1 utiliser la mémoire hiérarchique

Quand vous êtes dans `~/Claude/active/mon-premier-projet/`, Claude Code charge automatiquement :

1. **Mémoire personnelle** : `~/.claude/CLAUDE.MD` (conventions universelles)
2. **Mémoire workspace** : `~/Claude/CLAUDE.MD` (workflow spécifique)
3. **Mémoire projet** : `./CLAUDE.MD` ← **Surcharge**
4. **Mémoire locale** : `./claude.local.md` (si existe)

### 6.2 workflow de développement

#### Demander à Claude de développer une feature

```
Claude, je veux développer la fonctionnalité de création de tâches.

Voici le contexte :
- Voir docs/BRIEF.md pour les specs
- Voir docs/STACK.md pour la stack technique
- Voir claude.md pour les conventions du projet

Crée :
1. Le modèle Prisma pour les tâches
2. La route API POST /api/tasks
3. Le composant React TaskForm
4. Les tests unitaires

Respecte les conventions définies dans claude.md.
```

Claude aura accès à **toute votre documentation** via la mémoire hiérarchique !

#### Créer une rule pour votre projet

Si vous avez des contraintes spécifiques (ex: toujours valider avec Zod), créez une rule :

**Fichier** : `~/Claude/active/mon-premier-projet/.claude/rules/validation-rules.md`

```markdown
---
name: validation-rules
description: Règles de validation pour ce projet
paths:
  - "src/server/routes/**"
  - "src/server/controllers/**"
---

# Règles de Validation

## Principe

TOUTE donnée entrante doit être validée avec Zod avant traitement.

## Convention

```javascript
// BON
const taskSchema = z.object({
  title: z.string().min(1).max(200),
  categoryId: z.string().uuid()
})

app.post('/api/tasks', (req, res) => {
  const validated = taskSchema.parse(req.body)
  // ... traitement
})

// MAUVAIS
app.post('/api/tasks', (req, res) => {
  const { title, categoryId } = req.body // Pas de validation !
  // ... traitement
})
```

## Erreurs de Validation

Retourner toujours un format cohérent :

```javascript
{
  "error": "Validation failed",
  "details": [
    { "field": "title", "message": "Title is required" }
  ]
}
```
```

Maintenant, quand Claude Code travaille sur des fichiers dans `src/server/routes/`, cette rule sera **automatiquement chargée** !

---

## Étape 7 : documenter les décisions (ADR)

Chaque décision architecturale importante doit être documentée dans un ADR (Architecture Decision Record).

**Format** : `docs/ADR/XXX-titre-decision.md`

**Exemple** : `docs/ADR/001-choix-react.md`

```markdown
# ADR 001 : Choix de React pour le Frontend

## Statut
Accepté

## Contexte
Nous devons choisir un framework frontend pour construire l'interface utilisateur.

Options considérées :
- React
- Vue.js
- Svelte
- Vanilla JS

## Décision
Nous utilisons **React 18.x** pour le frontend.

## Justification

### Pour React
- Compétences existantes de l'équipe (moi)
- Écosystème très riche (librairies, outils)
- Bon pour MVP rapide
- Documentation excellente
- Grande communauté

### Contre alternatives
- **Vue.js** : Moins de compétences existantes
- **Svelte** : Écosystème plus petit, moins mature
- **Vanilla JS** : Trop de code boilerplate pour ce projet

## Conséquences

### Positives
- Développement rapide grâce aux compétences existantes
- Accès à un large écosystème de composants
- Facilite le recrutement futur si besoin

### Négatives
- Bundle size plus grand que Svelte
- Courbe d'apprentissage pour les hooks modernes

### Mitigations
- Utiliser React.lazy() pour code splitting
- Documenter les patterns React utilisés

## Date
2026-02-08

## Auteur
Alex
```

---

## Étape 8 : tester et valider

### 8.1 écrire des tests

Pour chaque fonctionnalité, écrivez des tests :

```bash
tests/
├── unit/
│   ├── components/
│   │   └── TaskList.test.jsx
│   └── services/
│       └── taskService.test.js
└── integration/
    └── api/
        └── tasks.test.js
```

### 8.2 lancer les tests

```bash
npm test
```

### 8.3 demander à Claude de vous aider

```
Claude, crée des tests unitaires pour le composant TaskList.

Contexte :
- Le composant affiche une liste de tâches
- Il reçoit les tâches en props
- Il gère le clic sur "supprimer"

Utilise Vitest et React Testing Library selon nos conventions (voir claude.md).
```

---

## Étape 9 : déployer

### 9.1 préparer pour la production

```bash
# Build
npm run build

# Tester le build localement
npm run preview
```

### 9.2 déployer

**Frontend (Vercel)** :
```bash
npm install -g vercel
vercel login
vercel --prod
```

**Backend (Railway)** :
```bash
# Suivre les instructions sur railway.app
```

### 9.3 documenter le déploiement

Ajoutez dans le README :

```markdown
## Déploiement

- **Frontend** : https://mon-projet.vercel.app
- **Backend** : https://mon-projet.railway.app
- **Database** : Supabase (PostgreSQL)

### Variables d'environnement

```env
DATABASE_URL=postgresql://...
API_URL=https://mon-projet.railway.app
```
```

---

## Étape 10 : archiver (quand terminé)

Une fois le projet terminé :

### 10.1 finaliser la documentation

- Compléter le README avec bilan final
- Documenter les leçons apprises
- Finaliser tous les ADR en cours

### 10.2 ajouter un bilan

Dans le README, ajoutez :

```markdown
## Bilan final

**Archivé le** : 2026-XX-XX
**Statut** : Complété / En production / Pause / Abandonné

### Ce qui a bien fonctionné
- Architecture claire dès le départ
- Documentation continue (ADR)
- Tests écrits en même temps que le code

### Ce qui aurait pu être mieux
- Sous-estimation du temps pour le responsive
- Manque de tests E2E

### Leçons apprises
- Toujours partir d'un BRIEF clair
- La mémoire hiérarchique de Claude Code est très puissante
- Les ADR évitent les remises en question constantes

### Métriques
- Durée : 2 semaines
- Lignes de code : ~5000
- Couverture de tests : 85%
- Temps de chargement : 1.2s
```

### 10.3 archiver

```bash
# Nettoyer
rm -rf node_modules/
rm -rf .env*

# Déplacer
mv ~/Claude/active/mon-premier-projet ~/Claude/archive/

# Optionnel : compresser
cd ~/Claude/archive
tar -czf mon-premier-projet-2026-02-08.tar.gz mon-premier-projet/
```

---

## Récapitulatif des bonnes pratiques

### À faire

1. **Toujours partir d'un BRIEF** (docs/BRIEF.md)
2. **Définir la STACK avant de coder** (docs/STACK.md)
3. **Utiliser la mémoire hiérarchique** (claude.md à chaque niveau)
4. **Documenter les décisions** (ADR)
5. **Tester au fur et à mesure**
6. **Commiter régulièrement** avec messages clairs
7. **Créer des rules** pour les contraintes spécifiques
8. **Archiver proprement** quand terminé

### À éviter

1. **Coder sans spec** → Scope creep garanti
2. **Ignorer la documentation** → Perte de contexte
3. **Pas de tests** → Dette technique
4. **Tout dans claude.md global** → Pollution du contexte
5. **Commiter claude.local.md** → Fuite de données sensibles
6. **Laisser des projets morts dans active/** → Désordre

---

## Commandes utiles

### Navigation
```bash
# Aller au workspace
cd ~/Claude

# Aller au projet
cd ~/Claude/active/mon-premier-projet
```

### Documentation
```bash
# Visualiser la structure
cat ~/Claude/STRUCTURE.txt

# Lire la mémoire personnelle
cat ~/.claude/CLAUDE.MD

# Lire la mémoire workspace
cat ~/Claude/CLAUDE.MD

# Lire la mémoire du projet
cat CLAUDE.MD
```

### Git
```bash
# Status
git status

# Commit
git add .
git commit -m "feat: add task creation feature"

# Push
git push origin main
```

---

## Ressources

### Documentation workspace
- `~/Claude/README.MD` - Vue d'ensemble
- `~/.claude/CLAUDE.MD` - Mémoire personnelle (conventions universelles)
- `~/Claude/CLAUDE.MD` - Mémoire workspace (workflow spécifique)
- `~/Claude/.claude/claude.local.template.md` - Template de mémoire locale
- `~/Claude/STRUCTURE.txt` - Visualisation de la structure

### Documentation Claude Code
- [Documentation officielle](https://docs.claude.com/claude-code)
- [Skills](https://docs.claude.com/claude-code/skills)
- [Agents](https://docs.claude.com/claude-code/agents)
- [Rules](https://docs.claude.com/claude-code/rules)

### Templates
Explorez `~/Claude/templates/` pour des structures de projets prêtes à l'emploi.

---

## FAQ

### Q: Comment savoir quels fichiers Claude Code va charger ?

**R:** Claude Code remonte l'arborescence depuis votre `cwd` et charge :
1. Mémoire personnelle (`~/.claude/CLAUDE.MD`)
2. Mémoire workspace (`~/Claude/CLAUDE.MD`)
3. Mémoire projet (`./CLAUDE.MD`)
4. Mémoire locale (`./claude.local.md` si existe)
5. Rules selon les `paths:` définis

### Q: Que mettre dans claude.local.md ?

**R:** Tout ce qui est **personnel et non versionné** :
- Credentials et tokens
- Notes de développement perso
- Configs locales spécifiques
- Expérimentations

**Template disponible** : `~/Claude/.claude/claude.local.template.md`

### Q: Quand créer un Agent vs une Rule ?

**R:**
- **Agent** : Pour une tâche **active** (exécute du code, analyse, transforme)
- **Rule** : Pour des **contraintes passives** (standards, conventions, bonnes pratiques)

### Q: Comment utiliser /init si la commande n'existe pas encore ?

**R:** La commande `/init` est définie dans `~/Claude/.claude/commands/init.md`. Claude Code la détectera automatiquement quand vous serez dans le workspace `~/Claude/`.

---

## Félicitations !

Vous savez maintenant comment :
- Créer un projet structuré
- Utiliser la mémoire hiérarchique
- Documenter avec BRIEF, STACK et ADR
- Créer des rules et agents custom
- Développer avec Claude Code efficacement
- Archiver proprement

**Prochain pas** : Créez votre premier projet !

```bash
cd ~/Claude
/init mon-premier-projet
```

Bon développement !

---

**Créé le** : 2026-02-08
**Version** : 1.0.0
**Auteur** : Alex
