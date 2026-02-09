# Guide : créer un agent Claude Code

**Niveau** : Intermédiaire
**Durée** : 15-20 minutes
**Prérequis** : Comprendre l'architecture en 3 niveaux

---

## Qu'est-ce qu'un agent ?

Un **agent** est un spécialiste autonome avec :
- **Contexte isolé** : Sa propre fenêtre de contexte
- **Outils restreints** : Seulement les outils nécessaires
- **Une responsabilité** : Fait une chose et la fait bien
- **Invoqué par un skill** : Via `Task()`, jamais directement

**Métaphore** : Un agent = un expert consultant qu'on fait venir pour une mission précise.

---

## Quand créer un agent ?

Créer un agent quand :

- Vous avez besoin d'**exécuter** une tâche complexe
- La tâche nécessite des **outils** (Read, Write, Bash, etc.)
- Vous voulez **isoler le contexte** pour éviter l'explosion
- La tâche est **réutilisable** dans plusieurs skills

**Exemples** :
- Analyser la sécurité d'un fichier
- Lancer les tests et analyser les résultats
- Générer de la documentation
- Refactoriser du code

---

## Structure d'un agent

### Localisation

```
.claude/agents/mon-agent.md
```

### Frontmatter (obligatoire)

```yaml
---
name: mon-agent                    # Nom unique (kebab-case)
description: Description courte    # Une phrase claire
tools: [Read, Write, Bash]         # Outils autorisés
---
```

### Sections recommandées

```markdown
# Mon Agent

## Rôle

Ce que fait cet agent (1-2 phrases).

## Inputs attendus

Ce qu'il reçoit du skill qui l'invoque.

Exemple : "Chemin du fichier à analyser"

## Outputs produits

Ce qu'il retourne au skill.

Exemple : "Rapport de sécurité avec score et recommandations"

## Process

1. Étape 1 : Lire le fichier
2. Étape 2 : Analyser le contenu
3. Étape 3 : Générer le rapport
4. Étape 4 : Retourner résumé au skill

## Contraintes

- Temps d'exécution cible : < 30 secondes
- Ne modifie jamais les fichiers (Read-only)
- Retour structuré en JSON
```

---

## Exemple complet : security-audit-agent

```markdown
---
name: security-audit-agent
description: Audite la sécurité d'un fichier de code
tools: [Read, Grep]
---

# Security Audit Agent

## Rôle

Analyse un fichier de code pour identifier les vulnérabilités de sécurité courantes.

## Inputs attendus

**Prompt du skill** :
```
Analyse le fichier : /path/to/file.js
```

## Outputs produits

**Retour au skill** :
```json
{
  "score": 85,
  "vulnerabilities": [
    {
      "type": "SQL_INJECTION",
      "severity": "HIGH",
      "line": 42,
      "recommendation": "Utiliser des requêtes préparées"
    }
  ],
  "summary": "1 vulnérabilité critique trouvée"
}
```

## Process

1. **Lire le fichier** via Read tool
2. **Rechercher patterns dangereux** :
   - Injections SQL
   - XSS
   - Credentials en clair
   - eval() ou exec()
3. **Calculer score** (0-100)
4. **Générer recommandations**
5. **Retourner rapport structuré**

## Contraintes

- Read-only (ne modifie jamais le code)
- Temps d'exécution < 30 secondes
- Retour JSON structuré
- Gère les erreurs (fichier inexistant, etc.)

## Checks de sécurité

### SQL Injection
```javascript
// MAUVAIS
db.query("SELECT * FROM users WHERE id = " + userId);

// BON
db.query("SELECT * FROM users WHERE id = ?", [userId]);
```

### XSS
```javascript
// MAUVAIS
element.innerHTML = userInput;

// BON
element.textContent = userInput;
```

### Credentials
```javascript
// MAUVAIS
const apiKey = "sk-12345678";

// BON
const apiKey = process.env.API_KEY;
```
```

---

## Invocation depuis un skill

### Dans le skill

```markdown
---
name: audit-security
description: Audite la sécurité du projet
context: fork
---

# Audit Security Skill

## Workflow

1. Lister tous les fichiers .js et .ts
2. Pour chaque fichier, déléguer l'audit à l'agent
3. Agréger les résultats
4. Retourner rapport global

## Délégation à l'agent

Utiliser `Task()` pour invoquer l'agent :

Prompt :
```
Pour chaque fichier trouvé, utilise Task() pour invoquer security-audit-agent avec le prompt :
"Analyse le fichier : /path/to/file.js"

Agrège tous les résultats et retourne un rapport global.
```
```

---

## Outils disponibles

### Outils de lecture

- `Read` : Lire des fichiers
- `Glob` : Trouver des fichiers par pattern
- `Grep` : Chercher dans les fichiers

### Outils d'écriture

