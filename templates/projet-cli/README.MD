# Template projet CLI

**Type** : Outil en ligne de commande (Command-Line Interface)

## Structure

```
projet-cli/
├── README.MD                    # Ce fichier
├── BRIEF.template.md            # Template cahier des charges
├── STACK.template.md            # Template stack technique
├── CLAUDE.template.md           # Template mémoire projet
├── .gitignore.template          # Template gitignore
├── src/
│   ├── commands/                # Commandes CLI
│   ├── utils/                   # Utilitaires
│   ├── types/                   # Types TypeScript
│   └── index.ts                 # Point d'entrée
├── tests/
├── bin/
│   └── cli.js                   # Executable
└── docs/
    └── ADR/                     # Architecture Decision Records
```

## Stack suggérée

**Runtime** :
- Node.js 20 LTS
- TypeScript 5

**CLI Framework** :
- Commander.js (ou Yargs)
- Inquirer.js (prompts interactifs)
- Chalk (couleurs)
- Ora (spinners)

**Testing** :
- Jest
- @types/node

**Distribution** :
- npm publish
- ou Binaries avec pkg

## Utilisation

### 1. Copier le template

```bash
cp -r ~/Claude/templates/projet-cli ~/Claude/active/mon-cli
cd ~/Claude/active/mon-cli
```

### 2. Personnaliser les fichiers

```bash
# Renommer les templates
mv BRIEF.template.md docs/BRIEF.md
mv STACK.template.md docs/STACK.md
mv CLAUDE.template.md CLAUDE.MD
mv .gitignore.template .gitignore

# Éditer package.json
# - name: {{PROJECT_NAME}}
# - bin: { "{{CLI_NAME}}": "./bin/cli.js" }
```

### 3. Initialiser

```bash
# Git
git init
git add .
git commit -m "Initial commit - Structure CLI"

# NPM
npm install

# Link local
npm link

# Test
{{CLI_NAME}} --help
```

## Commandes type

```bash
{{CLI_NAME}} init              # Initialiser un projet
{{CLI_NAME}} build             # Builder
{{CLI_NAME}} deploy            # Déployer
{{CLI_NAME}} --version         # Version
{{CLI_NAME}} --help            # Aide
```

## Prochaines étapes

1. Compléter `docs/BRIEF.md`
2. Finaliser `docs/STACK.md`
3. Implémenter les commandes
4. Créer les tests
5. Publier sur npm

## Distribution

### npm

```bash
npm login
npm publish
```

### Binaries (pkg)

```bash
npm install -g pkg
pkg . --targets node20-macos,node20-linux,node20-win
```
