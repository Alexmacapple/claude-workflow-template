# Mon Premier Projet - Guide Modulaire

**Guide organisé par étapes pour créer votre premier projet avec Claude**

---

## Navigation rapide

Ce guide est découpé en modules thématiques pour faciliter la navigation.

**Fichier source complet** : `MON-PREMIER-PROJET-HOW-TO.MD` (a la racine du workspace)

---

## Module 1 : Préparation

### 1.1 Objectif et prérequis
→ **Voir** : MON-PREMIER-PROJET-HOW-TO.MD (lignes 7-23)

**Contenu** :
- Objectif du guide
- Prérequis techniques
- Philosophie du workflow

---

### 1.2 Se positionner dans le workspace
→ **Voir** : MON-PREMIER-PROJET-HOW-TO.MD (lignes 25-39)

**Contenu** :
- Navigation vers ~/Claude
- Vérification de l'installation
- Commandes de base

---

## Module 2 : Initialisation

### 2.1 Créer la structure du projet
→ **Voir** : MON-PREMIER-PROJET-HOW-TO.MD (lignes 42-68)

**Contenu** :
- Option A : `/init mon-premier-projet` (recommandé)
- Option B : Création manuelle
- Structure de dossiers

**Commande rapide** :
```
/init mon-premier-projet
```

---

## Module 3 : Spécifications

### 3.1 Créer le BRIEF (cahier des charges)
→ **Voir** : MON-PREMIER-PROJET-HOW-TO.MD (lignes 71-127)

**Contenu** :
- Template BRIEF.md
- Contexte et objectifs
- Fonctionnalités MVP vs Future
- Contraintes et critères de succès
- Non-objectifs (scope)

**Fichier** : `docs/BRIEF.md`

---

### 3.2 Définir la STACK technique
→ **Voir** : MON-PREMIER-PROJET-HOW-TO.MD (lignes 128-188)

**Contenu** :
- Template STACK.md
- Frontend, Backend, DevOps
- Architecture et hébergement
- Justifications des choix

**Fichier** : `docs/STACK.md`

---

## Module 4 : Configuration

### 4.1 Créer le CLAUDE.md local du projet
→ **Voir** : MON-PREMIER-PROJET-HOW-TO.MD (lignes 191-350)

**Contenu** :
- Template CLAUDE.md
- Identité et vision du projet
- Stack (résumé)
- Contraintes spécifiques
- Organisation du code
- Conventions de nommage
- Workflow de développement
- Scripts utiles

**Fichier** : `CLAUDE.MD`

---

### 4.2 Initialiser Git
→ **Voir** : MON-PREMIER-PROJET-HOW-TO.MD (lignes 354-398)

**Contenu** :
- `git init`
- Créer .gitignore
- Premier commit
- Structure de message de commit

---

## Module 5 : Développement

### 5.1 Utiliser la mémoire hiérarchique
→ **Voir** : MON-PREMIER-PROJET-HOW-TO.MD (lignes 401-414)

**Contenu** :
- Ordre de chargement des mémoires
- Héritage et surcharge
- Template claude.local.md

**Hiérarchie** :
1. Mémoire personnelle (`~/.claude/CLAUDE.MD`)
2. Mémoire workspace (`~/Claude/CLAUDE.MD`)
3. Mémoire projet (`./CLAUDE.MD`)
4. Mémoire locale (`./claude.local.md`)

---

### 5.2 Développer avec Claude Code
→ **Voir** : MON-PREMIER-PROJET-HOW-TO.MD (lignes 415-491)

**Contenu** :
- Demander à Claude de développer une feature
- Créer une rule pour le projet
- Exemple : `validation-rules.md`
- Chargement automatique des rules

---

### 5.3 Documenter les décisions (ADR)
→ **Voir** : MON-PREMIER-PROJET-HOW-TO.MD (lignes 494-556)

**Contenu** :
- Format ADR (Architecture Decision Record)
- Template ADR
- Exemple : ADR 001 - Choix de React
- Sections : Statut, Contexte, Décision, Justification, Conséquences

