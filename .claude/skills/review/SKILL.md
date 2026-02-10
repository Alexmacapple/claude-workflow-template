---
name: review
description: Evalue un skill, PRD ou rule contre les references du workspace
context: fork
allowed-tools: Read, Glob, Grep
argument-hint: "[fichier ou type a evaluer]"
---

# Skill : /review

## Declencheurs

- "evalue ce skill", "review du workflow", "/review"
- "evalue ce PRD", "review cette rule"

## Arguments

Le sujet de la review est passe via `$ARGUMENTS` :
- `/review .claude/skills/playbook/SKILL.md` -> evalue le skill playbook
- `/review PRD-005` -> evalue le PRD-005
- Si `$ARGUMENTS` est vide, demander a l'utilisateur le fichier ou type a evaluer

## Perimetre borne

Evaluations couvertes :
- **Skills** : SKILL.md vs GUIDELINES-CLAUDE-CODE.MD (structure, declencheurs, workflow)
- **PRD** : structure, completude, coherence, metriques mesurables
- **Rules** : conformite au format, pertinence des patterns BON/MAUVAIS

Hors perimetre : audit de code, revue de PR, evaluation de performance, revue de securite.

## Workflow

### Etape 1 : Identification du sujet

- Identifier le type (skill, PRD, rule) et le fichier a evaluer
- Si non specifie, demander a l'utilisateur

### Etape 2 : Chargement des references

Selon le type :
- **Skill** : lire `GUIDELINES-CLAUDE-CODE.MD` sections Skills + le SKILL.md cible
- **PRD** : lire un PRD de reference dans le dossier PRD du workspace + le PRD cible
- **Rule** : lire `GUIDELINES-CLAUDE-CODE.MD` section Rules + la rule cible

Note : pour les fichiers de plus de 500 lignes, demander confirmation avant d'evaluer (risque de rapport trop long).

### Etape 3 : Evaluation structuree

Utiliser la grille de notation correspondante (section "Grilles de notation" ci-dessous) pour calculer le score par critere. Produire un rapport avec le format suivant :

```markdown
## Rapport d'evaluation : {nom du sujet}

**Type** : Skill / PRD / Rule
**Date** : {date}
**Reference** : {document de reference utilise}

### Score par critere

| Critere | Score | Justification |
|---------|-------|---------------|
| {critere 1} | {X}/{max} | {justification courte} |
| {critere 2} | {X}/{max} | {justification courte} |

### Conformites
- {point conforme 1}
- {point conforme 2}

### Non-conformites
- {point non conforme 1} - Recommandation : {action}
- {point non conforme 2} - Recommandation : {action}

### Score global : {X}/100

### Actions correctives proposees
1. {action 1} (priorite haute/moyenne/basse)
2. {action 2}
```

### Etape 4 : Proposer corrections

Si l'utilisateur accepte, appliquer les corrections directement dans le fichier.

## Grilles de notation

### PRD (score /100)

| Critere | Points |
|---------|--------|
| Structure conforme au template | 20 |
| Probleme clairement enonce | 15 |
| Au moins 2 options evaluees | 15 |
| Decision justifiee | 15 |
| Plan d'implementation numerate | 15 |
| Metriques de succes mesurables | 10 |
| Changelog present | 10 |

### Skill (score /100)

| Critere | Points |
|---------|--------|
| Frontmatter complet | 15 |
| Declencheurs clairs | 15 |
| Workflow en etapes | 25 |
| Contraintes documentees | 15 |
| Checklist finale | 15 |
| Coherence avec GUIDELINES | 15 |

### Rule (score /100)

| Critere | Points |
|---------|--------|
| Format BON/MAUVAIS avec exemples | 25 |
| Pertinence des patterns | 25 |
| Portee definie (paths) | 20 |
| Concision (< 100 lignes) | 15 |
| Coherence interne | 15 |

## Exemples d'utilisation

```text
Utilisateur : /review .claude/skills/prd/SKILL.md

Claude :
> Type detecte : Skill
> Chargement reference : GUIDELINES-CLAUDE-CODE.MD
> Evaluation en cours...
>
> Score global : 82/100
> Conformites : 8 points
> Non-conformites : 3 points
> Actions correctives : 3 proposees
>
> Voulez-vous appliquer les corrections ?
```

```text
Utilisateur : /review PRD-005

Claude :
> Type detecte : PRD
> Chargement reference : PRD de reference
> Evaluation en cours...
>
> Score global : 91/100
> Structure conforme, metriques mesurables
> Non-conformite : plan d'implementation manque 1 etape
> Action corrective : ajouter etape de rollback
```

## Checklist finale

- [ ] Type de sujet identifie (skill/PRD/rule)
- [ ] Reference de comparaison chargee
- [ ] Au moins 1 conformite listee
- [ ] Chaque non-conformite a une recommandation
- [ ] Score global attribue selon la grille
- [ ] Actions correctives proposees avec priorite
