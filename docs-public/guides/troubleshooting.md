# Guide : dépannage (troubleshooting)

**Niveau** : Tous niveaux
**Usage** : Guide de référence pour résoudre problèmes courants

---

## Problèmes de mémoire hiérarchique

### Claude ne charge pas mes mémoires

**Symptôme** : Claude ne semble pas suivre les instructions de CLAUDE.MD

**Diagnostic** :

```bash
# 1. Vérifier votre position
pwd
# Doit être dans le bon répertoire

# 2. Vérifier que les fichiers existent
ls -la *.MD
ls -la CLAUDE.MD
ls -la claude.local.md

# 3. Vérifier le contenu
cat CLAUDE.MD
```

**Solutions** :

#### Solution 1 : Vérifier noms de fichiers

Les noms sont **sensibles à la casse** :

**Correct** :
- `CLAUDE.MD` (majuscules)
- `claude.local.md` (minuscules)

**Incorrect** :
- `claude.md` (minuscules pour workspace)
- `CLAUDE.LOCAL.MD` (majuscules pour local)

#### Solution 2 : Vérifier position

Claude charge les mémoires depuis votre `cwd` :

```bash
# Mauvais
cd ~
# Claude cherche ~/CLAUDE.MD (n'existe pas)

# Bon
cd ~/Claude
# Claude cherche ~/Claude/CLAUDE.MD (existe)
```

#### Solution 3 : Vérifier contenu

Le fichier ne doit pas être vide :

```bash
# Vérifier taille
ls -lh CLAUDE.MD
# Doit être > 0 bytes

# Vérifier contenu
head -20 CLAUDE.MD
```

#### Solution 4 : Forcer rechargement

Parfois Claude garde un cache :

```bash
# Quitter et relancer Claude Code
exit
claude

# Ou créer nouvelle session
cd ~/Claude
claude
```

---

### Mémoires en conflit

**Symptôme** : Comportements contradictoires de Claude

**Diagnostic** :

```bash
# Lister toutes les mémoires chargées
cat ~/.claude/CLAUDE.MD | head -5
cat ~/Claude/CLAUDE.MD | head -5
cat CLAUDE.MD | head -5
cat claude.local.md | head -5
```

**Solution** : Vérifier hiérarchie

**Ordre de priorité** (du plus au moins prioritaire) :
1. `claude.local.md` (local) - gagne toujours
2. `CLAUDE.MD` (projet)
3. `~/Claude/CLAUDE.MD` (workspace)
4. `~/.claude/CLAUDE.MD` (personnel)
5. `/opt/claude/CLAUDE.MD` (entreprise)

**Exemple de conflit** :

```markdown
# ~/.claude/CLAUDE.MD (personnel)
Langue : Français

# ~/Claude/active/projet/CLAUDE.MD (projet)
Langue : Anglais
```

**Résultat** : Claude parle Anglais (projet gagne sur personnel)

**Correction** : Retirer la surcharge si non intentionnelle.

---

### Liens symboliques cassés

**Symptôme** : `config-claude/` ou liens internes cassés

**Diagnostic** :

```bash
# Vérifier tous les liens
ls -la config-claude/
ls -la .claude/hooks
ls -la .claude/zshrc
ls -la .claude/CLAUDE-personal.MD
```

**Solution** : Relancer setup

```bash
cd ~/Claude
./setup.sh
```

**Ou manuellement** :

```bash
# Supprimer liens cassés
rm config-claude 2>/dev/null
rm .claude/hooks 2>/dev/null
rm .claude/zshrc 2>/dev/null
rm .claude/CLAUDE-personal.MD 2>/dev/null

# Recréer
ln -s .claude config-claude
cd .claude
ln -s ../.git-hooks hooks
ln -s ~/.zshrc zshrc
ln -s ~/.claude/CLAUDE.MD CLAUDE-personal.MD
```

---

## Problèmes de hooks Git

### Hook pre-commit ne fonctionne pas

**Symptôme** : Commits passent même avec violations Markdown

**Diagnostic** :

```bash
# 1. Vérifier que le hook existe
ls -l .git/hooks/pre-commit

# 2. Vérifier qu'il est exécutable
ls -l .git/hooks/pre-commit
# Doit avoir 'x' dans permissions

# 3. Tester manuellement
.git/hooks/pre-commit
```

