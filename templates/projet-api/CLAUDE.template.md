# Mémoire projet - {{PROJECT_NAME}}

**Projet** : {{PROJECT_NAME}}
**Type** : API REST backend
**Workspace** : ~/Claude/active/{{PROJECT_NAME}}
**Créé le** : {{DATE}}

---

## Identité du projet

### Vision

{{DESCRIPTION}}

### Objectif

Créer une API REST robuste, sécurisée et performante.

**Référence** : `docs/BRIEF.md`

---

## Stack technique

**Résumé** :
- Runtime : Node.js + Express + TypeScript
- Database : PostgreSQL + Prisma
- Auth : JWT + bcrypt
- Hosting : Railway

**Référence complète** : `docs/STACK.md`

---

## Contraintes

### Performance

- Response time < 200ms (P95)
- Database queries < 50ms
- Support {{MAX_RPS}} req/s

### Sécurité

- HTTPS uniquement
- JWT avec refresh tokens
- Rate limiting : 100 req/min par IP
- Input validation stricte (Zod)
- Headers sécurisés (helmet)

### Disponibilité

- Uptime > 99.9%
- Error tracking (Sentry)
- Logs structurés

---

## Organisation du code

```
src/
├── routes/              # Routes Express
├── controllers/         # Logique HTTP
├── services/            # Logique métier
├── middlewares/         # Middlewares
├── types/               # Types
├── prisma/              # Schema + migrations
└── utils/               # Utils
```

### Séparation des responsabilités

**Routes** : Définition des endpoints
```typescript
router.post('/users', authMiddleware, validateUserDto, userController.create);
```

**Controllers** : Gestion HTTP
```typescript
async create(req, res) {
  const user = await userService.create(req.body);
  res.status(201).json({ success: true, data: user });
}
```

**Services** : Logique métier
```typescript
async create(data: CreateUserDto) {
  const hashedPassword = await bcrypt.hash(data.password, 10);
  return prisma.user.create({ data: { ...data, password: hashedPassword } });
}
```

---

## Conventions de nommage

### Fichiers

- Routes : `entity.routes.ts`
- Controllers : `entity.controller.ts`
- Services : `entity.service.ts`
- Middlewares : `action.middleware.ts`
- Types : `entity.types.ts`

### Code

- Variables/fonctions : camelCase
- Constantes : UPPER_SNAKE_CASE
- Types/Interfaces : PascalCase
- Endpoints : kebab-case

### Database

- Tables : snake_case (plural)
- Colonnes : snake_case
- Relations : camelCase dans Prisma

---

## Scripts utiles

```bash
# Dev
npm run dev                 # Serveur dev avec hot reload

# Build
npm run build              # Compile TypeScript
npm start                  # Lance build production

# Database
npm run prisma:migrate     # Créer migration
npm run prisma:studio      # Interface DB
npm run prisma:seed        # Seed la DB

# Tests
npm run test               # Tests unitaires
npm run test:watch         # Tests watch mode
npm run test:coverage      # Coverage report

# Quality
npm run lint               # ESLint
npm run type-check         # TypeScript check
npm run format             # Prettier
```

---

## Workflow de développement

### 1. Créer une feature

```bash
# Branche
git checkout -b feature/user-profile

# Schema Prisma
# Modifier src/prisma/schema.prisma
npm run prisma:migrate

# Créer les fichiers
# - routes/users.routes.ts
# - controllers/users.controller.ts
# - services/users.service.ts
# - types/user.types.ts

# Développer
npm run dev

# Tester
npm run test
```

### 2. Tests

```bash
# Tests unitaires (services)
npm run test services/user.service.test.ts

# Tests API (endpoints)
npm run test routes/users.routes.test.ts

# Coverage
npm run test:coverage
```

### 3. Commit

```bash
git add .
git commit -m "feat(users): Ajouter endpoint user profile

Implémente :
- GET /api/users/:id
- Service getUserById
- Tests unitaires + API

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

## Configuration locale

Template :
```bash
cp ~/Claude/.claude/claude.local.template.md ./claude.local.md
```

Contenu :
```markdown
## Database

DATABASE_URL=postgresql://user:password@localhost:5432/{{PROJECT_NAME}}_dev

## JWT

JWT_SECRET=dev-secret-change-in-prod
JWT_EXPIRES_IN=7d

## APIs externes

SENDGRID_API_KEY=xxx
```

---

## Documentation de l'API

La documentation complète de l'API est dans `docs/api.md`.

Format recommandé : OpenAPI 3.0 (Swagger)

---

**Dernière mise à jour** : {{DATE}}
