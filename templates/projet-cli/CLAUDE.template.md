# Mémoire projet - {{PROJECT_NAME}}

**Projet** : {{PROJECT_NAME}}
**Type** : CLI (Command-Line Interface)
**Workspace** : ~/Claude/active/{{PROJECT_NAME}}
**Créé le** : {{DATE}}

---

## Identité du projet

### Vision

{{DESCRIPTION}}

### Objectif

Créer un CLI intuitif, rapide et fiable.

**Référence** : `docs/BRIEF.md`

---

## Stack technique

**Résumé** :
- Runtime : Node.js + TypeScript
- Framework : Commander.js
- UX : Inquirer + Chalk + Ora
- Distribution : npm

**Référence complète** : `docs/STACK.md`

---

## Contraintes

### Performance

- Startup time < 1s
- Commandes rapides (< 5s sauf ops longues)

### UX

- Messages clairs et colorés
- Spinners pour ops longues
- Progress bars
- Aide contextuelle complète

### Compatibilité

- macOS, Linux, Windows
- Node.js 20+

---

## Organisation du code

```
src/
├── commands/            # Une commande = un fichier
├── utils/               # Helpers (logger, config, etc.)
├── types/               # Types TypeScript
└── index.ts             # Entry point + CLI setup
```

---

## Conventions de nommage

### Fichiers

- Commandes : `command-name.ts`
- Utils : `util-name.ts`
- Types : `entity.types.ts`

### Code

- Fonctions : camelCase
- Constantes : UPPER_SNAKE_CASE
- Types : PascalCase
- Commandes CLI : kebab-case

---

## Scripts utiles

```bash
# Dev
npm run dev -- init          # Exécuter commande init

# Build
npm run build               # Compiler TypeScript

# Test
npm run test                # Tests unitaires

# Link local
npm link                    # Installer globalement en dev
{{CLI_NAME}} --help         # Tester

# Publish
npm version patch           # Bump version
npm publish                 # Publier
```

---

## Workflow de développement

### 1. Créer une commande

```bash
# Créer le fichier
touch src/commands/new-command.ts

# Implémenter
# - export const newCommand = new Command(...)
# - Ajouter dans src/index.ts

# Tester
npm run dev -- new-command

# Tests
npm run test
```

### 2. Tests

```typescript
// tests/commands/init.test.ts
import { initCommand } from '../../src/commands/init';

describe('init command', () => {
  it('should create project structure', async () => {
    // Test logic
  });
});
```

### 3. Publish

```bash
# Bump version
npm version patch

# Build
npm run build

# Publish
npm publish

# Tag Git
git push --tags
```

---

## Configuration locale

Template :
```bash
cp ~/Claude/.claude/claude.local.template.md ./claude.local.md
```

Contenu :
```markdown
## API Keys (si nécessaire)

NPM_TOKEN=xxx
GITHUB_TOKEN=xxx
```

---

**Dernière mise à jour** : {{DATE}}
