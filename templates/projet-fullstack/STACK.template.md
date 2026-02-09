# Stack technique - {{PROJECT_NAME}}

**Projet** : {{PROJECT_NAME}}
**Type** : Application web fullstack
**Dernière mise à jour** : {{DATE}}

---

## Vue d'ensemble

### Architecture

```
┌─────────────┐
│   Frontend  │  React + TypeScript + Vite
│   (Vercel)  │
└──────┬──────┘
       │ HTTPS/REST
       │
┌──────▼──────┐
│   Backend   │  Node.js + Express + TypeScript
│  (Railway)  │
└──────┬──────┘
       │
┌──────▼──────┐
│  Database   │  PostgreSQL + Prisma
│  (Railway)  │
└─────────────┘
```

---

## Frontend

### Framework et langages

- **React 18** : UI library
- **TypeScript 5** : Typage statique
- **Vite 5** : Build tool moderne et rapide

### UI et styling

- **TailwindCSS 3** : Utility-first CSS
- **Headless UI** : Composants accessibles
- **Heroicons** : Icônes
- **Framer Motion** : Animations (optionnel)

### State management et data fetching

- **React Query (TanStack Query)** : Server state
- **Zustand** : Client state (si nécessaire)
- **React Hook Form** : Gestion des formulaires
- **Zod** : Validation des schémas

### Routing

- **React Router v6** : Routing client-side

### Outils de développement

- **ESLint** : Linting
- **Prettier** : Formatage
- **Vitest** : Tests unitaires
- **Playwright** : Tests E2E

---

## Backend

### Runtime et framework

- **Node.js 20 LTS** : Runtime JavaScript
- **Express 4** : Web framework
- **TypeScript 5** : Typage statique

### Base de données et ORM

- **PostgreSQL 16** : Base de données relationnelle
- **Prisma 5** : ORM moderne avec type safety
- **Redis** (optionnel) : Cache et sessions

### Authentification

- **JWT** : Tokens d'authentification
- **bcrypt** : Hashing des mots de passe
- **Passport.js** (optionnel) : Stratégies d'auth

### Validation et sécurité

- **Zod** : Validation des requêtes
- **helmet** : Sécurité headers HTTP
- **express-rate-limit** : Rate limiting
- **cors** : Configuration CORS

### Outils de développement

- **ts-node-dev** : Dev server avec hot reload
- **Jest** : Tests unitaires
- **Supertest** : Tests API
- **ESLint + Prettier** : Code quality

---

## DevOps et infrastructure

### Hébergement

- **Frontend** : Vercel
  - Déploiement automatique depuis Git
  - Edge network mondial
  - Preview deployments sur PR

- **Backend + Database** : Railway
  - PostgreSQL managé
  - Déploiement continu
  - Logs et monitoring intégrés

### CI/CD

- **GitHub Actions** :
  - Tests automatiques sur PR
  - Linting et type checking
  - Build et déploiement

### Containerisation

- **Docker** : Containerisation locale
- **Docker Compose** : Orchestration multi-services

### Monitoring et logs

- **Sentry** : Error tracking
- **Vercel Analytics** : Frontend analytics
- **Railway Logs** : Backend logs

---

## Variables d'environnement

### Frontend (.env)

```bash
VITE_API_URL=https://api.{{PROJECT_NAME}}.com
VITE_ENV=production
```

### Backend (.env)

```bash
# Database
DATABASE_URL=postgresql://user:password@host:5432/dbname

# Auth
JWT_SECRET=your-secret-key
JWT_EXPIRES_IN=7d

# Redis (optionnel)
REDIS_URL=redis://host:6379

# App
NODE_ENV=production
PORT=3000
FRONTEND_URL=https://{{PROJECT_NAME}}.com

# External APIs
SENDGRID_API_KEY=xxx
```

---

## Structure du projet

### Frontend

```
frontend/
├── src/
│   ├── components/          # Composants réutilisables
│   ├── pages/               # Pages/Routes
│   ├── hooks/               # Custom hooks
│   ├── api/                 # Client API (React Query)
│   ├── types/               # Types TypeScript
│   ├── utils/               # Utilitaires
│   └── App.tsx
├── public/
├── tests/
└── package.json
```

### Backend

```
backend/
├── src/
│   ├── routes/              # Routes Express
│   ├── controllers/         # Logique métier
│   ├── services/            # Services métier
│   ├── middlewares/         # Middlewares Express
│   ├── types/               # Types TypeScript
│   ├── prisma/              # Schema Prisma
│   │   └── schema.prisma
│   └── server.ts
├── tests/
└── package.json
```

---

## Scripts

### Frontend

```json
{
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "preview": "vite preview",
    "test": "vitest",
    "test:e2e": "playwright test",
    "lint": "eslint src --ext ts,tsx",
    "format": "prettier --write \"src/**/*.{ts,tsx}\""
  }
}
```

### Backend

```json
{
  "scripts": {
    "dev": "ts-node-dev --respawn src/server.ts",
    "build": "tsc",
    "start": "node dist/server.js",
    "test": "jest",
    "test:watch": "jest --watch",
    "prisma:migrate": "prisma migrate dev",
    "prisma:studio": "prisma studio",
    "lint": "eslint src --ext ts",
    "format": "prettier --write \"src/**/*.ts\""
  }
}
```

---

## Justifications des choix

### Pourquoi React ?

- Écosystème mature et riche
- Grande communauté
- Performance optimale avec Virtual DOM
- Composants réutilisables

### Pourquoi TypeScript ?

- Type safety réduit les bugs
- Meilleure DX (autocomplétion, refactoring)
- Documentation vivante du code
- Maintenance facilitée

### Pourquoi Prisma ?

- Type-safety de bout en bout
- Migrations automatiques
- Studio pour explorer les données
- Excellente DX avec autocomplétion

### Pourquoi Vercel + Railway ?

- Déploiement simplifié
- Scaling automatique
- Prix compétitifs
- Excellent DX

---

## Alternatives considérées

| Choix | Alternative | Raison du choix |
|-------|-------------|-----------------|
| React | Vue.js, Svelte | Écosystème plus mature |
| Prisma | TypeORM, Sequelize | Meilleure DX et type safety |
| PostgreSQL | MongoDB | Relations complexes |
| Vercel | Netlify, AWS | Meilleure intégration Next.js |
| Railway | Heroku, Render | Rapport qualité/prix |

---

## Évolutions futures

### Court terme (3 mois)

- Migration vers Next.js si besoin de SSR
- Ajout de Redis pour le cache
- WebSockets pour temps réel

### Moyen terme (6 mois)

- GraphQL au lieu de REST
- Microservices si scaling nécessaire
- Tests de charge et optimisations

### Long terme (1 an)

- Mobile natif (React Native)
- Infrastructure Kubernetes
- Multi-région

---

**Dernière mise à jour** : {{DATE}}
**Validé par** : {{AUTHOR}}
