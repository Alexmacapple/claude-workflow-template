---
paths: ["**/*.test.ts", "**/*.test.tsx", "**/*.spec.ts", "**/tests/**"]
---

# Regles de tests

Conventions pour les tests unitaires, d'integration et end-to-end (Vitest)

---

## Structure et nommage

- Grouper avec `describe`, nommer clairement avec `it`
- Convention : `should + comportement attendu` (en anglais)
- Fichiers : `nomFichier.test.ts` ou `nomFichier.spec.ts`

```typescript
describe('UserService', () => {
  describe('findById', () => {
    it('should return user when id exists', async () => { });
    it('should throw error when id does not exist', async () => { });
  });
});
```

---

## Pattern AAA (arrange, act, assert)

Structurer **tous** les tests en 3 phases :

```typescript
it('should return user when id exists', async () => {
  // Arrange
  const expectedUser = createMockUser();
  vi.spyOn(prisma.user, 'findUnique').mockResolvedValue(expectedUser);

  // Act
  const result = await userService.findById('123');

  // Assert
  expect(result).toEqual(expectedUser);
});
```

---

## Isolation

- `beforeEach` : `vi.clearAllMocks()`
- `afterEach` : `vi.restoreAllMocks()`
- Chaque test est independant (pas de dependance entre tests)
- Un test = un comportement

---

## Mocks et factories

- `vi.mock()` pour les dependances externes
- Creer des **factory functions** pour les donnees de test

```typescript
export const createMockUser = (overrides?: Partial<User>): User => ({
  id: '123', name: 'John Doe', email: 'john@example.com',
  createdAt: new Date(), ...overrides
});
```

---

## Assertions

- Utiliser les matchers specifiques : `toBe`, `toEqual`, `toHaveLength`, `toBeInstanceOf`
- Eviter `toBeTruthy()` (trop vague)
- Coverage cible : **> 80%** pour tout nouveau code

---

## Types de tests

- **Unitaire** : Une fonction/classe isolee, mocks des dependances
- **Integration** : Plusieurs composants ensemble (supertest pour API)
- **E2E** : Parcours utilisateur complets (Playwright)
- **React** : `@testing-library/react` (render, screen, fireEvent)

---

## References

- [Vitest Documentation](https://vitest.dev/)
- [Testing Library](https://testing-library.com/)
- [Playwright Documentation](https://playwright.dev/)
