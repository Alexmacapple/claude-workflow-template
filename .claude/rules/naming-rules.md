---
paths: [
  "**/*.md",
  "**/*.MD",
  "**/*.js",
  "**/*.ts",
  "**/*.tsx",
  "**/*.json",
  "**/*.yaml",
  "**/*.yml",
  "**/*.sh",
  "**/*.py"
]
---

# Règles de nommage

Conventions pour le nommage des fichiers et dossiers du workspace

**Scope** : Appliqué aux fichiers de documentation, code source et dossiers (sauf node_modules, .git, builds)

---

## Langue : français

Les noms de fichiers et dossiers doivent être en français, sauf pour les termes techniques standards.

BON :
```
docs-perso/
prd-meta-workflow/
EVALUATION-CONFORMITE.MD
```

MAUVAIS :
```
personal-docs/
prd-meta-workflow/  (ok - "workflow" est technique)
EVALUATION-COMPLIANCE.MD
```

**Exception** : Termes techniques universels acceptés (git, docker, cli, api, etc.)

---

## Format : kebab-case

Tous les fichiers et dossiers doivent utiliser le kebab-case (minuscules séparées par tirets).

BON :
```
mon-projet/
fichier-config.md
base-de-donnees.sql
```

MAUVAIS :
```
MonProjet/              (PascalCase)
fichier_config.md       (snake_case)
fichierConfig.md        (camelCase)
Fichier Config.md       (espaces)
```

**Exception** : Fichiers spéciaux en UPPERCASE (voir section suivante)

---

## Fichiers spéciaux : UPPERCASE.MD

Certains fichiers de documentation importants utilisent UPPERCASE.MD pour visibilité.

**Fichiers UPPERCASE autorisés** :
```
CLAUDE.MD               (mémoire workspace)
README.MD               (documentation principale)
STRUCTURE.txt           (visualisation structure)
CHANGELOG.MD            (historique versions)
LICENSE.MD              (licence)
CONTRIBUTING.MD         (guide contribution)
GUIDELINES-*.MD         (références)
```

**Règle** : Seuls les fichiers de **documentation structurante** sont en UPPERCASE

BON :
```
~/Claude/CLAUDE.MD
~/Claude/README.MD
~/Claude/prd-meta-workflow/README.MD
```

MAUVAIS :
```
~/Claude/NOTES.MD       (notes → notes.md)
~/Claude/IDEES.MD       (idées → idees.md)
~/Claude/TODO.MD        (todo → todo.md)
```

---

## Fichiers de documentation : .MD

Extension en uppercase pour fichiers Markdown de documentation.

BON :
```
README.MD
CLAUDE.MD
guide-utilisateur.md
notes-reunions.md
```

**Règle** :
- `.MD` (uppercase) : Documentation structurante, README, guides officiels
- `.md` (lowercase) : Fichiers temporaires, notes, brouillons

---

## Préfixes et suffixes

### Préfixes recommandés

**Documentation** :
```
guide-*.md              (guides)
doc-*.md                (documentation)
spec-*.md               (spécifications)
```

**Code** :
```
test-*.js               (tests)
mock-*.json             (données mock)
util-*.js               (utilitaires)
```

**Configuration** :
```
config-*.json
.env.*
```

### Suffixes interdits

MAUVAIS :
```
fichier.final.md        (ambigü)
fichier.old.md          (utiliser Git)
fichier.backup.md       (utiliser Git)
fichier.copy.md         (utiliser Git)
fichier-2.md            (numérotation)
```

BON : Utiliser Git pour versionner, pas de suffixes

---

## Répertoires racine

**Noms standards** :
```
active/                 (projets actifs)
archive/                (projets archivés)
templates/              (templates)
docs-perso/             (documentation personnelle)
docs-public/            (documentation publique)
prd-meta-workflow/      (PRD du workflow)
.claude/                (configuration Claude Code)
```

**Règle** : Noms explicites et descriptifs

---

## Répertoires .claude/

**Structure standard** :
```
.claude/
├── skills/
├── agents/
├── rules/
└── commands/
```

**Noms de fichiers skills** :
```
.claude/skills/mon-skill/SKILL.md
```

**Noms de fichiers agents** :
```
.claude/agents/file-search-agent.md
.claude/agents/test-runner-agent.md
```

**Noms de fichiers rules** :
```
.claude/rules/markdown-rules.md
.claude/rules/git-rules.md
.claude/rules/naming-rules.md
```

**Noms de fichiers commands** :
```
.claude/commands/init.MD
.claude/commands/commit.MD
```

---

## Caractères interdits

**Jamais utiliser** :
```
espaces             (utiliser tirets)
underscores         (sauf snake_case technique)
caractères spéciaux (&, %, $, @, etc.)
accents             (éviter dans noms de fichiers)
```

BON :
```
evaluation-conformite.md
guide-demarrage.md
```

MAUVAIS :
```
évaluation-conformité.md
guide démarrage.md
guide_demarrage.md
```

**Exception** : UPPERCASE.MD peut contenir accents si nécessaire

---

## PRD et documentation versionnée

**Format PRD** :
```
PRD-001.MD              (numérotation à 3 chiffres)
PRD-002.MD
PRD-042.MD
```

**Format ADR (Architecture Decision Records)** :
```
ADR-001-choix-base-donnees.md
ADR-002-architecture-api.md
```

**Format EPIC** :
```
EPIC-001-authentification.md
EPIC-002-paiements.md
```

---

## Cas spéciaux

### Fichiers techniques

**Code source** : Suivre conventions du langage
```
index.js                (JavaScript)
main.py                 (Python)
App.tsx                 (React TypeScript)
```

**Configuration** :
```
package.json
.gitignore
.env.local
```

### Fichiers temporaires

**Toujours en minuscules** :
```
brouillon.md
notes-temp.md
todo-local.md
```

**Pas en UPPERCASE** (réservé pour documentation structurante)

---

## Bonnes pratiques

### Noms descriptifs

BON :
```
guide-installation-docker.md
config-base-donnees-production.json
script-migration-v2.sh
```

MAUVAIS :
```
guide.md                (trop vague)
config.json             (quel config ?)
script.sh               (quel script ?)
```

### Longueur raisonnable

**Idéal** : 2-4 mots
**Maximum** : 5-6 mots

BON :
```
guide-utilisation.md
config-serveur-production.json
```

MAUVAIS :
```
g.md                    (trop court)
guide-complet-utilisation-avancee-pour-deploiement.md  (trop long)
```

---

## Application

Ces règles s'appliquent à tous les fichiers et dossiers du workspace.

Quand Claude crée ou renomme un fichier/dossier, il doit suivre ces conventions.

**Priorités** :
1. Fichiers documentation structurante → UPPERCASE.MD
2. Autres fichiers → kebab-case.md
3. Répertoires → kebab-case
4. Langue française (sauf termes techniques)
5. Noms descriptifs et explicites
