# Stack technique - {{PROJECT_NAME}}

**Projet** : {{PROJECT_NAME}}
**Type** : API REST backend
**Dernière mise à jour** : {{DATE}}

---

## Architecture

```
┌──────────────┐
│   Clients    │  Frontend, Mobile, Intégrations
└──────┬───────┘
       │ HTTPS/REST
┌──────▼───────┐
│   API REST   │  Node.js + Express + TypeScript
│  (Railway)   │
└──────┬───────┘
       │
┌──────▼───────┐
│  PostgreSQL  │  Database + Prisma ORM
│  (Railway)   │
└──────────────┘
```

---

## Backend

### Runtime et framework

- **Node.js 20 LTS** : Runtime JavaScript
- **Express 4** : Web framework minimaliste
- **TypeScript 5** : Typage statique

### Base de données et ORM

- **PostgreSQL 16** : Base relationnelle
- **Prisma 5** : ORM avec type safety
- **Redis** (optionnel) : Cache et sessions

### Authentification

- **JWT** : JSON Web Tokens
- **bcrypt** : Hashing mots de passe
- **Passport.js** (optionnel) : Stratégies auth

### Validation et sécurité

- **Zod** : Validation des schémas
- **helmet** : Sécurité headers HTTP
- **express-rate-limit** : Rate limiting
- **cors** : Configuration CORS
- **express-validator** : Validation des inputs

### Testing

- **Jest** : Tests unitaires
- **Supertest** : Tests API
- **@faker-js/faker** : Données de test

### Quality

- **ESLint** : Linting
- **Prettier** : Formatage
- **ts-node-dev** : Dev server avec hot reload

---

## Infrastructure

### Hébergement

**Railway** :
- PostgreSQL managé
- Déploiement continu
- Logs et monitoring
- Scaling automatique

**Alternative** : Render, Heroku

### CI/CD

**GitHub Actions** :
- Tests automatiques
- Linting et type checking
- Déploiement automatique

### Monitoring

- **Sentry** : Error tracking
- **Railway Logs** : Application logs
- **PostgreSQL Slow Queries** : Monitoring DB

---

## Variables d'environnement

```bash
# Database
DATABASE_URL=postgresql://user:pass@host:5432/db

# Auth
JWT_SECRET=your-secret-key
JWT_EXPIRES_IN=7d
JWT_REFRESH_EXPIRES_IN=30d

# Redis (optionnel)
REDIS_URL=redis://host:6379

# App
NODE_ENV=production
PORT=3000
FRONTEND_URL=https://app.example.com

# External services
SENDGRID_API_KEY=xxx
AWS_S3_BUCKET=xxx
```

---

## Structure du projet

```
src/
├── routes/                  # Routes Express
│   ├── auth.routes.ts
│   ├── users.routes.ts
│   └── index.ts
├── controllers/             # Contrôleurs (logique HTTP)
│   ├── auth.controller.ts
│   └── users.controller.ts
├── services/                # Services métier
│   ├── auth.service.ts
│   └── users.service.ts
├── middlewares/             # Middlewares Express
│   ├── auth.middleware.ts
│   ├── validate.middleware.ts
│   └── error.middleware.ts
├── types/                   # Types TypeScript
│   ├── user.types.ts
│   └── auth.types.ts
├── prisma/                  # Prisma
│   ├── schema.prisma
│   ├── migrations/
│   └── seed.ts
├── utils/                   # Utilitaires
│   ├── jwt.ts
│   └── logger.ts
└── server.ts                # Point d'entrée
```

---

## Endpoints

### Authentification

```
POST   /api/auth/register       # Inscription
POST   /api/auth/login          # Connexion
POST   /api/auth/refresh        # Refresh token
POST   /api/auth/forgot-password
POST   /api/auth/reset-password
```

### Utilisateurs

```
GET    /api/users               # Liste (admin)
GET    /api/users/:id           # Détail
PUT    /api/users/:id           # Modifier
DELETE /api/users/:id           # Supprimer (admin)
GET    /api/users/me            # Profil actuel
PUT    /api/users/me            # Modifier profil
```

### Autres ressources

```
GET    /api/{{RESOURCE}}
POST   /api/{{RESOURCE}}
GET    /api/{{RESOURCE}}/:id
PUT    /api/{{RESOURCE}}/:id
DELETE /api/{{RESOURCE}}/:id
```

---

## Scripts

```json
{
  "scripts": {
    "dev": "ts-node-dev --respawn src/server.ts",
    "build": "tsc",
    "start": "node dist/server.js",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "prisma:migrate": "prisma migrate dev",
    "prisma:studio": "prisma studio",
    "prisma:seed": "ts-node src/prisma/seed.ts",
    "lint": "eslint src --ext ts",
    "format": "prettier --write \"src/**/*.ts\""
  }
}
```

---

## Response format

### Success

```json
{
  "success": true,
  "data": {
    "id": 1,
    "name": "John Doe"
  },
  "meta": {
    "timestamp": "2026-02-08T10:00:00Z"
  }
}
```

### Error

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid email format",
    "details": [
      {
        "field": "email",
        "message": "Must be a valid email"
      }
    ]
  },
  "meta": {
    "timestamp": "2026-02-08T10:00:00Z"
  }
}
```

---

## Justifications

### Pourquoi Express ?

- Léger et flexible
- Écosystème mature
- Grande communauté

### Pourquoi Prisma ?

- Type safety de bout en bout
- Migrations automatiques
- Excellente DX

### Pourquoi PostgreSQL ?

- Relations complexes
- ACID compliance
- Performance éprouvée

---

**Dernière mise à jour** : {{DATE}}
