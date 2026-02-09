# ADR {{NUMBER}} : {{TITRE}}

**Date** : {{DATE}}
**Statut** : {{STATUT}}  # Proposé | Accepté | Rejeté | Déprécié | Remplacé par ADR-XXX
**Décideurs** : {{DECIDEURS}}
**Tags** : {{TAGS}}  # Ex: architecture, frontend, database, security

---

## Contexte

### Problème

Décrivez le problème ou le besoin qui nécessite une décision.

**Exemple** :
> Nous devons choisir une base de données pour notre application. Actuellement, nous n'avons aucune solution de persistance des données.

### Forces en présence

Listez les facteurs qui influencent la décision :

- **Contrainte 1** : Ex: Budget limité à {{BUDGET}}€/mois
- **Contrainte 2** : Ex: Équipe expérimentée en SQL, pas en NoSQL
- **Besoin 1** : Ex: Relations complexes entre entités
- **Besoin 2** : Ex: Scaling horizontal futur

---

## Décision

Énoncez clairement la décision prise.

**Exemple** :
> Nous utiliserons PostgreSQL comme base de données principale.

---

## Options considérées

### Option 1 : {{OPTION_1}}

**Description** : Brève description de l'option.

**Avantages** :
- Avantage 1
- Avantage 2

**Inconvénients** :
- Inconvénient 1
- Inconvénient 2

**Coût estimé** : {{COST_1}}

---

### Option 2 : {{OPTION_2}}

**Description** : Brève description de l'option.

**Avantages** :
- Avantage 1
- Avantage 2

**Inconvénients** :
- Inconvénient 1
- Inconvénient 2

**Coût estimé** : {{COST_2}}

---

### Option 3 : {{OPTION_3}}

(Répéter pour chaque option)

---

## Justification

Expliquez **pourquoi** cette décision a été prise plutôt que les alternatives.

**Exemple** :
> PostgreSQL a été choisi car :
> 1. L'équipe a une forte expertise SQL
> 2. Les relations entre entités sont complexes (mieux adapté au relationnel)
> 3. Coût d'hébergement compétitif (Railway : 5€/mois)
> 4. Écosystème mature et stable
> 5. Support des transactions ACID nécessaire pour notre domaine

---

## Conséquences

### Positives

- Conséquence positive 1
- Conséquence positive 2

**Exemple** :
- Garanties ACID pour les transactions financières
- ORM Prisma avec type safety
- Scaling vertical facile

### Négatives

- Conséquence négative 1
- Conséquence négative 2

**Exemple** :
- Scaling horizontal plus complexe que NoSQL
- Coûts augmentent avec le volume de données

### Neutres

- Point neutre 1 (ni bon ni mauvais, juste à noter)

**Exemple** :
- Nécessite apprentissage de Prisma pour les nouveaux

---

## Risques et mitigation

| Risque | Probabilité | Impact | Mitigation |
|--------|-------------|--------|------------|
| {{RISK_1}} | Faible/Moyen/Élevé | Faible/Moyen/Élevé | {{MITIGATION_1}} |
| {{RISK_2}} | Faible/Moyen/Élevé | Faible/Moyen/Élevé | {{MITIGATION_2}} |

**Exemple** :
| Risque | Probabilité | Impact | Mitigation |
|--------|-------------|--------|------------|
| Dépassement budget hébergement | Moyen | Moyen | Monitoring des coûts, alertes à 80% |
| Problèmes de performance | Faible | Élevé | Indexation, query optimization, monitoring |

---

## Implémentation

### Actions requises

1. Action 1
2. Action 2
3. Action 3

**Exemple** :
1. Créer base de données PostgreSQL sur Railway
2. Installer Prisma et configurer le schema
3. Migrer les données de test
4. Mettre à jour la documentation
5. Former l'équipe sur Prisma

### Timeline estimée

- **Phase 1** : {{PHASE_1}} ({{DURATION_1}})
- **Phase 2** : {{PHASE_2}} ({{DURATION_2}})
- **Complétion** : {{COMPLETION_DATE}}

---

## Critères de succès

Comment savoir si cette décision était la bonne ?

- Critère 1
- Critère 2
- Critère 3

**Exemple** :
- Temps de réponse < 100ms (P95)
- 0 perte de données
- Coûts < 50€/mois pour 10k utilisateurs
- Déploiement réussi avant {{DATE}}

---

## Réévaluation

Cette décision devra être réévaluée si :

- Condition 1
- Condition 2

**Exemple** :
- Le volume de données dépasse 1 To
- Les coûts dépassent 100€/mois
- L'équipe change significativement
- De nouvelles technologies matures émergent

**Date de réévaluation** : {{REVIEW_DATE}}

---

## Références

### Documentation

- [Lien 1](URL)
- [Lien 2](URL)

### Discussions

- Issue GitHub : #{{ISSUE_NUMBER}}
- PR : #{{PR_NUMBER}}
- Slack discussion : {{SLACK_LINK}}

### ADR liés

- ADR-{{RELATED_1}} : {{TITRE_RELATED_1}}
- ADR-{{RELATED_2}} : {{TITRE_RELATED_2}}

---

## Historique des modifications

| Date | Auteur | Changement |
|------|--------|------------|
| {{DATE_1}} | {{AUTHOR_1}} | Création de l'ADR |
| {{DATE_2}} | {{AUTHOR_2}} | Statut changé de Proposé à Accepté |

---

**Notes** :
- Supprimer les sections non pertinentes
- Adapter selon le contexte du projet
- Garder concis et factuel