**Fichier** : `docs/ADR/XXX-titre-decision.md`

---

## Module 6 : Tests et validation

### 6.1 Écrire des tests
→ **Voir** : MON-PREMIER-PROJET-HOW-TO.MD (lignes 558-594)

**Contenu** :
- Structure des tests (unit, integration)
- Lancer les tests
- Demander à Claude de créer les tests

---

## Module 7 : Déploiement

### 7.1 Préparer pour la production
→ **Voir** : MON-PREMIER-PROJET-HOW-TO.MD (lignes 597-641)

**Contenu** :
- Build et preview
- Déploiement frontend (Vercel)
- Déploiement backend (Railway)
- Variables d'environnement
- Documentation du déploiement

---

## Module 8 : Archivage

### 8.1 Finaliser et archiver
→ **Voir** : MON-PREMIER-PROJET-HOW-TO.MD (lignes 644-699)

**Contenu** :
- Finaliser la documentation
- Ajouter bilan final
- Leçons apprises
- Métriques
- Archiver proprement
- Compression (optionnel)

---

## Annexes

### A. Récapitulatif des bonnes pratiques
→ **Voir** : MON-PREMIER-PROJET-HOW-TO.MD (lignes 702-723)

**À faire** :
- Partir d'un BRIEF
- Définir la STACK
- Utiliser mémoire hiérarchique
- Documenter (ADR)
- Tester
- Commiter régulièrement
- Créer des rules
- Archiver proprement

**À éviter** :
- Coder sans spec
- Ignorer la documentation
- Pas de tests
- Tout dans claude.md global
- Commiter claude.local.md
- Laisser projets morts dans active/

---

### B. Commandes utiles
→ **Voir** : MON-PREMIER-PROJET-HOW-TO.MD (lignes 726-762)

**Navigation, Documentation, Git**

---

### C. Ressources
→ **Voir** : MON-PREMIER-PROJET-HOW-TO.MD (lignes 764-780)

**Documentation workspace et Claude Code**

---

### D. FAQ
→ **Voir** : MON-PREMIER-PROJET-HOW-TO.MD (lignes 782-809)

**Questions fréquentes** (aussi disponible dans `FAQ.MD`)

---

### E. Félicitations
→ **Voir** : MON-PREMIER-PROJET-HOW-TO.MD (lignes 812-836)

**Prochain pas : Créer votre premier projet !**

---

## Navigation alternative

### Par besoin

**Je veux créer un projet** :
→ Modules 2, 3, 4

**Je veux développer** :
→ Modules 5, 6

**Je veux déployer** :
→ Module 7

**Je veux archiver** :
→ Module 8

**J'ai une question** :
→ Annexe D ou `~/Claude/FAQ.MD`

---

### Par expérience

**Débutant** :
Lire dans l'ordre : Modules 1→2→3→4→5

**Intermédiaire** :
Aller directement aux modules nécessaires

**Avancé** :
Utiliser comme référence rapide

---

## Accès rapide

**Fichier complet** :
```bash
cat ~/Claude/MON-PREMIER-PROJET-HOW-TO.MD
cathowto  # Si alias installés
```

**Ouvrir dans éditeur** :
```bash
code ~/Claude/MON-PREMIER-PROJET-HOW-TO.MD
```

**Chercher une section** :
```bash
grep "## Étape" ~/Claude/MON-PREMIER-PROJET-HOW-TO.MD
```

---

## Prochaines étapes

1. **Lire le module 1** (Préparation)
2. **Suivre module 2** (Initialisation)
3. **Consulter les autres modules au besoin**

Ou directement :
```
/init mon-premier-projet
```

---

**Créé le** : 2026-02-08
**Version** : 1.0.0
**Guide source** : MON-PREMIER-PROJET-HOW-TO.MD

**Note** : Ce fichier est un index. Le contenu détaillé reste dans le fichier source pour éviter duplication et maintenir cohérence.
