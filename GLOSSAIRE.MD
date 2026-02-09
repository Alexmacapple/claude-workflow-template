# Glossaire

**Définitions des termes clés du workflow Claude Code**

---

## A

### ADR (Architecture Decision Record)

Document structuré qui enregistre une décision d'architecture importante.

**Contenu** : Contexte, décision, options considérées, justification, conséquences

**Localisation** : `docs/ADR/XXX-titre-decision.md`

**Exemple** : ADR-001-choix-react.md

**Voir** : templates/ADR-template.md

---

### Agent

Spécialiste autonome avec contexte isolé, invoqué par un skill via `Task()`.

**Caractéristiques** :
- Outils restreints
- Une responsabilité
- Contexte propre
- Retour structuré

**Localisation** : `.claude/agents/nom-agent.md`

**Exemple** : security-audit-agent.md

**Voir** : docs-public/guides/creer-un-agent.md

---

### Alias

Raccourci shell pour accéder rapidement à des commandes fréquentes.

**Exemple** : `cdcl` → `cd ~/Claude`

**Nombre** : 44 alias disponibles

**Installation** : `cat setup-aliases.sh >> ~/.zshrc`

**Voir** : setup-aliases.sh, FAQ.MD

---

### Architecture en 3 niveaux

Principe d'organisation du code Claude Code : Skills → Agents → Rules

**Niveau 1** : Skills (orchestrateurs)
**Niveau 2** : Agents (spécialistes)
**Niveau 3** : Rules (contraintes)

**Voir** : CLAUDE.MD, GUIDELINES-CLAUDE-CODE.MD

---

## B

### BRIEF

Cahier des charges d'un projet.

**Contenu** : Contexte, objectifs, fonctionnalités MVP, contraintes, critères de succès

**Localisation** : `docs/BRIEF.md`

**Template** : Disponible dans chaque template de projet

**Voir** : templates/projet-*/BRIEF.template.md

---

## C

### Claude Code

CLI officielle d'Anthropic pour interagir avec Claude en ligne de commande.

**Modes** :
- `claude` : Mode YOLO (pas de confirmations)
- `claude-safe` : Mode normal (avec confirmations)

**Voir** : ~/.claude/CLAUDE.MD, prd-meta-workflow/PRD-001-claude-yolo-aliases.MD

---

### Commande slash

Commande personnalisée invoquée par `/nom-commande`.

**Localisation** : `.claude/commands/nom-commande.MD`

**Exemples** :
- `/init` : Initialiser un projet
- `/verifier-regles-md` : Auditer Markdown

**Voir** : .claude/commands/

---

### Context

Mode d'exécution d'un skill.

**`context: fork`** : Contexte isolé (recommandé)
**`context: task`** : Délégation à un agent

**Voir** : docs-public/guides/creer-un-skill.md

---

## D

### Déploiement

Mise en production d'une application.

**Frontend** : Vercel, Netlify
**Backend** : Railway, Render, Heroku

**Voir** : docs/STACK.md des templates

---

## E

### Epic

Grande fonctionnalité découpée en plusieurs user stories.

**Exemple** : "Authentification utilisateur" contient : inscription, connexion, mot de passe oublié

**Voir** : MON-PREMIER-PROJET-HOW-TO.MD

---

## F

### Fork (context)

Mode d'exécution d'un skill qui crée un contexte isolé.

**Avantage** : Réduit la consommation de tokens

**Usage** : `context: fork` dans le frontmatter du skill

**Voir** : docs-public/guides/creer-un-skill.md

---

### Frontmatter

Métadonnées en YAML en début de fichier Markdown.

**Exemple** :
```yaml
---
name: mon-agent
description: Description courte
tools: [Read, Write]
---
```

**Usage** : Skills, Agents, Rules, Commandes

---

## G

### Gitignore

Fichier `.gitignore` listant les fichiers à exclure de Git.

**Contenu typique** :
- node_modules/
- .env
- claude.local.md
- dist/

**Voir** : templates/*/.gitignore.template

---

## H

### Hook Git

Script automatique exécuté à certains événements Git.

**pre-commit** : Vérifie conformité Markdown avant commit

**Localisation** :
- Template : `.git-hooks/pre-commit`
- Actif : `.git/hooks/pre-commit`

**Voir** : docs-public/guides/git-hooks-guide.md

---

## I

### /init

Commande slash pour initialiser un nouveau projet.

**Usage** : `/init nom-du-projet`

**Actions** :
- Créer structure de dossiers
- Générer CLAUDE.MD
- Créer .gitignore
- Initialiser Git

**Voir** : .claude/commands/init.MD

---

## K

### kebab-case

Convention de nommage avec traits d'union.

**Exemple** : `mon-super-projet`

**Usage** : Noms de projets, skills, agents, branches Git

**Voir** : .claude/rules/naming-rules.md

---

## M

### Mémoire hiérarchique

Système de chargement de configurations par niveaux.

**5 niveaux** :
1. Entreprise : `/opt/claude/CLAUDE.MD`
2. Personnelle : `~/.claude/CLAUDE.MD`
3. Workspace : `~/Claude/CLAUDE.MD`
4. Projet : `~/Claude/active/projet/CLAUDE.MD`
5. Locale : `~/Claude/active/projet/claude.local.md`

**Priorité** : Local > Projet > Workspace > Personnel > Entreprise

**Voir** : CLAUDE.MD, FAQ.MD, STRUCTURE.txt

---

### Mémoire locale

Configuration gitignored d'un projet (credentials, notes perso).

**Fichier** : `claude.local.md`

**Template** : .claude/claude.local.template.md

**Voir** : FAQ.MD section "Où mettre mes notes personnelles"

---

### Mémoire personnelle

Configuration universelle appliquée à tous les workspaces.

**Fichier** : `~/.claude/CLAUDE.MD`

**Contenu** : Langue, style, préférences, alias

**Voir** : ~/.claude/CLAUDE.MD

---

### Mémoire projet

Configuration spécifique à un projet.

**Fichier** : `~/Claude/active/projet/CLAUDE.MD`

**Contenu** : Specs, stack, contraintes, conventions

**Voir** : templates/*/CLAUDE.template.md

