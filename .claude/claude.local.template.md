# Mémoire locale - Template

**IMPORTANT** : Ce fichier est un template. Pour l'utiliser dans un projet :
```bash
cp ~/Claude/.claude/claude.local.template.md ~/Claude/active/mon-projet/claude.local.md
```

Le fichier `claude.local.md` est automatiquement **gitignored** (jamais versionné).

---

## Portée de cette mémoire

Cette mémoire locale s'applique **UNIQUEMENT** au projet dans lequel elle se trouve.

**Hiérarchie de chargement** :
1. Mémoire entreprise : `/opt/claude/CLAUDE.MD` (si existe)
2. Mémoire personnelle : `~/.claude/CLAUDE.MD` (conventions universelles)
3. Mémoire workspace : `~/Claude/CLAUDE.MD` (workflow spécifique)
4. Mémoire projet : `~/Claude/active/mon-projet/CLAUDE.MD`
5. **Mémoire locale** : `~/Claude/active/mon-projet/claude.local.md` ← **VOUS ÊTES ICI**

**Usage typique** : Credentials, API keys, notes privées, configurations locales

---

## Credentials et secrets

### API Keys

```bash
# OpenAI
OPENAI_API_KEY=sk-...

# Anthropic
ANTHROPIC_API_KEY=sk-ant-...

# Autres services
STRIPE_SECRET_KEY=sk_test_...
SENDGRID_API_KEY=SG....
```

### Connexions base de données

```bash
# PostgreSQL local
DATABASE_URL=postgresql://user:password@localhost:5432/dbname

# MongoDB local
MONGODB_URI=mongodb://localhost:27017/dbname
```

### Tokens et authentification

```bash
# GitHub Personal Access Token
GITHUB_TOKEN=ghp_...

# JWT Secret
JWT_SECRET=...
```

---

## Configurations locales

### Environnement de développement

```bash
# Port de développement
DEV_PORT=3000

# URL locale
DEV_URL=http://localhost:3000

# Mode debug
DEBUG=true
LOG_LEVEL=debug
```

### Chemins locaux

```bash
# Répertoire de travail
WORK_DIR=/Users/votrenom/projets/mon-projet

# Répertoire de données
DATA_DIR=/Users/votrenom/data/mon-projet
```

---

## Notes privées

### TODO personnel

- [ ] Tester l'authentification avec mon compte
- [ ] Vérifier les performances en local
- [ ] Demander accès API staging à l'équipe

### Problèmes en cours

**Bug auth** : Le token expire après 1h au lieu de 24h
- Cause probable : config JWT dans .env.local
- Solution testée : Augmenter exp à 86400
- Status : En test

### Contacts et ressources

**Chef de projet** : Marie (marie@example.com)
**DevOps** : Thomas (thomas@example.com)
**Slack** : #projet-mon-projet
**Notion** : https://notion.so/equipe/mon-projet

---

## Configurations spécifiques à la machine

### Alias locaux

```bash
# Raccourcis projet
alias cdproj="cd ~/projets/mon-projet"
alias rundev="npm run dev"
alias testlocal="npm test"
```

### Scripts locaux

```bash
# Script de backup local
./scripts/backup-local.sh

# Script de reset DB locale
./scripts/reset-db.sh
```

---

## Surcharges temporaires

### Règles désactivées temporairement

**Raison** : Tests en cours sur nouvelle architecture

Règles désactivées :
- `api-rules.md` : validation stricte des schémas (trop stricte pour proto)
- `security-rules.md` : rate limiting (bloque les tests)

**À réactiver** : Avant merge en main

### Configurations expérimentales

Mode expérimental activé pour tester :
- Nouveau système de cache Redis
- Pagination avec curseurs au lieu d'offset
- Authentification avec WebAuthn

---

## Maintenance

**Fréquence de révision** : Hebdomadaire (nettoyer les notes obsolètes)

**À faire avant un commit** :
1. Vérifier qu'aucun secret n'est dans les fichiers versionnés
2. Supprimer les notes temporaires obsolètes
3. Mettre à jour les TODO si nécessaire

---

**Dernière mise à jour** : [Date]
**Version** : 1.0.0
