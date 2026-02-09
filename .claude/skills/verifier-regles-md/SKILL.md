---
name: verifier-regles-md
description: Vérifie la conformité des fichiers Markdown aux règles markdown-rules.md
context: fork
---

# Skill : Vérifier règles Markdown

Audit de conformité de tous les fichiers .MD/.md du workspace selon `markdown-rules.md`.

## Objectif

Vérifier que tous les fichiers Markdown respectent les conventions définies dans `.claude/rules/markdown-rules.md` :
- Pas d'emojis (sauf si demandé explicitement)
- Capitalisation française des titres
- Langue française
- Structure professionnelle

## Workflow

### 1. Scanner les fichiers Markdown

Utiliser `Glob` pour trouver tous les fichiers :
- `**/*.MD` (uppercase)
- `**/*.md` (lowercase)

Exclure :
- `node_modules/**`
- `.git/**`
- `dist/**`, `build/**`

### 2. Vérifications pour chaque fichier

#### A. Emojis interdits

Utiliser `Grep` pour chercher les emojis courants (checkmarks, warnings, symbols, etc.)

**Violation** : Si emoji trouvé dans le contenu (pas dans les blocs de code)

#### B. Capitalisation des titres

Utiliser `Grep` pour chercher les titres de niveau 2+ :
```regex
^## [A-Z][a-zéèêëàâäôöùûü]+ [A-Z]
```

**Violation** : Titre avec plusieurs mots en majuscule (style anglais)

**Exceptions à vérifier** :
- Noms propres : Claude Code, GitHub, PostgreSQL, React, Vue.js, API REST, etc.
- Acronymes : API, REST, CRUD, HTTP, JSON, YAML, etc.

#### C. Structure du document

Vérifier avec `Read` :
- Un seul H1 (`#`) par fichier
- Hiérarchie correcte (pas de saut de H2 à H4)
- Pas de titres vides

#### D. Blocs de code

Vérifier que les blocs de code ont un langage spécifié :
```regex
^```$
```

**Violation** : ` ``` ` sans langage (devrait être ` ```bash `, ` ```javascript `, etc.)

### 3. Générer le rapport

Créer un rapport structuré :

```
# Rapport de conformité Markdown - [DATE]

## Statistiques globales

- Fichiers analysés : X
- Fichiers conformes : Y (Z%)
- Fichiers non conformes : N

## Détail des violations

### [nom-fichier.MD]

- [EMOJI] Ligne X : emoji checkmark détecté
- [CAPS] Ligne Y : "## Vue d'Ensemble" → devrait être "## Vue d'ensemble"
- [CODE] Ligne Z : bloc de code sans langage

### [autre-fichier.md]

- [EMOJI] Ligne A : emoji target détecté

## Fichiers conformes (100%)

- fichier1.md
- fichier2.MD
- ...

## Recommandations

- Corriger les X violations d'emojis
- Corriger les Y violations de capitalisation
- ...
```

### 4. Proposer corrections

Pour chaque violation, proposer :
- Le fichier concerné
- La ligne exacte
- La correction à appliquer

Demander à l'utilisateur s'il souhaite :
- Voir le rapport complet
- Corriger automatiquement (avec confirmation)
- Corriger manuellement (avec guidance)

## Outils utilisés

- **Glob** : Lister tous les fichiers .MD/.md
- **Grep** : Chercher emojis, patterns de capitalisation, blocs de code
- **Read** : Analyser structure du document (H1 unique, hiérarchie)

## Exemple d'utilisation

```
Utilisateur : /verifier-regles-md

Claude :
> Scan des fichiers Markdown...
> 29 fichiers trouvés
>
> Analyse en cours...
> - test-rules-conformite.md ✓
> - CLAUDE.MD ✓
> - EVALUATION-CONFORMITE.MD ✗ (3 violations)
>
> Rapport complet généré.
>
> Voulez-vous voir le rapport détaillé ? (oui/non)
```

## Notes

- Ce skill NE corrige PAS automatiquement sans confirmation
- Il génère un rapport que l'utilisateur peut consulter
- Il peut proposer des corrections fichier par fichier
- Les emojis dans les blocs de code (exemples) sont autorisés

## Maintenance

Mettre à jour ce skill si `markdown-rules.md` évolue avec de nouvelles règles.
