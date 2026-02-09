# Documentation Publique

Documentation technique publique, articles et tutoriels versionnes et partageables

---

## Objectif

Ce repertoire contient toute la documentation destinee a etre partagee publiquement :
- Articles techniques
- Tutoriels et guides
- Presentations
- Portfolio de projets

**Difference avec docs-perso/** :
- **docs-perso/** : Notes privees, brouillons, journal personnel (optionnellement gitignored)
- **docs-public/** : Contenu finalise, versionne Git, destiné au partage

---

## Structure

```
docs-public/
├── README.MD                       # Ce fichier - Index des publications
├── articles/                       # Articles techniques
│   ├── 2026/
│   │   └── 2026-02-MON-ARTICLE.MD
│   └── README.MD
├── tutoriels/                      # Tutoriels pas-a-pas
│   └── README.MD
├── guides/                         # Guides techniques complets
│   └── README.MD
├── presentations/                  # Slides et presentations
│   └── README.MD
└── portfolio/                      # Projets a presenter
    └── README.MD
```

---

## Workflow de Publication

### 1. Ideation (docs-perso/)
```
Idee → docs-perso/notes/IDEES.MD
```

### 2. Draft (docs-perso/)
```
Redaction brouillon → docs-perso/notes/DRAFT-mon-article.MD
```

### 3. Revision
```
Revision et finalisation du contenu
```

### 4. Publication (docs-public/)
```
Version finale → docs-public/articles/2026/2026-02-MON-ARTICLE.MD
```

### 5. Versioning
```bash
git add docs-public/articles/2026/2026-02-MON-ARTICLE.MD
git commit -m "Publication: Mon article"
git push
```

---

## Sections

### articles/
Articles techniques, retours d'experience, analyses

**Format suggere** :
- Date dans le nom : `2026-02-TITRE.MD`
- Organises par annee
- Longueur : 1000-3000 mots

### tutoriels/
Tutoriels pas-a-pas, how-to pratiques

**Format suggere** :
- Titre descriptif : `TUTO-REACT-HOOKS.MD`
- Etapes numerotees claires
- Exemples de code complets
- Prerequisites et resultats attendus

### guides/
Guides techniques complets et detailles

**Format suggere** :
- Documentation exhaustive d'un sujet
- Reference a consulter regulierement
- Bien structure avec sommaire
- Maintenu a jour

### presentations/
Slides, talks, presentations publiques

**Format suggere** :
- Markdown exportable en slides
- Liens vers videos si enregistrees
- Notes de presentation

### portfolio/
Projets a presenter (CV, GitHub, etc.)

**Format suggere** :
- Description du projet
- Technologies utilisees
- Problemes resolus
- Resultats et metriques
- Liens vers repos/demo

---

## Conventions

### Nommage

**Articles** :
```
2026-02-TITRE-EN-KEBAB-CASE.MD
```

**Tutoriels** :
```
TUTO-SUJET-SPECIFIQUE.MD
```

**Guides** :
```
GUIDE-TECHNOLOGIE-OU-CONCEPT.MD
```

### Format markdown

**Frontmatter** (optionnel mais recommande) :
```markdown
---
title: Titre de l'article
date: 2026-02-08
tags: [react, javascript, hooks]
description: Description courte
---

# Titre

Contenu...
```

### Qualite

Avant publication, verifier :
- Orthographe et grammaire
- Code teste et fonctionnel
- Liens valides
- Licenses et attributions
- Coherence du format

---

## Diffusion

Une fois publie dans docs-public/, le contenu peut etre :

### Blog personnel
Copier vers votre blog (Jekyll, Hugo, etc.)

### Medium / Dev.to
Publier directement ou adapter

### GitHub
Partager via GitHub (README, Wiki, Discussions)

### Newsletter
Envoyer a votre mailing list

### Reseaux sociaux
Partager avec extraits

---

## Index des Publications

### Articles recents
<!-- Mettre a jour manuellement ou via script -->

- **2026-02-08** : [Exemple d'article](articles/2026/2026-02-EXEMPLE.MD)

### Tutoriels populaires
<!-- Mettre a jour manuellement -->

- [Tutoriel React Hooks](tutoriels/TUTO-REACT-HOOKS.MD)

### Guides de reference
<!-- Mettre a jour manuellement -->

- [Guide Git Workflow](guides/GUIDE-GIT-WORKFLOW.MD)

---

## Maintenance

### Revision reguliere
- Mettre a jour les guides avec nouvelles versions
- Corriger les erreurs signalees
- Ajouter nouvelles informations

### Archivage
Si un contenu devient obsolete :
- Ajouter un avertissement en haut
- Deplacer vers `archive/` si necessaire
- Garder pour historique

---

## Metriques (Optionnel)

Suivre les performances :

```markdown
## Metriques

| Article | Vues | Likes | Commentaires |
|---------|------|-------|--------------|
| Article 1 | 1200 | 45 | 12 |
| Article 2 | 800 | 32 | 8 |
```

---

## Licence

Specifier la licence de votre contenu :
- **CC BY 4.0** : Attribution requise
- **MIT** : Libre utilisation
- **Tous droits reserves**

Ajouter un fichier `LICENSE.MD` a la racine si necessaire.

---

## Liens

### Documentation systeme
- [CLAUDE.MD](../CLAUDE.MD) - Memoire globale
- [README.MD](../README.MD) - Vue d'ensemble workspace

### Documentation privee
- [docs-perso/](../docs-perso/) - Notes et brouillons

---

Cree le : 2026-02-08
Version : 1.0.0
Proprietaire : Alexandra
