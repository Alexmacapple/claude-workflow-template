# Template projet fullstack

**Type** : Application web fullstack (Frontend + Backend + Base de données)

## Structure

```
projet-fullstack/
├── README.MD                    # Ce fichier
├── BRIEF.template.md            # Template cahier des charges
├── STACK.template.md            # Template stack technique
├── CLAUDE.template.md           # Template mémoire projet
├── .gitignore.template          # Template gitignore
├── frontend/                    # Application frontend
│   ├── src/
│   ├── public/
│   └── package.json.template
├── backend/                     # API backend
│   ├── src/
│   ├── tests/
│   └── package.json.template
└── docs/
    └── ADR/                     # Architecture Decision Records
```

## Stack suggérée

**Frontend** :
- React + TypeScript
- Vite
- TailwindCSS
- React Router
- React Query

**Backend** :
- Node.js + Express
- TypeScript
- PostgreSQL
- Prisma ORM
- JWT Auth

**DevOps** :
- Docker + Docker Compose
- GitHub Actions
- Vercel (frontend)
- Railway (backend)

## Utilisation

### 1. Copier le template

```bash
cp -r ~/Claude/templates/projet-fullstack ~/Claude/active/mon-projet
cd ~/Claude/active/mon-projet
```

### 2. Personnaliser les fichiers

```bash
# Renommer les templates
mv BRIEF.template.md docs/BRIEF.md
mv STACK.template.md docs/STACK.md
mv CLAUDE.template.md CLAUDE.MD
mv .gitignore.template .gitignore

# Remplacer les variables
# {{PROJECT_NAME}} → nom-du-projet
# {{AUTHOR}} → Votre nom
# {{DESCRIPTION}} → Description du projet
```

### 3. Initialiser Git

```bash
git init
git add .
git commit -m "Initial commit - Structure projet fullstack

Créé à partir du template projet-fullstack.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

### 4. Installer les dépendances

```bash
# Frontend
cd frontend
npm install

# Backend
cd ../backend
npm install
```

## Prochaines étapes

1. Compléter `docs/BRIEF.md` avec les specs
2. Finaliser `docs/STACK.md` avec choix techniques
3. Configurer les variables d'environnement dans `claude.local.md`
4. Créer les ADR dans `docs/ADR/`
5. Lancer le développement

## Adaptation

Ce template est un point de départ. Adaptez selon vos besoins :

- Remplacer React par Vue.js ou Svelte
- Utiliser MongoDB au lieu de PostgreSQL
- Ajouter Redis pour le cache
- Implémenter GraphQL au lieu de REST

Documentez vos choix dans les ADR.
