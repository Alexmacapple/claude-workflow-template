---
paths: ["**/auth/**", "**/api/**", "**/middleware/**"]
---

# Regles de securite

Checklist de securite pour proteger l'application (OWASP Top 10)

---

## Authentication

- **Jamais** de mots de passe en clair : toujours `bcrypt` (salt rounds >= 10)
- JWT : access token court (15min), refresh token long (7j)
- Secrets JWT dans variables d'environnement, jamais en dur
- Cookies : `httpOnly`, `secure`, `sameSite: 'strict'`
- Jamais de donnees sensibles dans le token JWT

---

## Authorization

- Verifier les permissions **a chaque requete** (middleware)
- Controle d'acces base sur les ressources (verifier propriete)
- Pattern : `requireRole('admin')` comme middleware

---

## Validation des entrees

- Valider **toutes** les entrees avec Zod (schemas stricts)
- Sanitizer contre XSS : `escape()`, `DOMPurify`
- Limites de taille sur tous les champs (`.max()`)

---

## Injections

- **SQL** : Toujours Prisma ou prepared statements, jamais de concatenation
- **XSS** : React echappe par defaut. `dangerouslySetInnerHTML` uniquement avec `DOMPurify.sanitize()`
- **CSRF** : Tokens CSRF pour mutations, `sameSite` cookies

---

## Secrets et configuration

- Variables d'environnement pour tous les secrets (`.env` gitignored)
- Validation des secrets au demarrage avec Zod
- Jamais de secrets dans les logs

---

## Protections reseau

- **Helmet** pour headers de securite (CSP, HSTS, etc.)
- **Rate limiting** : 100 req/15min general, 5 req/15min pour login
- HTTPS obligatoire en production

---

## Logging securise

- Logger les evenements critiques (login, echecs auth, modifications)
- **Jamais** logger : mots de passe, tokens, emails, donnees personnelles
- Erreurs 500 : message generique au client, details cote serveur

---

## References

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [OWASP Cheat Sheet Series](https://cheatsheetseries.owasp.org/)
