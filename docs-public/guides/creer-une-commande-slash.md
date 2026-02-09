# Guide : créer une commande slash

**Niveau** : Débutant
**Durée** : 5-10 minutes
**Prérequis** : Comprendre la différence entre commande et skill

---

## Qu'est-ce qu'une commande slash ?

Une **commande slash** est un raccourci pour invoquer un skill ou un workflow.

**Format** : `/nom-commande [arguments]`

**Exemple** :
```bash
/init mon-projet
/verifier-regles-md
/review src/components/
```

**Différence avec un skill** :
- **Commande** : Point d'entrée utilisateur (invocation)
- **Skill** : Workflow exécuté (implémentation)

**Relation** : Commande → Skill (1:1 ou N:1)

---

## Anatomie d'une commande

### Localisation

```
.claude/commands/ma-commande.MD
```

**Règle de nommage** : kebab-case, extension `.MD`

### Structure minimale

```markdown
---
name: ma-commande
---

Description de ce que fait cette commande.

Charge et exécute le skill : `.claude/skills/mon-skill/SKILL.md`
```

### Frontmatter (obligatoire)

```yaml
---
name: ma-commande    # Nom de la commande (sans le /)
---
```

**Champs disponibles** :
- `name` : Nom de la commande (obligatoire)
- `description` : Description courte (optionnel, pour documentation)

---

## Exemple 1 : Commande simple

### Cas d'usage

Créer une commande `/hello` qui affiche un message.

### Fichier : .claude/commands/hello.MD

```markdown
---
name: hello
---

Affiche un message de bienvenue.

Tu es un assistant amical. Dis bonjour à l'utilisateur et présente brièvement Claude Code.
```

### Utilisation

```bash
/hello
```

**Résultat** :
```
Bonjour ! Je suis Claude Code, votre assistant de développement...
```

**Note** : Pas de skill nécessaire pour les commandes simples.

---

## Exemple 2 : Commande avec skill

### Cas d'usage

Créer une commande `/audit-md` qui vérifie la conformité Markdown.

### Fichier : .claude/commands/audit-md.MD

```markdown
---
name: audit-md
---

Audite la conformité des fichiers Markdown.

Charge et exécute le skill défini dans `.claude/skills/verifier-regles-md/SKILL.md`.

Référence des règles : `.claude/rules/markdown-rules.md`
```

### Skill associé : .claude/skills/verifier-regles-md/SKILL.md

```markdown
---
name: verifier-regles-md
description: Vérifier conformité Markdown
context: fork
---

# Skill : Vérifier règles Markdown

## Workflow

1. Lister tous les fichiers .MD
2. Vérifier emojis interdits
3. Vérifier capitalisation titres
4. Générer rapport
```

### Utilisation

```bash
/audit-md
```

**Résultat** : Exécution du skill avec rapport de conformité

---

## Exemple 3 : Commande avec arguments

### Cas d'usage

Créer une commande `/init <nom-projet>` pour initialiser un projet.

### Fichier : .claude/commands/init.MD

```markdown
---
name: init
---

Initialise un nouveau projet avec structure complète.

Initialise un nouveau projet avec structure complète.

Arguments :
- Nom du projet (obligatoire)

Exemple : `/init mon-super-projet`
```

**Note** : `/init` est une commande directe (`.claude/commands/init.MD`), sans skill associé. La logique est intégrée dans le fichier de commande.

### Utilisation

```bash
/init mon-projet
```

**Passage d'arguments** : Les arguments sont disponibles dans le contexte de la commande.

---

## Exemple 4 : Commande multi-skills

### Cas d'usage

Une commande peut invoquer plusieurs skills séquentiellement.

### Fichier : .claude/commands/full-review.MD

```markdown
---
name: full-review
---

Review complet : code + tests + sécurité.

Exécute séquentiellement :
1. Skill code-review (`.claude/skills/code-review/SKILL.md`)
2. Skill test-runner (`.claude/skills/test-runner/SKILL.md`)
3. Skill security-audit (`.claude/skills/security-audit/SKILL.md`)

Agrège les résultats et retourne un rapport global.
```

### Utilisation

```bash
/full-review
```

---

## Bonnes pratiques

### Nommage

**Convention** : kebab-case, verbes d'action

**Bon** :
- `/init`
- `/review`
- `/audit-security`
- `/generate-docs`

**Mauvais** :
- `/Init` (majuscule)
- `/review_code` (underscore)
- `/reviewCode` (camelCase)

### Description claire

**Bon** :
```markdown
---
name: review
---

Review automatique du code avec analyse statique et suggestions.

Charge le skill : `.claude/skills/code-review/SKILL.md`
```

**Mauvais** :
```markdown
---
name: review
---

Review le code.
```

### Référence au skill

Toujours indiquer le chemin du skill associé :

```markdown
Charge et exécute le skill : `.claude/skills/mon-skill/SKILL.md`
```

Pourquoi :
- Documentation claire
- Traçabilité
- Maintenance facilitée

### Arguments documentés

Si la commande accepte des arguments, documenter :

```markdown
Arguments :
- `<nom-projet>` : Nom du projet (obligatoire)
- `--type <type>` : Type de projet (optionnel, défaut: fullstack)

Exemples :
- `/init mon-projet`
- `/init mon-api --type api`
```