---

### Mémoire workspace

Configuration spécifique au workflow Claude.

**Fichier** : `~/Claude/CLAUDE.MD`

**Contenu** : Architecture, skills, agents, rules, structure

**Voir** : CLAUDE.MD

---

### Mode YOLO

Mode Claude Code sans confirmations (`--dangerously-skip-permissions`).

**Commande** : `claude`

**Vs** : `claude-safe` (avec confirmations)

**Risques** : Exécution sans validation

**Précautions** : Commits fréquents, backups, environnement isolé

**Voir** : ~/.claude/CLAUDE.MD, prd-meta-workflow/PRD-001-claude-yolo-aliases.MD

---

### MVP (Minimum Viable Product)

Version minimale fonctionnelle d'un produit.

**Contenu** : Fonctionnalités essentielles uniquement

**Voir** : BRIEF.template.md section "Fonctionnalités MVP"

---

## N

### No Spec, No Code

Principe du workflow : toujours partir d'une spécification avant de coder.

**Spec** = BRIEF.md + STACK.md + ADR

**Voir** : CLAUDE.MD section "Philosophie"

---

## O

### ORM (Object-Relational Mapping)

Outil pour manipuler une base de données avec du code objet.

**Exemple** : Prisma (recommandé dans les templates)

**Voir** : templates/projet-fullstack/STACK.template.md

---

## P

### Paths (dans les rules)

Patterns de fichiers qui déclenchent le chargement automatique d'une rule.

**Exemple** :
```yaml
paths: ["src/api/**", "src/routes/**"]
```

**Voir** : docs-public/guides/creer-une-rule.md

---

### PRD (Product Requirements Document)

Document de spécification produit.

**Localisation** : `prd-meta-workflow/PRD-XXX.MD`

**Usage** : Documentation des décisions du workflow lui-même (méta)

**Voir** : prd-meta-workflow/

---

## R

### Rule

Ensemble de contraintes et bonnes pratiques chargées automatiquement.

