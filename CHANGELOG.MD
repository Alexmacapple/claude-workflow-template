# Changelog

Toutes les modifications notables de ce workspace sont documentees ici.

Format base sur [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/).

---

## [1.1.0] - 2026-02-10

### Ajoute

- **Skill /review** : Evaluation de skills, PRD et rules avec score /100, grilles de notation integrees (PRD, Skill, Rule) et actions correctives
- **Hook PostToolUse** : Linting Markdown automatique apres chaque edition de fichier .md (via check-markdown-rules.sh)
- **settings.json** : Configuration Claude Code avec hook PostToolUse (chemin dynamique via git rev-parse)

### Modifie

- **check-markdown-rules.sh** : Support mode fichier unique (argument $1, sortie compacte pour hook)
- **CLAUDE.MD** : Ajout /review dans les commandes disponibles, version 1.1.0

---

## [1.0.0] - Setup initial depuis le template

### Inclus

- Architecture Claude Code : 8 rules, 1 skill, 1 commande
- Documentation : guidelines, FAQ, glossaire, guides, HOW-TO
- Outils : check-markdown-rules.sh, setup.sh, hook pre-commit
- Templates projet : API, CLI, frontend, fullstack
- Structure workspace : active/, archive/, docs-public/, templates/
