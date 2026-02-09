# FAQ - Foire aux questions

**Questions fréquentes sur le workflow Claude**

---

## Général

### Qu'est-ce que ce workspace ?

Un workspace organisé pour utiliser Claude Code de manière optimale avec :
- Architecture en 3 niveaux (Skills → Agents → Rules)
- Mémoire hiérarchique (5 niveaux)
- Documentation complète
- Outils d'automatisation

**Lire** : `README.MD` pour vue d'ensemble

---

### Par où commencer ?

```bash
cd ~/Claude
cat README.MD           # Vue d'ensemble
cat CLAUDE.MD           # Documentation complète
cat STRUCTURE.txt       # Visualisation de la structure
```

**Ensuite** : Lire `MON-PREMIER-PROJET-HOW-TO.MD` pour guide pratique complet

---

### Où trouver la documentation ?

**Documentation principale** :
- `README.MD` - Vue d'ensemble et démarrage rapide
- `CLAUDE.MD` - Mémoire workspace (architecture complète)
- `~/.claude/CLAUDE.MD` - Mémoire personnelle (conventions)
- `GUIDELINES-CLAUDE-CODE.MD` - Référentiel officiel
- `STRUCTURE.txt` - Visualisation de la structure
- `FAQ.MD` - Ce fichier

**Guides pratiques** :
- `MON-PREMIER-PROJET-HOW-TO.MD` - Créer un projet complet
- `docs-public/guides/` - Guides spécialisés

**Meta-documentation** :
- `prd-meta-workflow/` - Décisions et évaluations

---

## Mémoire hiérarchique

### Quelle est la différence entre les fichiers CLAUDE.MD ?

**5 niveaux de mémoire** :

0. **`/opt/claude/CLAUDE.MD`** (Mémoire entreprise)
   - Conventions d'entreprise (si existe)
   - S'applique à TOUS les utilisateurs de la machine
   - Priorité la plus basse

1. **`~/.claude/CLAUDE.MD`** (Mémoire personnelle)
   - Conventions universelles (langue, style)
   - Préférences outils (VS Code, iTerm2)
   - Mode YOLO, alias zsh
   - S'applique à TOUS les workspaces

2. **`~/Claude/CLAUDE.MD`** (Mémoire workspace)
   - Architecture du workflow Claude
   - Skills, Agents, Rules
   - Structure du workspace
   - Spécifique à CE workspace

3. **`~/Claude/active/projet/CLAUDE.MD`** (Mémoire projet)
   - Specs du projet
   - Stack technique
   - Contraintes spécifiques
   - Conventions projet

4. **`~/Claude/active/projet/claude.local.md`** (Mémoire locale)
   - Credentials, secrets
   - Notes perso
   - Configs locales
   - GITIGNORED (jamais versionné)

**Principe** : Chaque niveau hérite du supérieur et peut surcharger

---

### Que mettre dans chaque niveau de mémoire ?

**Mémoire personnelle** (`~/.claude/CLAUDE.MD`) :
- Langue (français)
- Style de communication
- Préférences d'outils
- Alias personnels
- → Ce qui est UNIVERSEL à tous vos projets

**Mémoire workspace** (`~/Claude/CLAUDE.MD`) :
- Architecture du workflow
- Structure du workspace
- Commandes disponibles
- → Ce qui concerne LE WORKFLOW lui-même

**Mémoire projet** (`projet/CLAUDE.MD`) :
- Specs du projet
- Stack technique
- Conventions spécifiques
- → Ce qui concerne CE PROJET

**Mémoire locale** (`projet/claude.local.md`) :
- Credentials (API keys, tokens)
- Notes de développement perso
- Configs machine locale
- → Ce qui est PERSONNEL et SENSIBLE

**Template disponible** : `.claude/claude.local.template.md`

---

### Comment les memoires sont chargees ?

Claude remonte l'arborescence depuis votre `cwd` (current working directory) :

**Exemple** : Vous êtes dans `~/Claude/active/mon-projet/`

```
Chargement automatique :
1. ~/.claude/CLAUDE.MD           (si existe)
2. ~/Claude/CLAUDE.MD             (si existe)
3. ~/Claude/active/mon-projet/CLAUDE.MD (si existe)
4. ~/Claude/active/mon-projet/claude.local.md (si existe)
```

