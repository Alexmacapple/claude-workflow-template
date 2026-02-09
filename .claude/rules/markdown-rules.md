---
paths: ["**/*.MD", "**/*.md"]
---

# Règles Markdown

Conventions pour tous les fichiers Markdown du workspace

---

## Langue : français

Tous les fichiers Markdown doivent être rédigés en français.

**Exception** : Code source et noms de variables (en anglais selon conventions)

BON :
```markdown
# Mon projet

## Fonctionnalités

Cette application permet de...
```

MAUVAIS :
```markdown
# My project

## Features

This application allows to...
```

---

## Pas d'emojis

Les fichiers .MD ne doivent PAS contenir d'emojis, sauf si explicitement demandé par l'utilisateur.

BON :
```markdown
## Vue d'ensemble
## Objectifs
## Ressources
```

MAUVAIS :
```markdown
## Vue d'ensemble (avec emoji)
## Objectifs (avec emoji)
## Ressources (avec emoji)
```

---

## Capitalisation des titres : style français

En français, seul le **premier mot** du titre prend une majuscule initiale (plus les noms propres).

**Règle** : Capitalisation à la française, **pas** à l'anglaise (Title Case)

BON :
```markdown
## Vue d'ensemble
## Bonnes pratiques
## Étape 1 : installation du projet
## Contraintes spécifiques
## Architecture en 3 niveaux
## Mémoire hiérarchique
## Format de commit
```

MAUVAIS :
```
Vue d'Ensemble              (capitalisation anglaise - INCORRECT)
Bonnes Pratiques            (capitalisation anglaise - INCORRECT)
Étape 1 : Installation Du Projet  (chaque mot en majuscule - INCORRECT)
Contraintes Spécifiques     (capitalisation anglaise - INCORRECT)
Architecture en 3 niveaux   (capitalisation anglaise - INCORRECT)
```

**Noms propres préservés** :

Les noms de produits, technologies, personnes et acronymes conservent leur capitalisation :

```markdown
## Installation de Claude Code     (Claude Code = nom propre - CORRECT)
## Configuration de PostgreSQL      (PostgreSQL = nom propre - CORRECT)
## Utilisation de l'API REST        (API REST = acronyme - CORRECT)
## Intégration avec React            (React = technologie - CORRECT)
## Workflow de GitHub Actions        (GitHub = nom propre - CORRECT)
```

**Exemples de noms propres à préserver** :
- Produits : Claude Code, GitHub, GitLab, VS Code
- Technologies : React, Vue.js, Node.js, PostgreSQL, MongoDB, Redis, Docker
- Langages : JavaScript, TypeScript, Python, Java
- Frameworks : Express, Next.js, TailwindCSS, Prisma
- Acronymes : API, REST, CRUD, HTTP, JSON, YAML, HTML, CSS, SQL
- Formats : PDF, PNG, JPEG, SVG
- Standards : ADR, PRD, BRIEF, STACK, MVP, CI/CD, WCAG

**Application** : Cette règle s'applique aux titres de niveau 2 (`##`) et inférieur.

---

## Style professionnel

### Titres

- **Un seul H1** (`#`) par fichier
- **Hiérarchie claire** : H1 → H2 → H3 (pas de saut de niveau)
- **Titres clairs** et descriptifs

BON :
```markdown
# Titre principal

## Section principale

### Sous-section

## Autre section
```

MAUVAIS :
```markdown
# Titre
# Autre titre (deux H1)

## Section

#### Sous-section (saut de H2 à H4)
```

### Listes

- Cohérentes : toujours `-` ou `*` (ne pas mélanger)
- Indentation : 2 ou 4 espaces (consistant)

BON :
```markdown
- Item 1
- Item 2
  - Sous-item 2.1
  - Sous-item 2.2
```

MAUVAIS :
```markdown
- Item 1
* Item 2 (mélange - et *)
    - Sous-item (indentation incohérente)
```

---

## Structure recommandée

Pour les README et documentation principale :

```markdown
# Titre du projet

Brève description (1-2 phrases)

---

## Vue d'ensemble

Description détaillée

## Installation

Instructions d'installation

## Usage

Exemples d'utilisation

## Documentation

Liens vers documentation complète

---

Date de création : YYYY-MM-DD
Dernière mise à jour : YYYY-MM-DD
```

---

## Formatage

### Code

- Utiliser les blocs de code avec langage spécifié

BON :
````markdown
```bash
npm install
```

```javascript
const foo = 'bar';
```
````

MAUVAIS :
````markdown
```
npm install
```
````

### Liens

- Liens descriptifs (pas "cliquez ici")

BON :
```markdown
Consultez la [documentation officielle](https://example.com)
```

MAUVAIS :
```markdown
[Cliquez ici](https://example.com)
```

### Emphase

- **Gras** pour importance forte
- *Italique* pour emphase légère
- `code` pour termes techniques, commandes, fichiers

BON :
```markdown
Le fichier `CLAUDE.MD` contient la **mémoire globale** du workspace.
```

---

## Cas spéciaux

### Fichiers PRD

Les PRD doivent suivre le template défini dans `prd-meta-workflow/README.MD`

### Fichiers techniques (ADR, SPECS)

Peuvent contenir du contenu en anglais si c'est la norme du projet

---

## Application

Ces règles s'appliquent automatiquement à tous les fichiers :
- `**/*.MD` (extension uppercase)
- `**/*.md` (extension lowercase)

Quand Claude crée ou modifie un fichier Markdown, il doit suivre ces conventions.
