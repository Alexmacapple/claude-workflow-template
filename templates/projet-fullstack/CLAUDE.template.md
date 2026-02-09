# Mémoire projet - {{PROJECT_NAME}}

**Projet** : {{PROJECT_NAME}}
**Type** : Application web fullstack
**Workspace** : ~/Claude/active/{{PROJECT_NAME}}
**Créé le** : {{DATE}}

---

## Identité du projet

### Vision

{{DESCRIPTION}}

### Objectif

Créer une application web fullstack moderne, performante et maintenable.

**Référence** : Voir `docs/BRIEF.md` pour les specs complètes

---

## Stack technique

**Résumé** :
- Frontend : React + TypeScript + Vite
- Backend : Node.js + Express + TypeScript
- Database : PostgreSQL + Prisma
- Hosting : Vercel (frontend) + Railway (backend)

**Référence complète** : Voir `docs/STACK.md`

---

## Contraintes spécifiques

### Performance

- Lighthouse score > 90
- First Contentful Paint < 1.5s
- Time to Interactive < 3s
- API response time < 200ms

### Accessibilité

- WCAG 2.1 niveau AA
- Support clavier complet
- Screen readers compatibles

### Sécurité

- Authentification JWT
- Protection CSRF
- Rate limiting
- Headers sécurisés (helmet)
- Validation stricte des inputs

### SEO (si applicable)

- Meta tags optimisés
- Structured data
- Sitemap.xml
- robots.txt

---

## Organisation du code

### Structure frontend

```
src/
├── components/
│   ├── ui/              # Composants UI génériques
│   ├── features/        # Composants métier
│   └── layout/          # Layout components
├── pages/               # Pages/Routes
├── hooks/               # Custom hooks
├── api/                 # React Query queries/mutations
├── types/               # TypeScript types
└── utils/               # Fonctions utilitaires
```

### Structure backend

```
src/
├── routes/              # Routes Express
├── controllers/         # Contrôleurs (logique HTTP)
├── services/            # Services métier
├── middlewares/         # Middlewares Express
├── types/               # Types TypeScript
└── prisma/              # Schema et migrations Prisma
```

---

## Conventions de nommage

### Fichiers

- **Composants React** : PascalCase (`UserProfile.tsx`)
- **Hooks** : camelCase avec `use` (`useAuth.ts`)
- **Utils** : camelCase (`formatDate.ts`)
- **Types** : PascalCase (`User.types.ts`)
- **Tests** : même nom + `.test.ts` (`UserProfile.test.tsx`)

### Code

- **Variables/fonctions** : camelCase
- **Constantes** : UPPER_SNAKE_CASE
- **Types/Interfaces** : PascalCase
- **Components** : PascalCase
- **CSS classes** : kebab-case (Tailwind)

### Git

- **Branches** : `feature/nom-feature`, `fix/nom-bug`, `refactor/nom`
- **Commits** : Voir section "Workflow Git" ci-dessous

---

## Workflow de développement

### 1. Créer une feature

```bash
# Créer une branche
git checkout -b feature/user-authentication

# Développer avec Claude Code
# Tester localement
npm run dev          # Frontend
npm run dev          # Backend (autre terminal)

# Tests
npm run test
npm run test:e2e
```

### 2. Tests et validation

```bash
# Frontend
npm run lint
npm run type-check
npm run test
npm run build

# Backend
npm run lint
npm run type-check
npm run test
npm run build
```

### 3. Commits et PR

```bash
git add .
git commit -m "feat: Ajouter authentification utilisateur

Implémente :
- Endpoint /auth/login
- Endpoint /auth/register
- Composant LoginForm
- Hook useAuth

Tests :
- Tests unitaires des endpoints
- Tests E2E du flow d'auth

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

git push origin feature/user-authentication

# Créer PR sur GitHub
gh pr create --title "feat: Ajouter authentification utilisateur" \
  --body "Description de la feature"
```

---

## Workflow Git

### Convention de commits

Format : `<type>(<scope>): <description>`