**Caractéristiques** :
- Passive (ne s'exécute pas)
- Chargée selon fichiers touchés
- Guide le comportement

**Localisation** : `.claude/rules/domain-rules.md`

**Exemples** : markdown-rules.md, git-rules.md, naming-rules.md

**Voir** : docs-public/guides/creer-une-rule.md

---

## S

### Skill

Orchestrateur de workflow invoqué par `/commande`.

**Caractéristiques** :
- Orchestre les agents
- Ne fait pas le travail lui-même
- Retourne un résumé

**Localisation** : `.claude/skills/nom-skill/SKILL.md`

**Exemples** : /init, /verifier-regles-md

**Voir** : docs-public/guides/creer-un-skill.md

---

### STACK

Document décrivant la stack technique d'un projet.

**Contenu** : Frontend, backend, database, DevOps, justifications

**Localisation** : `docs/STACK.md`

**Template** : Disponible dans chaque template de projet

**Voir** : templates/projet-*/STACK.template.md

---

## T

### Task()

Fonction pour invoquer un agent depuis un skill.

**Syntaxe** : Dans le skill, instruire Claude d'utiliser Task()

**Exemple** :
```markdown
Utilise Task() pour invoquer security-audit-agent avec :
"Analyse le fichier : /path/to/file.js"
```

**Voir** : docs-public/guides/creer-un-skill.md

---

### Template

Structure réutilisable pour démarrer un projet.

**Types** :
- projet-fullstack
- projet-frontend
- projet-api
- projet-cli

**Localisation** : `~/Claude/templates/`

**Usage** : `cp -r ~/Claude/templates/projet-* ~/Claude/active/mon-projet`

**Voir** : templates/README.MD

---

## U

### User story

Fonctionnalité décrite du point de vue utilisateur.

**Format** : "En tant que [utilisateur], je veux [action] afin de [bénéfice]"

**Exemple** : "En tant qu'utilisateur, je veux me connecter afin d'accéder à mon compte"

**Voir** : MON-PREMIER-PROJET-HOW-TO.MD

---

## V

### /verifier-regles-md

Commande slash pour auditer la conformité Markdown.

**Usage** : `/verifier-regles-md`

**Vérifications** :
- Emojis interdits
- Capitalisation française
- Structure des documents

**Équivalent CLI** : `./check-markdown-rules.sh`

**Voir** : .claude/skills/verifier-regles-md/SKILL.md

---

## W

### Workflow

Ensemble d'étapes organisées pour accomplir une tâche.

**Exemples** :
- Workflow spec-to-code
- Workflow de développement
- Workflow Git

**Voir** : CLAUDE.MD section "Workflow"

---

### Workspace

Dossier racine du projet Claude.

**Localisation** : `~/Claude/`

**Contenu** :
- .claude/ : Configuration
- active/ : Projets en cours
- templates/ : Templates réutilisables
- docs-public/ : Documentation publique
- prd-meta-workflow/ : PRD du workflow

**Voir** : CLAUDE.MD, STRUCTURE.txt

---

## Y

### YOLO (Mode)

Voir **Mode YOLO**

---

## Symboles et abréviations

### .claude/

Dossier de configuration Claude Code.

**Alias** : `config-claude/` (lien symbolique)

**Contenu** :
- commands/ : Commandes slash
- skills/ : Skills
- agents/ : Agents
- rules/ : Rules
- Liens symboliques : CLAUDE-personal.MD, claude.local.md, env, gitignore, hooks/, zshrc

---

### .env

Fichier de variables d'environnement a la racine du workspace.

**Contenu** : Cles API (ANTHROPIC_API_KEY, ZAI_API_KEY, etc.)

**Securite** : Gitignored, jamais versionne

**Acces rapide** : `config-claude/env` (lien symbolique)

---

### ~/.claude/

Dossier de configuration personnelle Claude Code.

**Contenu** : CLAUDE.MD (memoire personnelle)

---

### ~/Claude/

Voir **Workspace**

---

## C (complement)

### CHANGELOG

Journal des modifications du workflow, base sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/).

**Fichier** : `CHANGELOG.MD`

**Sections** : Ajoute, Modifie, Deprecie, Retire, Corrige, Securite

---

### check-markdown-rules.sh

Script CLI de verification de conformite Markdown.

**Usage** : `./check-markdown-rules.sh`

**Verifications** : Emojis interdits, capitalisation francaise des titres

**Alias** : `checkmd`

---

### config-claude

Lien symbolique a la racine du workspace pointant vers `.claude/`.

**Avantage** : Acces rapide via Finder, GUI et CLI

**Creation** : `./setup.sh` ou `ln -s .claude config-claude`

---

## L

### Lien symbolique (symlink)

Fichier special qui pointe vers un autre fichier ou dossier.

**Liens dans le workspace** :
- `config-claude` -> `.claude/`
- `.claude/hooks` -> `../.git-hooks`
- `.claude/zshrc` -> `~/.zshrc`
- `.claude/CLAUDE-personal.MD` -> `~/.claude/CLAUDE.MD`
- `.claude/claude.local.md` -> `../claude.local.md`
- `.claude/env` -> `../.env`
- `.claude/gitignore` -> `../.gitignore`

**Installation** : `./setup.sh`

---

## S (complement)

### setup.sh

Script d'installation du workspace apres clone.

**Usage** : `cd ~/Claude && ./setup.sh`

**Actions** : Cree le lien config-claude, les liens symboliques dans .claude/, installe le hook pre-commit

---

### setup-aliases.sh

Script d'installation des alias zsh.

**Usage** : `cat setup-aliases.sh >> ~/.zshrc && source ~/.zshrc`

**Nombre** : 44 alias (navigation, edition, consultation, listing, outils)

---

## Conventions de nommage

| Type | Convention | Exemple |
|------|------------|---------|
| Projet | kebab-case | mon-super-projet |
| Skill | kebab-case | spec-to-code |
| Agent | kebab-case-agent | security-audit-agent |
| Rule | domain-rules | api-rules.md |
| Composant React | PascalCase | UserProfile.tsx |
| Fonction | camelCase | getUserById |
| Constante | UPPER_SNAKE_CASE | API_URL |
| Variable | camelCase | userName |
| Fichier utils | camelCase | formatDate.ts |
| Branche Git | feature/nom | feature/user-auth |

**Voir** : .claude/rules/naming-rules.md

---

## Ressources

### Documentation officielle

- Claude Code : https://docs.claude.com/claude-code
- Skills : https://docs.claude.com/claude-code/skills
- Agents : https://docs.claude.com/claude-code/agents
- Rules : https://docs.claude.com/claude-code/rules

### Documentation du workflow

- Vue d'ensemble : README.MD
- Mémoire workspace : CLAUDE.MD
- Mémoire personnelle : ~/.claude/CLAUDE.MD
- Structure : STRUCTURE.txt
- FAQ : FAQ.MD
- Guide pratique : MON-PREMIER-PROJET-HOW-TO.MD

---

**Dernière mise à jour** : 2026-02-08
**Version** : 1.0.0
