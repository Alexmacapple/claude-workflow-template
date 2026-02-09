---
paths: ["**/routes/**", "**/controllers/**", "**/api/**"]
---

# Regles API REST

Standards pour la conception et l'implementation d'API REST

---

## Nommage des endpoints

- Ressources au **pluriel**, **kebab-case**, pas de verbes dans l'URL
- Maximum **2 niveaux** d'imbrication (au-dela : query params)
- Actions non-CRUD : sous-ressources (`POST /users/:id/activate`)

```
BON :  GET /api/v1/users/:id
       GET /api/v1/blog-posts

MAUVAIS : GET /api/v1/getUsers
          GET /api/v1/user_settings
```

---

## Methodes HTTP et status codes

| Methode | Usage | Code succes |
|---------|-------|-------------|
| GET | Lecture (idempotent, pas de body) | 200 |
| POST | Creation | 201 + Location header |
| PUT | Remplacement complet | 200 |
| PATCH | Modification partielle | 200 |
| DELETE | Suppression | 204 (no content) |

**Erreurs client** : 400 (validation), 401 (non authentifie), 403 (interdit), 404 (introuvable), 409 (conflit), 422 (validation echouee), 429 (rate limit)

**Erreurs serveur** : 500 (erreur interne, jamais de details techniques dans la reponse)

---

## Format de reponse uniforme

```typescript
// Succes
{ "success": true, "data": { ... } }

// Succes avec pagination
{ "success": true, "data": [...], "pagination": { "page": 1, "limit": 20, "total": 100 } }

// Erreur
{ "success": false, "error": { "code": "VALIDATION_ERROR", "message": "...", "details": [...] } }
```

---

## Validation

- Valider **toutes** les entrees avec Zod
- Sanitizer les entrees utilisateur (`escape`, `DOMPurify`)
- Middleware global de gestion d'erreurs centralise

```typescript
const createUserSchema = z.object({
  name: z.string().min(1).max(100),
  email: z.string().email(),
  age: z.number().int().min(18).optional()
});
```

---

## Versioning et pagination

- Toujours versionner les API publiques : `/api/v1/...`
- Pagination par defaut : `page` et `limit` (ou cursor-based pour flux volumineux)

---

## References

- [Microsoft REST API Guidelines](https://github.com/microsoft/api-guidelines)
- [Zalando RESTful API Guidelines](https://opensource.zalando.com/restful-api-guidelines/)