---

## Différence commande vs skill

### Commande

**Rôle** : Point d'entrée utilisateur

**Localisation** : `.claude/commands/`

**Invocation** : `/commande` par l'utilisateur

**Contenu** : Description et référence au skill

**Exemple** :
```markdown
---
name: review
---

Review du code.

Skill : `.claude/skills/code-review/SKILL.md`
```

### Skill

**Rôle** : Implémentation du workflow

**Localisation** : `.claude/skills/nom-skill/`

**Invocation** : Par la commande ou autre skill

**Contenu** : Workflow détaillé, délégation agents, logique

**Exemple** :
```markdown
---
name: code-review
context: fork
---

# Code Review Skill

## Workflow
1. Analyser fichiers
2. Déléguer à code-reviewer-agent
3. Générer rapport
```

### Relation

```
/review (commande)
    └─> code-review (skill)
            └─> code-reviewer-agent (agent)
```

---

## Workflow de création

### Étape 1 : Créer la commande

```bash
touch .claude/commands/ma-commande.MD
```

**Contenu minimal** :
```markdown
---
name: ma-commande
---

Description de ce que fait la commande.

Skill : `.claude/skills/mon-skill/SKILL.md`
```

### Étape 2 : Créer le skill associé (si nécessaire)

```bash
mkdir -p .claude/skills/mon-skill
touch .claude/skills/mon-skill/SKILL.md
```

**Contenu** : Voir guide `creer-un-skill.md`

### Étape 3 : Tester

```bash
/ma-commande
```

Vérifier que :
- La commande est reconnue
- Le skill est chargé
- Le workflow s'exécute correctement

### Étape 4 : Documenter

Ajouter dans `README.MD` ou `CLAUDE.MD` :

```markdown
## Commandes disponibles

### /ma-commande

Description et usage.
```

---

## Commandes sans skill

Certaines commandes n'ont pas besoin de skill (tâches simples).

### Exemple : Commande de rappel

```markdown
---
name: conventions
---

Rappelle les conventions du projet.

Conventions principales :
- Langue : Français
- Style : Professionnel, pas d'emojis
- Commits : Format Conventional Commits
- Tests : Coverage > 80%
- Code : ESLint + Prettier

Référence : `CLAUDE.MD` section "Conventions"
```

**Utilisation** :
```bash
/conventions
```

Affiche simplement les conventions, pas besoin de skill.

---

## Commandes avancées

### Avec condition

```markdown
---
name: deploy
---

Déploie l'application en production.

**ATTENTION** : Commande destructive.

Vérifie d'abord :
1. Branche = main
2. Tests passent (100%)
3. Build réussi
4. Pas de commits non pushés

Si toutes conditions OK : exécute skill deploy.

Sinon : bloque et liste les problèmes.
```

### Avec confirmation

```markdown
---
name: reset-db
---

Réinitialise la base de données (DESTRUCTIF).

**DANGER** : Cette action supprime toutes les données.

Demander confirmation explicite avant d'exécuter.

Si confirmé : exécute skill reset-database.
```

---

## Checklist de création

Avant de finaliser votre commande :

- [ ] Nom en kebab-case
- [ ] Frontmatter avec `name`
- [ ] Description claire de ce que fait la commande
- [ ] Référence au skill (si applicable)
- [ ] Arguments documentés (si applicable)
- [ ] Exemples d'utilisation
- [ ] Testé avec `/commande`
- [ ] Documenté dans README.MD ou CLAUDE.MD

---

## Commandes utiles existantes

### /init

Initialise un nouveau projet avec structure complète.

**Usage** : `/init <nom-projet>`

**Commande** : `.claude/commands/init.MD` (commande directe, sans skill associé)

### /verifier-regles-md

Vérifie la conformité Markdown de tous les fichiers.

**Usage** : `/verifier-regles-md`

**Skill** : `.claude/skills/verifier-regles-md/SKILL.md`

**Équivalent CLI** : `./check-markdown-rules.sh`

---

## Dépannage

### Commande non reconnue

**Symptôme** : `/ma-commande` → "Unknown command"

**Solutions** :
1. Vérifier que le fichier existe : `.claude/commands/ma-commande.MD`
2. Vérifier le frontmatter : `name: ma-commande`
3. Relancer Claude Code

### Skill non chargé

**Symptôme** : Commande reconnue mais skill ne s'exécute pas

**Solutions** :
1. Vérifier le chemin du skill dans la commande
2. Vérifier que le skill existe
3. Vérifier le frontmatter du skill

### Arguments non passés

**Symptôme** : Arguments ignorés par le skill

**Solution** : Les arguments sont dans le contexte, le skill doit les récupérer explicitement.

---

## Ressources

- **Documentation officielle** : [Claude Code Commands](https://docs.claude.com/claude-code/commands)
- **Guide skills** : `docs-public/guides/creer-un-skill.md`
- **Exemples** : `.claude/commands/` du workspace
- **Architecture** : `CLAUDE.MD` section "Commandes disponibles"

---

**Dernière mise à jour** : 2026-02-08
