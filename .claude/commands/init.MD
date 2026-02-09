Tu es en charge d'initialiser un nouveau projet dans le workspace Claude.

## Objectif

Créer une structure de projet complète et fonctionnelle dans `~/Claude/active/` avec toute la configuration nécessaire pour démarrer proprement.

## Instructions

1. **Demander les informations du projet** :
   - Nom du projet (kebab-case)
   - Description courte
   - Type de projet (web app, API, CLI tool, library, etc.)
   - Stack technique principale (si connue)

2. **Créer la structure** :
   ```
   ~/Claude/active/{nom-projet}/
   ├── claude.md                    # Mémoire projet
   ├── claude.local.md              # Mémoire locale (vide, pour config perso)
   ├── .gitignore                   # Gitignore standard
   ├── .claude/
   │   ├── agents/                  # Agents spécifiques au projet
   │   │   └── .gitkeep
   │   └── rules/                   # Rules spécifiques au projet
   │       └── .gitkeep
   ├── docs/
   │   ├── BRIEF.md                 # Brief initial du projet
   │   ├── STACK.md                 # Stack technique
   │   └── ADR/                     # Architecture Decision Records
   │       └── .gitkeep
   ├── src/                         # Code source
   │   └── .gitkeep
   ├── tests/                       # Tests
   │   └── .gitkeep
   └── README.md                    # README du projet
   ```

3. **Créer le claude.md du projet** avec :
   - Nom et description du projet
   - Objectifs principaux
   - Stack technique
   - Contraintes spécifiques
   - Lien vers la documentation (docs/)

4. **Créer le BRIEF.md** avec un template :
   - Contexte
   - Objectifs
   - Fonctionnalités attendues
   - Contraintes
   - Critères de succès

5. **Créer le STACK.md** avec :
   - Langages
   - Frameworks
   - Outils
   - Dépendances

6. **Créer le .gitignore** adapté au type de projet

7. **Créer le README.md** avec :
   - Titre et description
   - Installation
   - Usage
   - Structure du projet
   - Contribution

8. **Confirmer la création** :
   - Afficher la structure créée
   - Indiquer le chemin du projet
   - Suggérer les prochaines étapes

## Notes

- Utiliser les conventions de nommage du workspace (kebab-case)
- S'assurer que le projet n'existe pas déjà
- Créer tous les .gitkeep pour préserver les dossiers vides
- Le claude.local.md reste vide (pour usage futur par l'utilisateur)

## Exemple d'usage

```
/init mon-api-rest
```

Cela créera un nouveau projet `mon-api-rest` dans `~/Claude/active/mon-api-rest/` avec toute la structure nécessaire.