**Solutions** :

#### Solution 1 : Hook manquant

```bash
# Copier depuis template
cp .git-hooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

#### Solution 2 : Hook non exécutable

```bash
chmod +x .git/hooks/pre-commit
```

#### Solution 3 : Mauvais repository

Vérifier que vous êtes dans le bon repo :

```bash
pwd
# Doit être ~/Claude/

git rev-parse --show-toplevel
# Doit afficher ~/Claude
```

#### Solution 4 : Réinstaller complètement

```bash
cd ~/Claude
./setup.sh
```

---

### Hook bloque à tort

**Symptôme** : Hook détecte violations qui n'existent pas

**Diagnostic** :

```bash
# Vérifier manuellement
./check-markdown-rules.sh
```

**Causes fréquentes** :

#### Cause 1 : Exemples de mauvais code

Fichier comme `markdown-rules.md` contient des exemples de **mauvais** code :

```markdown
## Mauvais
## Vue d'Ensemble  # ← Détecté comme violation
```

**Solution** : Exclure du commit ou committer avec `--no-verify`

```bash
git restore --staged .claude/rules/markdown-rules.md
git commit -m "Message"
```

#### Cause 2 : Faux positifs noms propres

Le hook détecte "API REST" comme violation mais c'est un nom propre.

**Solution** : Ajouter à la liste d'exceptions

Éditer `.git-hooks/pre-commit` et `.git/hooks/pre-commit` :

```bash
# Ajouter dans la ligne des exceptions
grep -v "Claude Code|GitHub|...|API REST|..."
```

#### Cause 3 : Placeholders dans templates

Templates contiennent `{{PROJECT_NAME}}` détecté comme violation.

**Solution** : Normal, les templates ne sont pas commités normalement.

---

### Hook trop lent

**Symptôme** : Commit prend 10+ secondes

**Diagnostic** :

```bash
# Compter fichiers Markdown
find . -name "*.md" -o -name "*.MD" | wc -l
```

Si > 100 fichiers : optimisation nécessaire

**Solution** : Modifier hook pour vérifier seulement fichiers staged

Déjà implémenté dans le hook actuel :

```bash
# Vérifie seulement les fichiers staged
git diff --cached --name-only --diff-filter=ACM
```

---

## Problèmes d'alias

### Alias ne fonctionnent pas

**Symptôme** : `cdcl` → "command not found"

**Diagnostic** :

```bash
# 1. Vérifier que alias est défini
alias cdcl
# Doit afficher : cdcl='cd ~/Claude'

# 2. Vérifier dans ~/.zshrc
grep "cdcl" ~/.zshrc

# 3. Vérifier shell
echo $SHELL
# Doit être /bin/zsh ou /usr/bin/zsh
```

**Solutions** :

#### Solution 1 : Alias non installés

```bash
# Installer les alias
cat ~/Claude/setup-aliases.sh >> ~/.zshrc

# Recharger config
source ~/.zshrc
```

#### Solution 2 : Config non rechargée

```bash
source ~/.zshrc

# Ou
reloadzshrc  # si alias déjà installés
```

#### Solution 3 : Mauvais shell

Si vous utilisez bash au lieu de zsh :

```bash
# Changer shell par défaut
chsh -s /bin/zsh

# Ou installer alias pour bash
cat ~/Claude/setup-aliases.sh >> ~/.bashrc
source ~/.bashrc
```

#### Solution 4 : Conflit d'alias

Un autre alias porte le même nom :

```bash
# Trouver les conflits
alias | grep cdcl

# Supprimer l'ancien
unalias cdcl

# Recharger
source ~/.zshrc
```

---

### Alias pointe vers mauvais endroit

**Symptôme** : `cdcl` va dans le mauvais répertoire

**Diagnostic** :

```bash
alias cdcl
# Vérifier le chemin
```

**Solution** : Corriger dans ~/.zshrc

```bash
# Éditer
code ~/.zshrc

# Trouver ligne cdcl
# Corriger le chemin
alias cdcl="cd ~/Claude"  # Bon chemin