**Types** :
- `feat` : Nouvelle fonctionnalité
- `fix` : Correction de bug
- `refactor` : Refactorisation (pas de changement fonctionnel)
- `perf` : Amélioration de performance
- `test` : Ajout/modification de tests
- `docs` : Documentation
- `style` : Formatage (pas de changement de code)
- `chore` : Tâches diverses (deps, config, etc.)

**Exemples** :
```
feat(auth): Ajouter login avec JWT
fix(api): Corriger erreur 500 sur /users
refactor(components): Simplifier UserCard
test(auth): Ajouter tests E2E login
docs(readme): Mettre à jour installation
```

### Stratégie de branches

- `main` : Production (protégée)
- `develop` : Développement (protégée)
- `feature/*` : Nouvelles features
- `fix/*` : Corrections de bugs
- `refactor/*` : Refactorisations

**Workflow** :
1. Créer branche depuis `develop`
2. Développer et committer
3. Ouvrir PR vers `develop`
4. Review et merge
5. Déploiement auto sur merge dans `main`

---

## Scripts utiles

### Frontend

```bash
# Développement
npm run dev                  # Serveur de dev (http://localhost:5173)

# Build
npm run build               # Build pour production
npm run preview             # Preview du build

# Tests
npm run test                # Tests unitaires (Vitest)
npm run test:watch          # Tests en mode watch
npm run test:e2e            # Tests E2E (Playwright)

# Quality
npm run lint                # ESLint
npm run type-check          # TypeScript check
npm run format              # Prettier
```

### Backend

```bash
# Développement
npm run dev                 # Serveur de dev avec hot reload

# Build
npm run build              # Compile TypeScript
npm start                  # Lance le build (production)

# Database
npm run prisma:migrate     # Créer migration
npm run prisma:studio      # Interface DB (http://localhost:5555)
npm run prisma:seed        # Seed la DB

# Tests
npm run test               # Tests unitaires (Jest)
npm run test:watch         # Tests en mode watch
npm run test:api           # Tests API (Supertest)

# Quality
npm run lint               # ESLint
npm run type-check         # TypeScript check
npm run format             # Prettier
```

### Docker

```bash
# Développement local complet
docker-compose up          # Lance tous les services

# Rebuild
docker-compose up --build  # Rebuild et lance

# Logs
docker-compose logs -f     # Suivre les logs

# Stop
docker-compose down        # Arrêter tous les services
```

---

## Configuration locale (claude.local.md)

Les secrets et configurations locales sont dans `claude.local.md` (gitignored).

**Template** :
```bash
cp ~/Claude/.claude/claude.local.template.md ./claude.local.md
```

**Contenu typique** :
```markdown
## Credentials

### Database
DATABASE_URL=postgresql://user:password@localhost:5432/{{PROJECT_NAME}}

### JWT
JWT_SECRET=dev-secret-key-change-in-prod

### APIs externes
SENDGRID_API_KEY=xxx
STRIPE_SECRET_KEY=xxx
```

---

## Agents et Rules spécifiques

### Agents du projet

Aucun agent spécifique pour l'instant.

Les agents du workspace (`~/Claude/.claude/agents/`) sont utilisés.

### Rules du projet

Aucune rule spécifique pour l'instant.

Les rules du workspace (`~/Claude/.claude/rules/`) sont utilisées :
- `markdown-rules.md` : Conventions Markdown
- `git-rules.md` : Conventions Git
- `naming-rules.md` : Conventions de nommage

---

## Ressources

### Documentation

- **BRIEF** : `docs/BRIEF.md`
- **STACK** : `docs/STACK.md`
- **ADR** : `docs/ADR/`
- **API Docs** : `docs/api.md` (à créer)

### Liens utiles

- **Repo GitHub** : {{REPO_URL}}
- **Figma** : {{FIGMA_URL}}
- **Démo** : {{DEMO_URL}}
- **Staging** : {{STAGING_URL}}
- **Production** : {{PRODUCTION_URL}}

---

**Dernière mise à jour** : {{DATE}}
**Version** : 1.0.0