**Priorité** : local > projet > workspace > personnel

---

### Puis-je avoir plusieurs workspaces ?

**Oui !** La mémoire personnelle (`~/.claude/CLAUDE.MD`) s'applique à tous.

**Exemple** :
```
~/Claude/           → Workspace principal
~/ClientX/          → Workspace client X
~/Perso/ProjetY/    → Projet perso Y
```

Chacun peut avoir son propre `CLAUDE.MD` (niveau workspace).

---

## Architecture (Skills, Agents, Rules)

### Quelle est la différence entre Skill, Agent et Rule ?

**Skill** (Niveau 1 - Orchestrateur) :
- Invoqué par `/commande`
- Orchestre le workflow
- Délègue aux agents
- NE FAIT PAS le travail lui-même
- Exemple : `/init`, `/spec-to-code`, `/review`

**Agent** (Niveau 2 - Spécialiste) :
- Invoqué par un skill via `Task()`
- Contexte isolé
- Outils restreints
- Fait le travail spécialisé
- Retourne résultat au skill
- Exemple : `test-runner-agent`, `code-reviewer-agent`

**Rule** (Niveau 3 - Contraintes) :
- Chargée automatiquement selon fichiers touchés
- Définit standards et bonnes pratiques
- Passive (pas d'exécution)
- Exemples de bon/mauvais code
- Exemple : `markdown-rules.md`, `git-rules.md`

**Métaphore** :
- Skill = Chef de projet (orchestre)
- Agent = Spécialiste (exécute)
- Rule = Guide de style (contraint)

---

### Quand créer un Agent vs une Rule ?

**Créer un Agent** quand :
- Vous avez besoin d'EXECUTER une tâche
- La tâche nécessite des outils (Read, Write, Bash, etc.)
- Vous voulez isoler le contexte
- Exemple : Lancer des tests, analyser du code, générer des fichiers

**Créer une Rule** quand :
- Vous voulez CONTRAINDRE le comportement
- Vous définissez des standards
- Vous donnez des exemples de bonnes pratiques
- Exemple : Conventions de nommage, style de code, structure

**Règle simple** : Action = Agent, Convention = Rule

---

### Comment créer mon premier Agent ?

**Localisation** : `.claude/agents/mon-agent.md`

**Structure minimale** :
```markdown
---
name: mon-agent
description: Description courte
tools: [Read, Write, Bash]
---

# Mon Agent

## Rôle

Ce que fait cet agent.

## Inputs attendus

Ce qu'il reçoit du skill.

## Outputs produits

Ce qu'il retourne au skill.

## Process

1. Étape 1
2. Étape 2
3. Retour résultat
```

**Voir guide** : `docs-public/guides/creer-un-agent.md`

---

### Comment créer mon premier Skill ?

**Localisation** : `.claude/skills/mon-skill/SKILL.md`

**Structure minimale** :
```markdown
---
name: mon-skill
description: Description courte
context: fork
---

# Mon Skill

## Objectif

Ce que fait ce skill.

## Workflow

1. Analyser le contexte
2. Déléguer à l'agent X via Task()
3. Traiter le résultat
4. Retourner résumé
```

**Voir guide** : `docs-public/guides/creer-un-skill.md`

---

## Installation et configuration

### Comment installer le workspace après clonage ?

```bash
cd ~/Claude
./setup.sh
```

**Ce script fait** :
1. Crée le lien config-claude à la racine
2. Crée les liens symboliques dans .claude/ (hooks, zshrc, CLAUDE-personal.MD, claude.local.md, gitignore, env)
3. Installe le hook pre-commit
4. Vérifie la configuration

**Optionnel - Installer les 44 alias** :
```bash
cat setup-aliases.sh >> ~/.zshrc
source ~/.zshrc
```

---

### Comment accéder rapidement aux fichiers de config ?

**Via lien symbolique** : `config-claude/` → `.claude/`

**Contenu** :
- `config-claude/commands/` - Slash commands
- `config-claude/skills/` - Skills
- `config-claude/agents/` - Agents
- `config-claude/rules/` - Rules
- `config-claude/CLAUDE-personal.MD` - Lien vers mémoire personnelle
- `config-claude/claude.local.md` - Lien vers mémoire locale workspace
- `config-claude/claude.local.template.md` - Template
- `config-claude/env` - Lien vers .env (variables d'environnement)
- `config-claude/gitignore` - Lien vers .gitignore
- `config-claude/hooks/` - Lien vers hooks Git
- `config-claude/zshrc` - Lien vers ~/.zshrc

**Via alias** (si installés) :
```bash
cdconfig          # Aller dans config-claude/
editconfig        # Ouvrir dans VS Code
lsconfig          # Lister contenu
```

---

### Quels sont les alias disponibles ?

**44 alias disponibles** (voir `setup-aliases.sh`)

**Navigation** (14 alias) :
```bash
cdcl, cdconfig, cdskills, cdagents, cdrules, cdcommands,
cdhooks, cdprd, cddocs-perso, cddocs-public, cdactive,
cdtemplates, cdarchive, cdclaudeconfig
```

**Edition** (6 alias) :
```bash
editclaude, editpersonal, editconfig, editskills,
edithooks, editclaudeconfig
```

**Consultation** (8 alias) :
```bash
catclaude, catpersonal, catlocal-template, catstructure,
catreadme, cathowto, cathook, catclaudeconfig
```

**Listing** (5 alias) :
```bash
lsclaude, lsconfig, lsactive, lshooks, lsprd
```

**Claude Code** (2 alias) :
```bash
claude          # Mode YOLO (pas de confirmations)
claude-safe     # Mode normal (avec confirmations)
```

**Gestion zsh** (3 alias) :
```bash
catzshrc, editzshrc, reloadzshrc
```

**Outils** (1 alias) :
```bash
checkmd         # Vérifier conformité Markdown
```

**Installation** : `cat setup-aliases.sh >> ~/.zshrc && source ~/.zshrc`

---

## Utilisation quotidienne

### Comment créer un nouveau projet ?

**Méthode 1 - Avec /init (recommandé)** :
```
/init mon-nouveau-projet
```

**Méthode 2 - Manuelle** :
```bash
mkdir -p ~/Claude/active/mon-projet/{docs/ADR,src,tests,.claude/{agents,rules}}
cd ~/Claude/active/mon-projet
# Créer CLAUDE.MD, BRIEF.md, STACK.md
```

**Voir guide complet** : `MON-PREMIER-PROJET-HOW-TO.MD`

---

### Comment vérifier la conformité Markdown ?

**2 méthodes disponibles** :

**Méthode 1 - CLI rapide** :
```bash
./check-markdown-rules.sh
```

**Méthode 2 - Skill interactif** :
```
/verifier-regles-md
```

**Vérifications automatiques** :
- Emojis interdits dans .MD
- Capitalisation française des titres
- Génère rapport avec propositions

---

### Comment fonctionne le hook pre-commit ?

**Déclenchement** : Automatique à chaque `git commit`

**Vérifications** :
1. Détecte fichiers .MD staged
2. Vérifie emojis interdits
3. Vérifie capitalisation des titres
4. Bloque commit si violations

**Si violation détectée** :
```bash
# Corriger les fichiers
# Relancer le commit
git commit -m "Message"
```

**Bypasser** (déconseillé) :
```bash
git commit --no-verify
```

**Documentation** : `docs-public/guides/git-hooks-guide.md`

---

### Où mettre mes notes personnelles ?

**Pour un projet** : `claude.local.md` (gitignored)
```bash
cp ~/Claude/.claude/claude.local.template.md ./claude.local.md
```

**Pour le workspace** : `~/Claude/docs-perso/`
- `docs-perso/notes/` - Notes et idées
- `docs-perso/journal/` - Journal de bord
- `docs-perso/snippets/` - Code snippets

**IMPORTANT** : `docs-perso/` est gitignored (privé)

---

### Comment archiver un projet terminé ?

```bash
# Nettoyer
cd ~/Claude/active/mon-projet
rm -rf node_modules/ .env*

# Ajouter bilan final dans README.MD
# Documenter leçons apprises

# Déplacer
mv ~/Claude/active/mon-projet ~/Claude/archive/

# Optionnel - Compresser
cd ~/Claude/archive
tar -czf mon-projet-$(date +%Y-%m-%d).tar.gz mon-projet/
```

---

## Commandes disponibles

### Quelles commandes slash sont disponibles ?

**Actuellement implémentées** :
- `/init <nom>` - Initialiser un nouveau projet
- `/verifier-regles-md` - Vérifier conformité Markdown

**Prochainement** (selon roadmap) :
- `/spec-to-code` - Pipeline spec → code
- `/review` - Review de code
- `/refactor` - Refactoring guidé
- `/test` - Lancer et analyser tests

---

### Comment utiliser le Mode YOLO ?

**Mode YOLO** = `--dangerously-skip-permissions`
- Désactive toutes les confirmations
- Claude exécute sans demander

**Commandes** :
```bash
claude           # Mode YOLO (défaut avec alias)
claude-safe      # Mode normal (avec confirmations)
```

**Quand utiliser YOLO** :
- Environnement de dev isolé
- Commits Git fréquents
- Backups réguliers

**Quand utiliser SAFE** :
- Opérations critiques
- Fichiers sensibles
- Doute sur l'impact

**Documentation** : `prd-meta-workflow/PRD-001-claude-yolo-aliases.MD`

---

## Troubleshooting

### Claude ne charge pas mes mémoires

**Vérifier** :
1. Vous êtes dans le bon répertoire (`pwd`)
2. Les fichiers existent (`ls -la *.MD`)
3. Les noms sont corrects (CLAUDE.MD en majuscules)
4. Les fichiers ne sont pas vides

**Test** :
```bash
cd ~/Claude/active/mon-projet
cat CLAUDE.MD      # Doit afficher le contenu
```

---

### Le hook pre-commit ne fonctionne pas

**Vérifier** :
1. Hook installé : `ls -l .git/hooks/pre-commit`
2. Hook exécutable : `chmod +x .git/hooks/pre-commit`
3. Repositionné dans le bon repo : `pwd` doit être dans ~/Claude

**Réinstaller** :
```bash
cp .git-hooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

---

### Les alias ne fonctionnent pas

**Vérifier** :
1. Alias installés : `cat ~/.zshrc | grep cdcl`
2. Config rechargée : `source ~/.zshrc`
3. Shell zsh : `echo $SHELL` (doit être `/bin/zsh`)

**Réinstaller** :
```bash
cat ~/Claude/setup-aliases.sh >> ~/.zshrc
source ~/.zshrc
```

---

### Je ne trouve pas un fichier

**Utiliser STRUCTURE.txt** :
```bash
cat ~/Claude/STRUCTURE.txt
```

**Ou les alias** :
```bash
cdcl              # Aller au workspace
lsclaude          # Lister contenu
```

---

## Questions avancées

### Comment personnaliser le workflow ?

**Niveaux de personnalisation** :

1. **Personnel** : Modifier `~/.claude/CLAUDE.MD`
2. **Workspace** : Modifier `~/Claude/CLAUDE.MD`
3. **Projet** : Créer `projet/CLAUDE.MD`
4. **Local** : Créer `projet/claude.local.md`

**Ajouter** :
- Skills custom dans `.claude/skills/`
- Agents custom dans `.claude/agents/`
- Rules custom dans `.claude/rules/`

---

### Comment contribuer au workflow ?

**Pour améliorer le workflow lui-même** :

1. Documenter dans `prd-meta-workflow/BACKLOG.MD`
2. Créer un PRD si décision majeure
3. Implémenter
4. Documenter dans CHANGELOG.MD
5. Mettre à jour CLAUDE.MD

**Traçabilité** : Tout doit être documenté

---

### Où trouver de l'aide ?

**Documentation** :
- Ce fichier (FAQ.MD)
- CLAUDE.MD (complet)
- MON-PREMIER-PROJET-HOW-TO.MD (guide pratique)
- GUIDELINES-CLAUDE-CODE.MD (référentiel)

**Ressources officielles Claude Code** :
- [Documentation](https://docs.claude.com/claude-code)
- [Skills](https://docs.claude.com/claude-code/skills)
- [Agents](https://docs.claude.com/claude-code/agents)
- [Rules](https://docs.claude.com/claude-code/rules)

---

**Dernière mise à jour** : 2026-02-08
**Version** : 1.0.0

**Une question manquante ?** Ajoutez-la dans `prd-meta-workflow/BACKLOG.MD`