# Sauver et recharger
source ~/.zshrc
```

---

## Problèmes de skills et commandes

### Commande slash non reconnue

**Symptôme** : `/ma-commande` → "Unknown command"

**Diagnostic** :

```bash
# Vérifier que le fichier existe
ls -l .claude/commands/ma-commande.MD

# Vérifier le contenu
cat .claude/commands/ma-commande.MD
```

**Solutions** :

#### Solution 1 : Fichier manquant

```bash
# Créer le fichier
touch .claude/commands/ma-commande.MD

# Ajouter contenu minimal
cat > .claude/commands/ma-commande.MD << 'EOF'
---
name: ma-commande
---

Description de la commande.
EOF
```

#### Solution 2 : Mauvais nom de fichier

Le nom du fichier doit correspondre au nom dans frontmatter :

**Fichier** : `init.MD`
**Frontmatter** :
```yaml
name: init  # ✓ Correspond
```

#### Solution 3 : Frontmatter invalide

```bash
# Vérifier format YAML
cat .claude/commands/ma-commande.MD | head -5
```

Doit avoir :
```yaml
---
name: ma-commande
---
```

Pas :
```yaml
name: ma-commande  # ✗ Manque ---
```

#### Solution 4 : Relancer Claude

```bash
# Quitter et relancer
exit
claude
```

---

### Skill ne s'exécute pas

**Symptôme** : Commande reconnue mais workflow ne démarre pas

**Diagnostic** :

```bash
# Vérifier que le skill existe
ls -l .claude/skills/mon-skill/SKILL.md

# Vérifier référence dans commande
grep "skills" .claude/commands/ma-commande.MD
```

**Solutions** :

#### Solution 1 : Chemin incorrect

Vérifier que la commande référence le bon chemin :

```markdown
Charge le skill : `.claude/skills/mon-skill/SKILL.md`
```

Pas :
```markdown
Charge le skill : skills/mon-skill.md  # ✗ Chemin incorrect
```

#### Solution 2 : Skill invalide

Vérifier le frontmatter du skill :

```yaml
---
name: mon-skill
description: Description
context: fork  # ou task
---
```

---

### Agent ne répond pas

**Symptôme** : Task() n'invoque pas l'agent

**Diagnostic** :

```bash
# Vérifier que l'agent existe
ls -l .claude/agents/mon-agent.md

# Vérifier frontmatter
head -10 .claude/agents/mon-agent.md
```

**Solutions** :

#### Solution 1 : Agent manquant

Créer l'agent (voir `creer-un-agent.md`)

#### Solution 2 : Mauvais nom

Le skill doit utiliser le nom exact :

```markdown
Utilise Task() pour invoquer mon-agent
```

Pas :
```markdown
Utilise Task() pour invoquer MonAgent  # ✗ Mauvais nom
```

---

## Problèmes de rules

### Rules non appliquées

**Symptôme** : Claude ne suit pas les rules définies

**Diagnostic** :

```bash
# Vérifier que la rule existe
ls -l .claude/rules/ma-rule.md

# Vérifier frontmatter
head -10 .claude/rules/ma-rule.md
```

**Solutions** :

#### Solution 1 : Paths manquants ou incorrects

Vérifier le frontmatter :

```yaml
---
name: api-rules
paths: ["src/api/**", "src/routes/**"]  # ✓ Auto-chargement
---
```

Sans `paths:`, la rule n'est PAS chargée automatiquement.

#### Solution 2 : Pattern paths incorrect

Tester le pattern :

```bash
# Vérifier que le pattern matche des fichiers
ls src/api/**/*.ts
```

Si aucun fichier : le pattern est incorrect.

#### Solution 3 : Forcer rechargement

Modifier un fichier qui match le pattern :

```bash
touch src/api/users.ts
```

Puis demander à Claude de lire ce fichier.

---

### Trop de rules chargées

**Symptôme** : Claude est lent ou oublie des instructions

**Cause** : Explosion du contexte (trop de rules)

**Diagnostic** :

```bash
# Compter les rules
ls .claude/rules/*.md | wc -l

# Vérifier taille totale
du -sh .claude/rules/
```

Si > 10 rules ou > 100KB : trop

**Solution** : Réduire scope

**Avant** :
```yaml
paths: ["**/*.ts"]  # ✗ Trop large, charge toujours
```

**Après** :
```yaml
paths: ["src/api/**/*.ts"]  # ✓ Spécifique
```

---

## Problèmes de performance

### Claude est lent

**Symptôme** : Réponses prennent 30+ secondes

**Causes possibles** :

1. **Trop de contexte** : Trop de mémoires/rules chargées
2. **Fichiers volumineux** : Lecture de gros fichiers
3. **Trop d'agents** : Trop de Task() en parallèle

**Solutions** :

#### Solution 1 : Réduire contexte

```bash
# Vérifier taille des mémoires
wc -l CLAUDE.MD ~/.claude/CLAUDE.MD

