# Active Projects

Ce dossier contient tous les **projets en cours de developpement**.

## Organisation

Chaque projet a son propre dossier avec une structure standardisee :

```
mon-projet/
├── claude.md                    # Memoire projet (surcharge workspace)
├── claude.local.md              # Memoire locale (gitignored)
├── .claude/                     # Config Claude Code locale au projet
├── docs/                        # Documentation
├── src/                         # Code source
├── tests/                       # Tests
└── README.md                    # README du projet
```

## Creer un nouveau projet

Utilisez la commande `/init` pour creer automatiquement la structure :

```bash
/init nom-du-projet
```

## Conventions

- **Nommage** : kebab-case (ex: `mon-super-projet`)
- **Un dossier = un projet**
- **Chaque projet peut avoir sa propre config Claude Code**
- **Herite des regles globales** (definies dans `.claude/`)

## Archivage

Quand un projet est termine, le deplacer vers `archive/` :

```bash
mv active/mon-projet archive/
```

## Bonnes pratiques

1. **Toujours partir d'un BRIEF** (`docs/BRIEF.md`)
2. **Definir la STACK** avant de coder (`docs/STACK.md`)
3. **Documenter les decisions** dans `docs/ADR/`
4. **Garder le claude.md a jour** avec les evolutions du projet
5. **Ne pas commiter claude.local.md** (contient configs perso)
