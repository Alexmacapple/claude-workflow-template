# Brief projet - {{PROJECT_NAME}}

**Projet** : {{PROJECT_NAME}}
**Type** : API REST backend
**Créé le** : {{DATE}}
**Propriétaire** : {{AUTHOR}}

---

## Contexte

### Problème à résoudre

{{PROBLEM_DESCRIPTION}}

### Clients de l'API

- **Frontend** : {{FRONTEND_CLIENT}}
- **Mobile** : {{MOBILE_CLIENT}}
- **Intégrations** : {{INTEGRATIONS}}

---

## Objectifs

### Objectif principal

{{MAIN_OBJECTIVE}}

### Objectifs secondaires

1. Performance : < 200ms de temps de réponse
2. Sécurité : Authentification JWT robuste
3. Scalabilité : Support de {{MAX_USERS}} utilisateurs concurrents

---

## Fonctionnalités

### MVP (Version 1.0)

1. **Authentification**
   - Inscription
   - Connexion
   - Refresh token
   - Mot de passe oublié

2. **CRUD Entité 1**
   - Create
   - Read (liste + détail)
   - Update
   - Delete

3. **CRUD Entité 2**
   - (idem)

### Endpoints futurs

**Version 2.0** :
- Webhooks
- Rate limiting avancé
- Notifications push
- Export de données

---

## Contraintes

### Performance

- Temps de réponse < 200ms (P95)
- Support de {{MAX_CONCURRENT_REQUESTS}} requêtes/s
- Database queries optimisées (< 50ms)

### Sécurité

- HTTPS uniquement
- JWT avec refresh tokens
- Rate limiting (100 req/min par IP)
- Input validation stricte
- Protection CSRF, XSS, SQL injection

### Disponibilité

- Uptime > 99.9%
- Monitoring et alertes
- Logs structurés

---

## Critères de succès

- API response time P95 < 200ms
- Uptime > 99.9%
- 0 vulnérabilités critiques
- Documentation API complète

---

## Non-objectifs

**Cette API NE FAIT PAS** :
- {{NON_GOAL_1}}
- {{NON_GOAL_2}}

---

**Dernière mise à jour** : {{DATE}}
