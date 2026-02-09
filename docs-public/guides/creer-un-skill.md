# Guide : créer un skill Claude Code

**Niveau** : Avancé
**Durée** : 20-30 minutes
**Prérequis** : Comprendre l'architecture en 3 niveaux et avoir créé un agent

---

## Qu'est-ce qu'un skill ?

Un **skill** est un orchestrateur de workflow :
- **Invoqué par l'utilisateur** : Via `/commande`
- **Orchestre le travail** : Délègue aux agents via `Task()`
- **Ne fait pas le travail lui-même** : Coordonne seulement
- **Retourne un résumé** : Rapport final à l'utilisateur

**Métaphore** : Un skill = un chef de projet qui coordonne les experts (agents).

---

## Quand créer un skill ?

Créer un skill quand :

- Vous avez un **workflow récurrent** à automatiser
- Le workflow implique **plusieurs étapes** ou agents
- Vous voulez une **commande réutilisable** (`/commande`)
- Vous devez **orchestrer** plusieurs opérations complexes

**Exemples** :
- `/spec-to-code` : Pipeline complet de spec à code
- `/review` : Review de code automatique
- `/refactor` : Refactorisation guidée
- `/test` : Lancer et analyser les tests

---

## Structure d'un skill

### Localisation

```
.claude/skills/mon-skill/SKILL.md
```

**Note** : Un skill a son propre dossier (peut contenir plusieurs fichiers).

### Frontmatter (obligatoire)

```yaml
---
name: mon-skill                # Nom unique (kebab-case)
description: Description courte # Une phrase claire
context: fork                  # fork ou task
---
```

### Options de contexte

**`context: fork`** (recommandé) :
- Crée un nouveau contexte isolé
- Réduit la consommation de tokens
- Retourne un résumé au contexte principal

**`context: task`** (optionnel) :
- Délègue à un agent
- Utilisé pour des skills simples qui font une seule chose

---

## Sections recommandées

```markdown
# Mon Skill

## Objectif

Ce que fait ce skill (1-2 phrases).

## Inputs

Ce que l'utilisateur doit fournir.

Exemple : "Chemin du fichier ou dossier à analyser"

## Workflow

1. Étape 1 : Analyser le contexte
2. Étape 2 : Déléguer à l'agent X via Task()
3. Étape 3 : Traiter le résultat de l'agent
4. Étape 4 : Retourner résumé à l'utilisateur

## Outputs

Ce que l'utilisateur reçoit à la fin.

Exemple : "Rapport de sécurité avec score et recommandations"

## Agents utilisés

- `security-audit-agent` : Analyse de sécurité
- `code-reviewer-agent` : Review du code

## Commandes

Exemples d'utilisation :
```
/mon-skill
/mon-skill --option valeur
```
```

---

## Exemple complet : /audit-security

```markdown
---
name: audit-security
description: Audite la sécurité de tous les fichiers du projet
context: fork
---

# Audit Security Skill

## Objectif

Analyser tous les fichiers du projet pour identifier les vulnérabilités de sécurité.

## Inputs

**Optionnel** : Chemin d'un dossier ou fichier spécifique

Par défaut : analyse tout le projet (src/)

## Workflow

### 1. Lister les fichiers

Utiliser Glob pour trouver tous les fichiers .js, .ts, .jsx, .tsx dans src/

### 2. Analyser chaque fichier

Pour chaque fichier trouvé :

Invoquer `security-audit-agent` via Task() :
```
Analyse le fichier : /path/to/file.js
```

L'agent retourne :
```json
{
  "score": 85,
  "vulnerabilities": [...],
  "summary": "..."
}
```

### 3. Agréger les résultats

Compiler tous les résultats des agents :
- Score global (moyenne pondérée)
- Total de vulnérabilités par sévérité
- Fichiers les plus critiques

### 4. Retourner rapport

Retourner à l'utilisateur :
```markdown
# Rapport d'audit de sécurité

**Score global** : 78/100

## Résumé

- Fichiers analysés : 45
- Vulnérabilités critiques : 3
- Vulnérabilités moyennes : 12
- Vulnérabilités mineures : 28

## Fichiers critiques

1. `src/auth/login.js` (score: 45) - 2 injections SQL
2. `src/api/users.js` (score: 52) - 1 XSS
3. `src/utils/db.js` (score: 60) - Credentials en clair

## Recommandations prioritaires

1. Corriger les injections SQL dans login.js
2. Sanitiser les inputs dans users.js
3. Utiliser variables d'environnement pour les credentials
```

## Outputs

Rapport markdown avec :
- Score global
- Liste des vulnérabilités par sévérité
- Fichiers critiques à corriger en priorité
- Recommandations actionnables

## Agents utilisés

- **security-audit-agent** : Analyse de sécurité par fichier

## Commandes

```bash
/audit-security              # Analyse tout src/
/audit-security src/auth/    # Analyse seulement src/auth/
```

## Options futures

- `--fix` : Proposer des corrections automatiques
- `--format json` : Export en JSON
- `--threshold 80` : Échouer si score < 80
```

---

## Invocation du skill

### Créer la commande slash

**Localisation** : `.claude/commands/audit-security.MD`

```markdown
---
name: audit-security
---

Tu es un orchestrateur de workflow de sécurité.

Charge et exécute le skill défini dans `.claude/skills/audit-security/SKILL.md`.

Inputs utilisateur : {{user_input}}

Suis exactement le workflow défini dans le skill.
```

### Utilisation

```bash
/audit-security
```

Claude :
1. Charge le skill
2. Exécute le workflow
3. Délègue aux agents via Task()
4. Retourne le rapport final

---

## Délégation aux agents

### Syntaxe Task()

