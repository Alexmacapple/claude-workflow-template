# Template projet API REST

**Type** : API REST backend

## Structure

```
projet-api/
├── README.MD                    # Ce fichier
├── BRIEF.template.md            # Template cahier des charges
├── STACK.template.md            # Template stack technique
├── CLAUDE.template.md           # Template mémoire projet
├── .gitignore.template          # Template gitignore
├── src/
│   ├── routes/                  # Routes Express
│   ├── controllers/             # Contrôleurs
│   ├── services/                # Logique métier
│   ├── middlewares/             # Middlewares
│   ├── types/                   # Types TypeScript
│   ├── prisma/
│   │   └── schema.prisma        # Schema Prisma
│   └── server.ts
├── tests/
└── docs/
    ├── ADR/                     # Architecture Decision Records
    └── api.md                   # Documentation API
```

## Stack suggérée

**Runtime** :
- Node.js 20 LTS
- TypeScript 5

**Framework** :
- Express 4
- Prisma 5 (ORM)
- PostgreSQL 16

**Auth** :
- JWT
- bcrypt

**Validation** :
- Zod

**Testing** :
- Jest
- Supertest

**Hosting** :
- Railway ou Render

## Utilisation

### 1. Copier le template

```bash
cp -r ~/Claude/templates/projet-api ~/Claude/active/mon-api
cd ~/Claude/active/mon-api
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
```

### 3. Initialiser

```bash
# Git
git init
git add .
git commit -m "Initial commit - Structure API REST"

# NPM
npm install

# Database
npm run prisma:migrate
npm run prisma:seed

# Dev
npm run dev
```

## Endpoints type

```
POST   /api/auth/register       # Inscription
POST   /api/auth/login          # Connexion
GET    /api/users               # Liste utilisateurs
GET    /api/users/:id           # Détail utilisateur
PUT    /api/users/:id           # Modifier utilisateur
DELETE /api/users/:id           # Supprimer utilisateur
```

## Prochaines étapes

1. Compléter `docs/BRIEF.md`
2. Finaliser `docs/STACK.md`
3. Définir le schema Prisma
4. Créer les endpoints
5. Documenter l'API dans `docs/api.md`

## Variants

### GraphQL

Remplacer Express par :
- Apollo Server
- GraphQL Yoga

### Microservice

Ajouter :
- Message queue (RabbitMQ, Kafka)
- Service discovery
- API Gateway
