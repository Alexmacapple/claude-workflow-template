# Presentations

Slides, talks et presentations publiques

---

## Objectif

Archiver et partager vos presentations :
- Conferences
- Meetups
- Talks internes
- Webinaires
- Workshops

---

## Organisation

```
presentations/
├── 2026-02-TALK-TITRE.MD          # Slides en Markdown
├── 2026-02-TALK-TITRE-NOTES.MD    # Notes de presentation
└── assets/
    ├── images/
    └── demos/
```

---

## Format markdown pour slides

Plusieurs outils permettent de creer des slides en Markdown :

### Marp
```markdown
---
marp: true
theme: default
---

# Titre de la Presentation

Votre Nom
Date

---

## Slide 2 : Agenda

- Point 1
- Point 2
- Point 3

---

## Slide 3 : Concept Principal

Explication avec exemple de code :

```javascript
const exemple = () => {
  // Code
}
```

---

## Merci !

Questions ?

Contact : email@example.com
```

### Reveal.js
Structure similaire avec options avancees.

### Slidev
Pour presentations techniques avec demos live.

---

## Template de Presentation

```markdown
---
title: Titre de la Presentation
event: Nom de l'evenement
date: 2026-02-08
duration: 30 min
audience: Developpeurs
level: Intermediaire
---

# Titre de la Presentation

**Par** : Alexandra
**Event** : Nom du Meetup/Conference
**Date** : 8 Fevrier 2026

---

## Qui suis-je ?

- Breve bio
- Experience pertinente
- Contact

---

## Agenda

1. Introduction (5 min)
2. Probleme (10 min)
3. Solution (10 min)
4. Demo (15 min)
5. Q&A (10 min)

---

## Le problème

Description du probleme avec :
- Contexte
- Impacts
- Pourquoi c'est important

---

## La solution

Votre approche :
- Architecture
- Choix techniques
- Implementation

---

## Démo live

[Capture d'ecran ou lien vers demo]

Code principal :

```javascript
// Demo code
```

---

## Resultats

Metriques et impacts :
- Metrique 1
- Metrique 2
- Metrique 3

---

## Leçons apprises

Ce qu'on retient :
- Lesson 1
- Lesson 2

---

## Prochaines étapes

Comment aller plus loin

---

## Merci !

Questions ?

**Contact** :
- Email : email@example.com
- GitHub : @username
- Twitter : @username

**Ressources** :
- [Slides](lien)
- [Demo](lien)
- [Code](lien)

---
```

---

## Structure d'une Bonne Presentation

### Introduction (10%)
- Qui vous etes
- De quoi on va parler
- Pourquoi c'est interessant

### Corps (70%)
- Probleme
- Solution
- Demo / Exemples
- Resultats

### Conclusion (20%)
- Recap des points cles
- Call to action
- Q&A

---

## Conseils pour Slides Efficaces

### Design
- Peu de texte par slide
- Grandes polices (24pt minimum)
- Contraste eleve
- Images de qualite

### Contenu
- 1 idee par slide
- Bullets courts
- Code lisible et annote
- Exemples concrets

### Timing
- 1-2 minutes par slide
- Prevoir du temps pour questions
- Laisser respirer

---

## Notes de Presentation

Creer un fichier de notes separe :

```markdown
# Notes : Titre de la Presentation

## Slide 1 : Intro
**Dire** : "Bonjour, je suis..."
**Duree** : 1 min
**Timing** : 0-1 min

## Slide 2 : Probleme
**Points cles** :
- Insister sur l'impact
- Donner exemple concret
**Anecdote** : Raconter histoire X
**Duree** : 3 min
**Timing** : 1-4 min

## Slide 3 : Solution
**Demo** : Montrer code live
**Attention** : Ne pas se perdre dans details
**Duree** : 5 min
**Timing** : 4-9 min

---

**Timing total** : 30 min + 10 min Q&A
```

---

## Checklist pré-présentation

### Preparation
- [ ] Slides finalises
- [ ] Demo testee
- [ ] Notes preparees
- [ ] Timing respecte

### Technique
- [ ] Materiel teste (laptop, adaptateurs)
- [ ] Backup des slides (USB, cloud)
- [ ] Demo fonctionnelle offline
- [ ] Internet stable (si necessaire)

### Logistique
- [ ] Lieu et horaire confirmes
- [ ] Organisateurs contactes
- [ ] Public target connu
- [ ] Niveau d'expertise ajuste

---

## Apres la Presentation

### Publication
- [ ] Slides publies (SlideShare, GitHub)
- [ ] Video uploadee (si enregistree)
- [ ] Code source partage
- [ ] Article recap (optionnel)

### Partage
- [ ] Twitter / LinkedIn
- [ ] Newsletter
- [ ] Communaute concernee

### Feedback
- [ ] Recueillir retours
- [ ] Ameliorer pour prochaine fois
- [ ] Repondre aux questions

---

## Outils

### Creation de Slides
- **Marp** : Markdown to slides
- **Reveal.js** : Slides HTML
- **Slidev** : Slides pour devs
- **Google Slides** : Classique

### Presentation
- **Present** : Mode presentateur
- **OBS** : Enregistrement
- **Zoom** : Webinaires

### Partage
- **SlideShare** : Hebergement slides
- **Speaker Deck** : Alternative
- **GitHub** : Versioning
- **YouTube** : Videos

---

## Formats de Presentations

### Lightning Talk (5-10 min)
- 1 idee principale
- Tres concis
- Impact rapide

### Talk Standard (20-30 min)
- Introduction + Developpement + Conclusion
- Demo possible
- Q&A

### Workshop (1-3h)
- Partie theorique
- Exercices pratiques
- Suivi personnalise

### Keynote (45-60 min)
- Vue d'ensemble
- Vision strategique
- Inspirationnel

---

## Archive

Garder trace de vos presentations :

```markdown
## Presentations 2026

| Date | Titre | Event | Audience | Slides | Video |
|------|-------|-------|----------|--------|-------|
| 2026-02 | Mon Talk | Meetup | 50 | [Lien](url) | [Lien](url) |
```

---

Cree le : 2026-02-08