Dans le skill, instruire Claude d'utiliser Task() :

```markdown
## Workflow

Pour chaque fichier trouvé :

1. Invoquer l'agent via Task() :
   ```
   Utilise Task() pour invoquer security-audit-agent avec :
   "Analyse le fichier : /path/to/file.js"
   ```

2. Attendre le résultat de l'agent

3. Stocker le résultat pour agrégation
```

Claude comprendra qu'il doit utiliser l'outil Task pour spawner l'agent.

---

## Contexte : fork vs task

### context: fork

**Usage** : Skill complexe qui orchestre plusieurs agents

**Avantages** :
- Contexte isolé
- Réduit les tokens
- Retour résumé

**Exemple** :
```yaml
context: fork
```

### context: task

**Usage** : Skill simple qui délègue à UN seul agent

**Avantages** :
- Plus simple
- Délégation directe

**Exemple** :
```yaml
context: task
```

---

## Bonnes pratiques

### Orchestration claire

Le skill **ne fait pas le travail**, il **coordonne**.

**Mauvais** :
```markdown
## Workflow

1. Lire tous les fichiers
2. Analyser le code
3. Chercher les vulnérabilités
4. Générer le rapport
```

**Bon** :
```markdown
## Workflow

1. Lister les fichiers avec Glob
2. Pour chaque fichier, déléguer à security-audit-agent via Task()
3. Agréger les résultats des agents
4. Retourner rapport structuré
```

### Résumé concis

Retourner uniquement les **informations essentielles**.

**Mauvais** :
```markdown
Retourner tous les détails de tous les fichiers analysés avec tous les logs...
```

**Bon** :
```markdown
Retourner :
- Score global
- Top 5 fichiers critiques
- 3 recommandations prioritaires
```

### Réutilisabilité

Concevoir le skill pour être **réutilisable**.

**Paramètres** :
```bash
/audit-security               # Par défaut : src/
/audit-security src/auth/     # Spécifique
/audit-security --format json # Options
```

---

## Workflow type

### 1. Préparation

```markdown
### 1. Analyser le contexte

- Lire les inputs utilisateur
- Valider les paramètres
- Déterminer le scope du travail
```

### 2. Exécution

```markdown
### 2. Déléguer aux agents

Pour chaque tâche :
- Invoquer l'agent approprié via Task()
- Attendre le résultat
- Stocker pour agrégation
```

### 3. Agrégation

```markdown
### 3. Compiler les résultats

- Agréger les outputs des agents
- Calculer métriques globales
- Identifier actions prioritaires
```

### 4. Rapport

```markdown
### 4. Retourner le résumé

Rapport structuré avec :
- Résumé exécutif
- Métriques clés
- Actions recommandées
```

---

## Exemple minimaliste

Le strict minimum pour un skill fonctionnel :

```markdown
---
name: count-files
description: Compte les fichiers du projet
context: fork
---

# Count Files Skill

## Objectif

Compter le nombre de fichiers par type dans le projet.

## Workflow

1. Utiliser Glob pour trouver tous les fichiers
2. Grouper par extension
3. Retourner le résumé

## Output

```markdown
# Résumé des fichiers

- .ts : 45 fichiers
- .js : 23 fichiers
- .md : 12 fichiers
- Autres : 8 fichiers

**Total** : 88 fichiers
```
```

---

## Anti-patterns à éviter

### Skill qui fait le travail

**Mauvais** :
```markdown
## Workflow

1. Lire le fichier avec Read
2. Analyser le code ligne par ligne
3. Chercher les patterns dangereux
4. Générer le rapport
```

Le skill **ne doit PAS** faire ce travail. Il doit déléguer à un agent.

**Bon** :
```markdown
## Workflow

1. Lister les fichiers à analyser
2. Déléguer l'analyse à security-audit-agent via Task()
3. Agréger les résultats
4. Retourner le rapport
```

### Retour trop verbeux

**Mauvais** :
```markdown
Retourner tous les logs de tous les agents avec tous les détails...
```

**Bon** :
```markdown
Retourner :
- Résumé exécutif (3-5 lignes)
- Métriques clés
- Top 3 recommandations
```

### Pas de structure claire

**Mauvais** :
```markdown
# Mon Skill

Fait des trucs avec des fichiers et retourne un résultat.
```

**Bon** :
```markdown
# Mon Skill

## Objectif
[Clair et précis]

## Workflow
1. Étape 1
2. Étape 2
3. Étape 3

## Output
[Format structuré]
```

---

## Checklist de création

Avant de finaliser votre skill, vérifiez :

- [ ] Nom unique et descriptif (kebab-case)
- [ ] Description claire en une phrase
- [ ] Context défini (fork ou task)
- [ ] Section "Objectif" claire
- [ ] Section "Workflow" avec étapes numérotées
- [ ] Délégation aux agents via Task() documentée
- [ ] Section "Output" avec format attendu
- [ ] Liste des agents utilisés
- [ ] Exemples de commandes
- [ ] Commande slash créée dans .claude/commands/

---

## Prochaines étapes

Une fois votre skill créé :

1. **Créer la commande slash** dans `.claude/commands/`
2. **Tester** : Invoquer avec `/nom-du-skill`
3. **Itérer** : Affiner selon les résultats
4. **Documenter** : Ajouter des exemples d'usage
5. **Partager** : Mettre à jour la documentation

---

## Ressources

- **Documentation officielle** : [Claude Code Skills](https://docs.claude.com/claude-code/skills)
- **Exemples** : `.claude/skills/` du workspace
- **Architecture** : `CLAUDE.MD` section "Architecture en 3 niveaux"
- **Guide agents** : `docs-public/guides/creer-un-agent.md`

---

**Dernière mise à jour** : 2026-02-08
