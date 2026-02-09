# Stack technique - {{PROJECT_NAME}}

**Projet** : {{PROJECT_NAME}}
**Type** : CLI (Command-Line Interface)
**Dernière mise à jour** : {{DATE}}

---

## Stack

### Runtime

- **Node.js 20 LTS** : Runtime JavaScript
- **TypeScript 5** : Typage statique

### CLI Framework

- **Commander.js 12** : Parsing des commandes
- **Inquirer.js 9** : Prompts interactifs
- **Chalk 5** : Couleurs dans le terminal
- **Ora 8** : Spinners et loaders
- **cli-progress** : Progress bars

### Validation

- **Zod** : Validation des configs
- **Ajv** : Validation JSON Schema

### File System

- **fs-extra** : File system enhanced
- **glob** : Pattern matching
- **chokidar** : File watching

### HTTP (si nécessaire)

- **axios** : HTTP client
- **node-fetch** : Fetch API

### Testing

- **Jest** : Tests unitaires
- **ts-jest** : Support TypeScript
- **@types/node** : Types Node.js

### Quality

- **ESLint** : Linting
- **Prettier** : Formatage

---

## Distribution

### npm

Package publié sur npm registry :
```bash
npm install -g {{CLI_NAME}}
```

### Binaries (optionnel)

Binaries standalone avec `pkg` :
- macOS (x64, arm64)
- Linux (x64, arm64)
- Windows (x64)

---

## Structure du projet

```
src/
├── commands/            # Commandes CLI
│   ├── init.ts
│   ├── build.ts
│   └── deploy.ts
├── utils/               # Utilitaires
│   ├── logger.ts
│   ├── config.ts
│   └── spinner.ts
├── types/               # Types
└── index.ts             # Entry point
```

---

## Package.json

```json
{
  "name": "{{CLI_NAME}}",
  "version": "1.0.0",
  "description": "{{DESCRIPTION}}",
  "bin": {
    "{{CLI_NAME}}": "./bin/cli.js"
  },
  "files": [
    "dist",
    "bin"
  ],
  "scripts": {
    "dev": "ts-node src/index.ts",
    "build": "tsc",
    "start": "node dist/index.js",
    "test": "jest",
    "lint": "eslint src",
    "format": "prettier --write src"
  }
}
```

---

## Scripts

```bash
# Dev
npm run dev -- init           # Exécuter commande init en dev
npm run dev -- --help         # Aide

# Build
npm run build                 # Compiler TypeScript

# Test
npm run test                  # Tests unitaires
npm run test:watch            # Tests en watch mode

# Publish
npm version patch             # Bump version
npm publish                   # Publier sur npm
```

---

## Exemple de commande

```typescript
// src/commands/init.ts
import { Command } from 'commander';
import inquirer from 'inquirer';
import chalk from 'chalk';
import ora from 'ora';

export const initCommand = new Command('init')
  .description('Initialize a new project')
  .option('-n, --name <name>', 'Project name')
  .action(async (options) => {
    const answers = await inquirer.prompt([
      {
        type: 'input',
        name: 'projectName',
        message: 'Project name:',
        default: options.name
      }
    ]);

    const spinner = ora('Creating project...').start();

    // Logic here
    await createProject(answers.projectName);

    spinner.succeed(chalk.green('Project created!'));
  });
```

---

## Justifications

### Pourquoi Commander.js ?

- API simple et intuitive
- Parsing automatique des options
- Aide auto-générée

### Pourquoi TypeScript ?

- Type safety
- Meilleure DX
- Refactoring facilité

---

**Dernière mise à jour** : {{DATE}}
