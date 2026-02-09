---
paths: ["**/components/**", "**/pages/**", "**/hooks/**"]
---

# Regles frontend React

Conventions pour les composants React, hooks et gestion d'etat

---

## Structure des composants

- **Fonctions uniquement**, jamais de classes
- **Exports nommes** (sauf pages Next.js)
- Ordre dans un composant : hooks d'etat, hooks contexte, custom hooks, callbacks, effects, early returns, render

```typescript
interface UserCardProps {
  user: User;
  onEdit: (id: string) => void;
}

export const UserCard: React.FC<UserCardProps> = ({ user, onEdit }) => {
  const [isEditing, setIsEditing] = useState(false);
  const handleEdit = useCallback(() => onEdit(user.id), [user.id, onEdit]);

  if (!user) return null;

  return <div>{user.name}</div>;
};
```

---

## Props

- Toujours typer avec **interface TypeScript**
- Toujours **destructurer** les props
- Valeurs par defaut dans le destructuring

---

## Gestion d'etat

- `useState` : un etat = une responsabilite
- `useReducer` : si > 3 etats lies
- **Zustand** prefere a Context API pour etat global
- Context API : uniquement pour valeurs rarement modifiees (theme, locale)

---

## Effects et hooks

- Toujours declarer **toutes les dependances** dans useEffect
- **Cleanup systematique** : timers, listeners, AbortController
- Custom hooks prefixes par `use*`
- Extraire la logique reutilisable en hooks

---

## Performance

- `React.memo` pour composants couteux
- `useMemo` pour calculs couteux
- `useCallback` pour fonctions passees en props

---

## Conventions

- Handlers prefixes par `handle*` (`handleClick`, `handleSubmit`)
- Toujours typer les events React (`FormEvent`, `ChangeEvent`)
- Early returns pour rendu conditionnel
- TailwindCSS : utiliser `clsx` pour classes conditionnelles

---

## References

- [React Documentation](https://react.dev/)
- [React TypeScript Cheatsheet](https://react-typescript-cheatsheet.netlify.app/)
