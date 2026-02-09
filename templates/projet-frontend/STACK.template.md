# Stack technique - {{PROJECT_NAME}}

**Projet** : {{PROJECT_NAME}}
**Type** : Application frontend
**Dernière mise à jour** : {{DATE}}

---

## Architecture

```
┌─────────────────┐
│   Application   │  React + TypeScript + Vite
│    (Vercel)     │
└────────┬────────┘
         │ HTTPS/REST ou GraphQL
         │
┌────────▼────────┐
│   Backend API   │  {{API_URL}}
└─────────────────┘
```

---

## Stack frontend

### Core

- **React 18** : UI library
- **TypeScript 5** : Typage statique
- **Vite 5** : Build tool

### UI et styling

- **TailwindCSS 3** : Utility-first CSS
- **Headless UI** : Composants accessibles
- **Heroicons** : Icônes
- **clsx** : Conditional classes

### State management

- **React Query** : Server state et cache
- **Zustand** (optionnel) : Client state
- **React Hook Form** : Forms
- **Zod** : Validation

### Routing

- **React Router v6** : Client-side routing

### Testing

- **Vitest** : Tests unitaires
- **Playwright** : Tests E2E
- **Testing Library** : Tests composants

### Quality

- **ESLint** : Linting
- **Prettier** : Formatage
- **TypeScript** : Type checking

---

## Hébergement

**Vercel** :
- Déploiement automatique depuis Git
- Edge network
- Preview deployments
- Analytics intégrés

**Alternative** : Netlify

---

## Variables d'environnement

```bash
VITE_API_URL={{API_URL}}
VITE_ENV=production
VITE_GOOGLE_ANALYTICS_ID={{GA_ID}}
```

---

## Structure du projet

```
src/
├── components/
│   ├── ui/              # Composants UI génériques
│   ├── features/        # Composants métier
│   └── layout/          # Layout
├── pages/               # Pages
├── hooks/               # Custom hooks
├── api/                 # API client
├── types/               # Types
├── utils/               # Utils
└── App.tsx
```

---

## Scripts

```json
{
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "preview": "vite preview",
    "test": "vitest",
    "test:e2e": "playwright test",
    "lint": "eslint src",
    "format": "prettier --write src"
  }
}
```

---

## Justifications

### Pourquoi React ?

- Écosystème mature
- Performance optimale
- Grande communauté

### Pourquoi Vite ?

- HMR ultra-rapide
- Build optimisé
- Excellente DX

### Pourquoi TailwindCSS ?

- Productivité élevée
- Design system cohérent
- Purge CSS automatique

---

**Dernière mise à jour** : {{DATE}}
