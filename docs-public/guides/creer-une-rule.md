# Guide : créer une rule Claude Code

**Niveau** : Débutant/Intermédiaire
**Durée** : 10-15 minutes
**Prérequis** : Connaître les bases de Claude Code

---

## Qu'est-ce qu'une rule ?

Une **rule** est un ensemble de contraintes et bonnes pratiques :
- **Passive** : Ne fait rien, ne s'exécute pas
- **Chargée automatiquement** : Selon les fichiers manipulés
- **Guide le comportement** : Définit standards et conventions
- **Fournit des exemples** : Bon vs mauvais code

**Métaphore** : Une rule = le guide de style d'une équipe.

---

## Quand créer une rule ?

Créer une rule quand :

- Vous voulez **définir des standards** (conventions de code, nommage, etc.)
- Vous voulez **contraindre le comportement** de Claude
- Vous avez des **bonnes pratiques** à documenter
- Vous voulez **guider** plutôt qu'exécuter

**Exemples** :
- Conventions Markdown (pas d'emojis, capitalisation française)
- Conventions Git (format des commits, branches)
- Conventions de nommage (fichiers, variables, fonctions)
- Standards de code (API, frontend, sécurité)

---

## Structure d'une rule

### Localisation

```
.claude/rules/mon-domaine-rules.md
```

### Frontmatter (optionnel mais recommandé)

```yaml
---
name: api-rules
description: Conventions pour le développement d'API REST
paths: ["src/api/**", "src/routes/**"]  # Optionnel : auto-chargement
---
```

**Paths** : Si défini, la rule est chargée automatiquement quand Claude touche ces fichiers.

---

## Sections recommandées

```markdown
# Nom de la Rule

## Objectif

Pourquoi cette rule existe.

## Scope

Quand cette rule s'applique.

## Conventions

### Convention 1

Description de la convention.

**Bon** :
```[language]
// Exemple de bon code
```

**Mauvais** :
```[language]
// Exemple de mauvais code
```

### Convention 2

...

## Exceptions

Cas où la convention ne s'applique pas.

## Références

Liens vers documentation externe si pertinent.
```

---

## Exemple complet : api-rules

```markdown
---
name: api-rules
description: Conventions pour le développement d'API REST
paths: ["src/api/**", "src/routes/**", "src/controllers/**"]
---

# API REST Rules

## Objectif

Définir les standards et bonnes pratiques pour le développement d'API REST dans ce projet.

## Scope

Cette rule s'applique à :
- Routes Express (src/routes/)
- Contrôleurs (src/controllers/)
- Services API (src/api/)

---

## Conventions de nommage

### Endpoints

Format : `/api/resource` ou `/api/resource/:id`

**Bon** :
```
GET    /api/users
POST   /api/users
GET    /api/users/:id
PUT    /api/users/:id
DELETE /api/users/:id
```

**Mauvais** :
```
GET    /getUsers           # Pas de verbe dans l'URL
POST   /api/user           # Singulier
GET    /api/users_list     # Snake_case
```

### Routes files

Format : `resource.routes.ts`

**Bon** :
```
src/routes/users.routes.ts
src/routes/auth.routes.ts
```

**Mauvais** :
```
src/routes/usersRoutes.ts   # PascalCase
src/routes/user.ts          # Manque .routes
```

---

## Structure de réponse

### Success (2xx)

```typescript
{
  "success": true,
  "data": {
    // Données de la réponse
  },
  "meta": {
    "timestamp": "2026-02-08T10:00:00Z"
  }
}
```

### Error (4xx, 5xx)

```typescript
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Message lisible",
    "details": [
      // Détails optionnels
    ]
  },
  "meta": {
    "timestamp": "2026-02-08T10:00:00Z"
  }
}
```

---

## Validation

### Toujours valider les inputs

Utiliser Zod pour la validation.

**Bon** :
```typescript
import { z } from 'zod';

const createUserSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
  name: z.string().min(2)
});

router.post('/users', async (req, res) => {
  const result = createUserSchema.safeParse(req.body);
  if (!result.success) {
    return res.status(400).json({
      success: false,
      error: {
        code: 'VALIDATION_ERROR',
        message: 'Invalid input',
        details: result.error.errors
      }
    });
  }

  // Procéder avec result.data
});
```

**Mauvais** :
```typescript
router.post('/users', async (req, res) => {
  // Pas de validation !
  const { email, password } = req.body;
  // ...
});
```

---

## Gestion des erreurs

### Middleware d'erreur global

```typescript
app.use((err, req, res, next) => {
  console.error(err);
  res.status(err.status || 500).json({
    success: false,
    error: {
      code: err.code || 'INTERNAL_ERROR',
      message: process.env.NODE_ENV === 'production'
        ? 'An error occurred'
        : err.message
    }
  });
});
```

### Try/catch dans les routes

**Bon** :
```typescript
router.get('/users/:id', async (req, res, next) => {
  try {
    const user = await userService.findById(req.params.id);
    if (!user) {
      return res.status(404).json({
        success: false,
        error: {
          code: 'NOT_FOUND',
          message: 'User not found'
        }
      });
    }
    res.json({ success: true, data: user });
  } catch (error) {
    next(error);
  }
});
```

---

## Sécurité

### Toujours utiliser HTTPS en production

### Rate limiting

```typescript
import rateLimit from 'express-rate-limit';

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100 // max 100 requêtes
});

app.use('/api/', limiter);
```

### Headers sécurisés

```typescript
import helmet from 'helmet';

app.use(helmet());
```

### Authentification JWT

**Bon** :
```typescript
import jwt from 'jsonwebtoken';

