# Template projet frontend

**Type** : Application frontend moderne (SPA ou SSR)

## Structure

```
projet-frontend/
├── README.MD                    # Ce fichier
├── BRIEF.template.md            # Template cahier des charges
├── STACK.template.md            # Template stack technique
├── CLAUDE.template.md           # Template mémoire projet
├── .gitignore.template          # Template gitignore
├── src/
│   ├── components/
│   ├── pages/
│   ├── hooks/
│   ├── utils/
│   └── App.tsx
├── public/
├── tests/
└── docs/
    └── ADR/                     # Architecture Decision Records
```

## Stack suggérée

**Framework** :
- React + TypeScript (ou Vue.js / Svelte)
- Vite
- React Router

**UI** :
- TailwindCSS
- Headless UI
- Heroicons

**State Management** :
- React Query (server state)
- Zustand (client state, optionnel)

**Forms** :
- React Hook Form
- Zod

**Testing** :
- Vitest
- Playwright

**Hosting** :
- Vercel ou Netlify

## Utilisation

### 1. Copier le template

```bash
cp -r ~/Claude/templates/projet-frontend ~/Claude/active/mon-app
cd ~/Claude/active/mon-app
```

### 2. Personnaliser les fichiers

```bash
# Renommer les templates
mv BRIEF.template.md docs/BRIEF.md
mv STACK.template.md docs/STACK.md
mv CLAUDE.template.md CLAUDE.MD
mv .gitignore.template .gitignore

# Remplacer les variables
# {{PROJECT_NAME}} → nom-du-projet
# {{AUTHOR}} → Votre nom
# {{DESCRIPTION}} → Description du projet
```

### 3. Initialiser

```bash
# Git
git init
git add .
git commit -m "Initial commit - Structure projet frontend"

# NPM
npm install
npm run dev
```

## Prochaines étapes

1. Compléter `docs/BRIEF.md`
2. Finaliser `docs/STACK.md`
3. Configurer l'API backend dans `.env`
4. Créer les ADR
5. Développer les features

## Variants

### SPA (Single Page Application)

Stack actuelle par défaut.

### SSR (Server-Side Rendering)

Remplacer Vite + React par :
- Next.js (React)
- Nuxt.js (Vue)
- SvelteKit (Svelte)

### SSG (Static Site Generation)

Utiliser :
- Next.js en mode SSG
- Astro
- Gatsby
