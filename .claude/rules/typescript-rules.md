---
paths: ["**/*.ts", "**/*.tsx", "**/*.js", "**/*.jsx"]
---

# Regles TypeScript et JavaScript

Conventions pour tous les fichiers TypeScript et JavaScript

---

## Nommage

| Element | Convention | Exemple |
|---------|-----------|---------|
| Variables, fonctions | `camelCase` | `userName`, `getUserById()` |
| Constantes globales | `UPPER_SNAKE_CASE` | `MAX_RETRIES`, `API_BASE_URL` |
| Types, interfaces, classes | `PascalCase` | `User`, `ApiResponse<T>`, `UserService` |
| Fonctions | Verbe d'action | `fetchUser()`, `calculateTotal()` |

---

## Types

- Types **explicites** sur parametres, retours et variables complexes
- **Jamais** `any` : preferer `unknown` ou generiques
- Preferer `type` a `interface` (sauf si extension necessaire)
- Nullish coalescing `??` au lieu de `||` pour valeurs par defaut

```typescript
// BON
function processData<T>(data: T): T { return data; }
const userName = user.name ?? 'Anonymous';

// MAUVAIS
function processData(data: any): any { return data; }
const userName = user.name || 'Anonymous';
```

---

## Imports et exports

Ordre des imports (ligne vide entre groupes) :
1. Node.js built-in (`fs`, `path`)
2. Dependances externes (`express`, `zod`)
3. Imports internes (`@/services/...`)
4. Imports relatifs (`../utils/...`)

- Preferer **exports nommes** (eviter `export default`)
- Exception : pages Next.js

---

## Async/Await

- Toujours `async/await`, jamais `.then()/.catch()`
- `Promise.all()` pour paralleliser les appels independants
- `try/catch` systematique pour les appels async
- Creer des **classes d'erreur custom** (`UserNotFoundError extends Error`)

---

## Variables

- **Jamais** `var` : toujours `const` ou `let`
- Preferer `const` par defaut, `let` uniquement si reassignation
- Optional chaining `?.` pour acces optionnel

---

## Exceptions

`any` acceptable **uniquement** si : bibliotheque non typee, migration JS vers TS, avec commentaire justificatif et `eslint-disable`.

---

## References

- [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/)
- [Google TypeScript Style Guide](https://google.github.io/styleguide/tsguide.html)