const authMiddleware = (req, res, next) => {
  const token = req.headers.authorization?.split(' ')[1];
  if (!token) {
    return res.status(401).json({
      success: false,
      error: {
        code: 'UNAUTHORIZED',
        message: 'No token provided'
      }
    });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded;
    next();
  } catch (error) {
    res.status(401).json({
      success: false,
      error: {
        code: 'INVALID_TOKEN',
        message: 'Invalid token'
      }
    });
  }
};
```

---

## Tests

### Tester tous les endpoints

```typescript
describe('GET /api/users/:id', () => {
  it('should return user when id is valid', async () => {
    const res = await request(app).get('/api/users/1');
    expect(res.status).toBe(200);
    expect(res.body.success).toBe(true);
    expect(res.body.data).toHaveProperty('id', 1);
  });

  it('should return 404 when user not found', async () => {
    const res = await request(app).get('/api/users/999');
    expect(res.status).toBe(404);
    expect(res.body.success).toBe(false);
  });

  it('should return 401 when not authenticated', async () => {
    const res = await request(app).get('/api/users/1');
    expect(res.status).toBe(401);
  });
});
```

---

## Exceptions

### Endpoints publics

Certains endpoints n'ont pas besoin d'authentification :
- `/api/health` : Health check
- `/api/auth/login` : Connexion
- `/api/auth/register` : Inscription

### Formats de réponse legacy

Si migration en cours, documenter les exceptions.

---

## Références

- [REST API Best Practices](https://restfulapi.net/)
- [Express.js Documentation](https://expressjs.com/)
- [Zod Documentation](https://zod.dev/)

---

**Dernière mise à jour** : 2026-02-08
```

---

## Exemple minimaliste

Le strict minimum pour une rule fonctionnelle :

```markdown
---
name: naming-rules
description: Conventions de nommage
---

# Naming Rules

## Fichiers

- Components : PascalCase (`UserProfile.tsx`)
- Utils : camelCase (`formatDate.ts`)
- Constants : UPPER_SNAKE_CASE (`API_URL.ts`)

## Variables

```typescript
// Bon
const userName = "John";
const API_KEY = "xxx";

// Mauvais
const UserName = "John";  # PascalCase pour variable
const api_key = "xxx";    # snake_case
```

## Fonctions

```typescript
// Bon
function getUserById(id: number) {}

// Mauvais
function get_user_by_id(id: number) {}  # snake_case
```
```

---

## Auto-chargement avec paths

### Définir les paths

```yaml
---
name: security-rules
paths: ["src/auth/**", "src/api/**"]
---
```

Claude chargera automatiquement cette rule quand il touchera :
- `src/auth/login.ts`
- `src/api/users.ts`
- etc.

### Patterns supportés

- `src/**` : Tous les fichiers dans src/ (récursif)
- `*.ts` : Tous les fichiers .ts
- `src/api/*.ts` : Fichiers .ts dans src/api/ (non récursif)
- `**/test/**` : Tous les dossiers test/

---

## Bonnes pratiques

### Exemples clairs

Toujours fournir des exemples **Bon** vs **Mauvais**.

**Bon** :
```markdown
**Bon** :
```typescript
const userName = "John";
```

**Mauvais** :
```typescript
const user_name = "John";
```
```

### Justifications

Expliquer **pourquoi** la convention existe.

**Bon** :
```markdown
### camelCase pour les variables

Utiliser camelCase pour les variables JavaScript/TypeScript.

**Pourquoi** : Convention standard JavaScript, meilleure lisibilité.
```

### Scope clair

Définir clairement quand la rule s'applique.

```markdown
## Scope

Cette rule s'applique uniquement aux fichiers :
- src/components/**
- src/pages/**

Elle NE s'applique PAS aux :
- Tests (*.test.ts)
- Scripts (scripts/)
```

---

## Anti-patterns à éviter

### Rule trop vague

**Mauvais** :
```markdown
# Code Rules

Écrire du bon code.
```

**Bon** :
```markdown
# Code Rules

## Convention 1 : Nommage des variables

Utiliser camelCase pour les variables.

**Bon** : `const userName = "John";`
**Mauvais** : `const user_name = "John";`
```

### Trop d'exceptions

Si vous avez beaucoup d'exceptions, la convention n'est peut-être pas la bonne.

**Mauvais** :
```markdown
## Exceptions

- Sauf pour les fichiers legacy
- Sauf pour les migrations
- Sauf pour les scripts
- Sauf pour...
```

### Manque d'exemples

**Mauvais** :
```markdown
Utiliser camelCase.
```

**Bon** :
```markdown
Utiliser camelCase.

**Bon** : `userName`
**Mauvais** : `user_name`, `UserName`
```

---

## Checklist de création

Avant de finaliser votre rule, vérifiez :

- [ ] Nom descriptif (domain-rules)
- [ ] Description claire
- [ ] Paths définis (si auto-chargement souhaité)
- [ ] Section "Objectif" expliquant le pourquoi
- [ ] Section "Scope" définissant le quand
- [ ] Conventions documentées avec exemples
- [ ] Exemples "Bon" vs "Mauvais" pour chaque convention
- [ ] Exceptions documentées (si applicable)
- [ ] Pas de code exécutable (rule = passive)

---

## Prochaines étapes

Une fois votre rule créée :

1. **Tester** : Créer un fichier dans le scope de la rule
2. **Vérifier** : Demander à Claude de suivre la rule
3. **Itérer** : Affiner selon les besoins
4. **Documenter** : Référencer dans la documentation projet

---

## Ressources

- **Documentation officielle** : [Claude Code Rules](https://docs.claude.com/claude-code/rules)
- **Exemples** : `.claude/rules/` du workspace
- **Architecture** : `CLAUDE.MD` section "Architecture en 3 niveaux"

---

**Dernière mise à jour** : 2026-02-08