- `Write` : Écrire des fichiers
- `Edit` : Modifier des fichiers existants

### Outils d'exécution

- `Bash` : Exécuter des commandes shell

### Outils web

- `WebFetch` : Récupérer du contenu web
- `WebSearch` : Rechercher sur le web

**Conseil** : Restreindre au minimum les outils nécessaires pour la tâche.

---

## Bonnes pratiques

### Spécialisation

- **Un agent = une responsabilité**
- Préférer plusieurs agents spécialisés qu'un agent généraliste

**Mauvais** :
```yaml
name: do-everything-agent
tools: [Read, Write, Bash, WebFetch, Grep, Glob, Edit]
```

**Bon** :
```yaml
name: test-runner-agent
tools: [Bash, Read]  # Seulement ce dont il a besoin
```

### Outils restreints

Ne donner que les outils **strictement nécessaires**.

**Exemple** :
- Analyse de code → `[Read, Grep]`
- Génération de docs → `[Read, Write]`
- Lancement de tests → `[Bash, Read]`

### Retour structuré

Toujours retourner un résultat **structuré** au skill.

**Mauvais** :
```
"J'ai trouvé quelques problèmes dans le fichier, notamment des injections SQL."
```

**Bon** :
```json
{
  "filesAnalyzed": 5,
  "issuesFound": 3,
  "criticalIssues": 1,
  "summary": "1 injection SQL critique trouvée dans auth.js:42"
}
```

### Gestion des erreurs

Toujours gérer les cas d'erreur.

```markdown
## Gestion des erreurs

- **Fichier inexistant** : Retourner `{ error: "File not found" }`
- **Timeout** : Abandonner après 30 secondes
- **Permission denied** : Retourner erreur explicite
```

### Documentation claire

- **Rôle** : Qu'est-ce que fait l'agent ?
- **Inputs** : Qu'attend-il comme prompt ?
- **Outputs** : Que retourne-t-il ?
- **Process** : Comment procède-t-il ?

---

## Anti-patterns à éviter

### Agent qui spawn d'autres agents

**Interdit** : Un agent ne peut PAS invoquer d'autres agents.

**Mauvais** :
```markdown
## Process
1. Lancer test-runner-agent
2. Lancer code-reviewer-agent
```

**Bon** :
Le skill orchestre, les agents exécutent.

### Agent trop généraliste

**Mauvais** :
```yaml
name: developer-agent
description: Fait tout le développement
tools: [Read, Write, Bash, Edit, Glob, Grep, WebFetch]
```

**Bon** :
```yaml
name: unit-test-generator-agent
description: Génère les tests unitaires pour un fichier
tools: [Read, Write]
```

### Retour non structuré

**Mauvais** :
```
"J'ai analysé les tests et tout semble correct."
```

**Bon** :
```json
{
  "totalTests": 45,
  "passed": 43,
  "failed": 2,
  "coverage": 87,
  "failedTests": ["auth.test.ts:42", "user.test.ts:18"]
}
```

---

## Checklist de création

Avant de finaliser votre agent, vérifiez :

- [ ] Nom unique et descriptif (kebab-case)
- [ ] Description claire en une phrase
- [ ] Outils restreints au minimum nécessaire
- [ ] Section "Rôle" expliquant clairement la fonction
- [ ] Section "Inputs attendus" avec exemples
- [ ] Section "Outputs produits" avec format structuré
- [ ] Section "Process" détaillant les étapes
- [ ] Gestion des erreurs documentée
- [ ] Exemples de bon/mauvais usage (si applicable)

---

## Exemple minimaliste

Le strict minimum pour un agent fonctionnel :

```markdown
---
name: file-counter-agent
description: Compte les lignes de code d'un fichier
tools: [Read]
---

# File Counter Agent

## Rôle

Compte le nombre de lignes de code dans un fichier donné.

## Inputs attendus

Chemin du fichier à analyser.

## Outputs produits

```json
{
  "file": "/path/to/file.js",
  "totalLines": 156,
  "codeLines": 120,
  "commentLines": 25,
  "blankLines": 11
}
```

## Process

1. Lire le fichier avec Read
2. Compter les lignes
3. Retourner résultat structuré
```

---

## Prochaines étapes

Une fois votre agent créé :

1. **Tester** : Créer un skill qui l'invoque
2. **Documenter** : Ajouter des exemples d'usage
3. **Itérer** : Améliorer selon les retours
4. **Partager** : Ajouter dans la documentation du projet

---

## Ressources

- **Documentation officielle** : [Claude Code Agents](https://docs.claude.com/claude-code/agents)
- **Exemples** : `.claude/agents/` du workspace
- **Architecture** : `CLAUDE.MD` section "Architecture en 3 niveaux"

---

**Dernière mise à jour** : 2026-02-08
