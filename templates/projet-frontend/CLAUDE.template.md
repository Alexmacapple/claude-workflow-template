# Mémoire projet - {{PROJECT_NAME}}

**Projet** : {{PROJECT_NAME}}
**Type** : Application frontend
**Workspace** : ~/Claude/active/{{PROJECT_NAME}}
**Créé le** : {{DATE}}

---

## Identité du projet

### Vision

{{DESCRIPTION}}

### Objectif

Créer une application frontend moderne, performante et accessible.

**Référence** : `docs/BRIEF.md`

---

## Stack technique

**Résumé** :
- Framework : React + TypeScript + Vite
- UI : TailwindCSS + Headless UI
- State : React Query + Zustand
- Hosting : Vercel

**Référence complète** : `docs/STACK.md`

---

## Contraintes

### Performance

- Lighthouse score > 90
- FCP < 1.5s
- TTI < 3s

### Accessibilité

- WCAG 2.1 niveau AA
- Support clavier
- Screen readers

### Responsive

- Mobile first
- Breakpoints : sm (640px), md (768px), lg (1024px), xl (1280px)

---

## Organisation du code

```
src/
├── components/
│   ├── ui/              # Button, Input, Modal, etc.
│   ├── features/        # LoginForm, UserCard, etc.
│   └── layout/          # Header, Footer, Sidebar
├── pages/               # Home, About, Dashboard
├── hooks/               # useAuth, useUser, etc.
├── api/                 # API client (React Query)
├── types/               # TypeScript types
└── utils/               # Helpers
```

---

## Conventions de nommage

### Fichiers

- Composants : PascalCase (`UserProfile.tsx`)
- Hooks : camelCase (`useAuth.ts`)
- Utils : camelCase (`formatDate.ts`)
- Types : PascalCase (`User.types.ts`)

### Code

- Variables/fonctions : camelCase
- Constantes : UPPER_SNAKE_CASE
- Types/Interfaces : PascalCase
- Components : PascalCase

---

## Scripts utiles

```bash
# Dev
npm run dev                  # http://localhost:5173

# Build
npm run build               # Build production
npm run preview             # Preview build

# Tests
npm run test                # Tests unitaires
npm run test:watch          # Tests watch mode
npm run test:e2e            # Tests E2E

# Quality
npm run lint                # ESLint
npm run type-check          # TypeScript
npm run format              # Prettier
```

---

## Configuration locale

Template :
```bash
cp ~/Claude/.claude/claude.local.template.md ./claude.local.md
```

Contenu :
```markdown
## API Configuration

VITE_API_URL=http://localhost:3000/api

## Secrets

VITE_GOOGLE_ANALYTICS_ID=xxx
```

---

**Dernière mise à jour** : {{DATE}}