# Si > 1000 lignes : simplifier
```

#### Solution 2 : Utiliser agents

Déléguer tâches complexes aux agents (isolation contexte)

#### Solution 3 : Limiter scope

```bash
# Au lieu de
/review

# Faire
/review src/components/Button.tsx
```

---

### Erreur "Context too large"

**Symptôme** : "Your message exceeded the context window"

**Cause** : Trop de contenu chargé d'un coup

**Solutions** :

#### Solution 1 : Utiliser context: fork

Dans les skills :

```yaml
context: fork  # Isole le contexte
```

#### Solution 2 : Réduire scope

Traiter par petits morceaux au lieu d'un gros batch.

#### Solution 3 : Nettoyer mémoires

Supprimer contenu redondant dans CLAUDE.MD.

---

## Problèmes d'installation

### setup.sh échoue

**Symptôme** : Erreurs lors de `./setup.sh`

**Diagnostic** :

```bash
# Relancer avec debug
bash -x ./setup.sh
```

**Solutions courantes** :

#### Solution 1 : Permissions

```bash
chmod +x ./setup.sh
./setup.sh
```

#### Solution 2 : Mauvais répertoire

```bash
# Doit être dans ~/Claude
cd ~/Claude
./setup.sh
```

#### Solution 3 : Fichiers manquants

```bash
# Vérifier que .git-hooks/ existe
ls -la .git-hooks/

# Vérifier que .claude/ existe
ls -la .claude/
```

---

### Alias non installés après setup

**Symptôme** : `cdcl` ne fonctionne pas après setup

**Cause** : setup.sh n'installe PAS les alias automatiquement

**Solution** : Installation manuelle

```bash
cat ~/Claude/setup-aliases.sh >> ~/.zshrc
source ~/.zshrc
```

---

## Problèmes de commits

### Commit bloqué sans raison

**Symptôme** : Hook bloque mais aucune violation visible

**Diagnostic** :

```bash
# Voir ce qui est staged
git diff --cached --name-only

# Vérifier manuellement
./check-markdown-rules.sh
```

**Solutions** :

#### Solution 1 : Bypasser temporairement

```bash
git commit --no-verify -m "Message"
```

**Attention** : À utiliser seulement si vous êtes sûr.

#### Solution 2 : Unstage le fichier problématique

```bash
git restore --staged fichier-problematique.MD
git commit -m "Message"
```

Puis corriger le fichier et committer séparément.

---

### Git hook erreur de syntaxe

**Symptôme** : Hook affiche erreur bash

**Diagnostic** :

```bash
# Vérifier syntaxe
bash -n .git/hooks/pre-commit
```

**Solution** : Réinstaller le hook

```bash
cp .git-hooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

---

## Ressources d'aide

### Documentation

- **FAQ** : `FAQ.MD`
- **CLAUDE.MD** : Documentation complète du workspace
- **Guides** : `docs-public/guides/`

### Commandes utiles

```bash
# Vérifier Markdown
./check-markdown-rules.sh

# Relancer setup
./setup.sh

# Recharger alias
source ~/.zshrc

# Tester hook
.git/hooks/pre-commit
```

### Obtenir de l'aide

Si problème non résolu :

1. **Lire FAQ.MD** : Section troubleshooting
2. **Vérifier STRUCTURE.txt** : Comprendre organisation
3. **Consulter guides** : `docs-public/guides/`
4. **Issues GitHub** : Créer une issue si bug

---

**Dernière mise à jour** : 2026-02-08
