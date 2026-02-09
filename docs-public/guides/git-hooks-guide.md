# Guide des hooks Git

Documentation des hooks Git configurés dans le workspace

**Dernière mise à jour** : 2026-02-08

---

## Hook pre-commit : vérification Markdown

**Emplacement** : `.git/hooks/pre-commit`

### Objectif

Bloquer automatiquement les commits contenant des fichiers Markdown non conformes à `markdown-rules.md`.

### Fonctionnement

Le hook s'exécute automatiquement avant chaque commit et vérifie :

**1. Emojis interdits**
```regex
Pattern regex pour détecter les emojis courants
```

**2. Capitalisation anglaise des titres**
```regex
Pattern : titres avec plusieurs mots en majuscule
```

**Exceptions automatiques** :
- Noms propres : Claude Code, GitHub, React, PostgreSQL, etc.
- Acronymes : API, REST, CRUD, HTTP, JSON, etc.

### Utilisation

#### Commit normal (vérification automatique)

```bash
git add fichier.MD
git commit -m "Message"

# Le hook vérifie automatiquement
# ✓ Si conforme → commit autorisé
# ✗ Si violations → commit bloqué avec détails
```

#### Exemple de sortie conforme

```
═══════════════════════════════════════════════════════
  Hook pre-commit : vérification Markdown
═══════════════════════════════════════════════════════

Vérification des fichiers staged...

  Analyse: docs/guide.md
    ✓ Conforme

═══════════════════════════════════════════════════════
✓ Tous les fichiers Markdown sont conformes
```

#### Exemple de sortie avec violations

```
═══════════════════════════════════════════════════════
  Hook pre-commit : vérification Markdown
═══════════════════════════════════════════════════════

Vérification des fichiers staged...

  Analyse: docs/guide.md
    ✗ VIOLATION: Emoji(s) interdit(s) détecté(s)
      Ligne 42: ## Vue d'ensemble (avec emoji)
    ✗ VIOLATION: Capitalisation anglaise détectée
      Ligne 84: ## Bonnes Pratiques

═══════════════════════════════════════════════════════
✗ COMMIT BLOQUÉ

Des violations des règles Markdown ont été détectées.

Veuillez corriger les violations avant de committer :
  1. Supprimer les emojis des fichiers .MD
  2. Corriger la capitalisation des titres (style français)
  3. Relancer le commit

Pour vérifier tous les fichiers :
  ./check-markdown-rules.sh

Pour bypasser ce hook (déconseillé) :
  git commit --no-verify
```

### Workflow de correction

**Si le commit est bloqué** :

1. **Voir les violations** (déjà affichées par le hook)

2. **Corriger les fichiers**
   ```bash
   # Éditer manuellement
   code fichier-avec-violations.md

   # Ou demander à Claude de corriger
   claude
   > Corrige les violations dans fichier.md
   ```

3. **Vérifier la conformité**
   ```bash
   ./check-markdown-rules.sh
   ```

4. **Re-stage et commit**
   ```bash
   git add fichier-corrige.md
   git commit -m "Message"
   # Cette fois le hook devrait passer
   ```

### Bypasser le hook (déconseillé)

**Dans certains cas exceptionnels**, vous pouvez bypasser le hook :

```bash
git commit --no-verify -m "Message"
```

**Quand bypasser ?** (rare)
- Commit d'exemples pédagogiques contenant volontairement des violations
- Urgence critique (à corriger immédiatement après)
- Documentation de "mauvais exemples"

**Attention** : Le bypass ne corrige pas les violations, il les ignore temporairement. À utiliser avec précaution.

### Désactiver le hook

**Temporairement** :
```bash
# Renommer le hook
mv .git/hooks/pre-commit .git/hooks/pre-commit.disabled
```

**Réactiver** :
```bash
mv .git/hooks/pre-commit.disabled .git/hooks/pre-commit
```

**Définitivement** :
```bash
rm .git/hooks/pre-commit
```

### Maintenance

#### Mettre à jour les exceptions

Si vous ajoutez de nouveaux noms propres reconnus, éditez le template versionné :

```bash
code .git-hooks/pre-commit
```

Ajoutez-les dans la ligne `grep -v` :

```bash
grep -v "Claude Code|GitHub|VOTRE_NOUVEAU_NOM"
```

Puis copiez vers le hook actif :

```bash
cp .git-hooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

#### Ajouter de nouvelles vérifications

Le hook peut être étendu pour vérifier :
- Liens cassés
- Images manquantes
- Blocs de code sans langage
- Fichiers trop longs
- etc.

### Intégration avec workflow

**Workflow recommandé** :

1. Développement local avec Claude
2. Claude respecte automatiquement `markdown-rules.md`
3. Vérification manuelle : `./check-markdown-rules.sh`
4. Commit : le hook vérifie une dernière fois
5. Si passage → push vers GitHub
6. Si blocage → correction → re-commit

**Avantages** :
- Garantit 100% de conformité dans Git
- Empêche les violations d'arriver dans l'historique
- Rappel automatique des règles
- Pas besoin d'y penser

### Limites

**Ce que le hook ne fait PAS** :
- Ne corrige pas automatiquement (il bloque seulement)
- Ne vérifie que les fichiers staged (pas tout le dépôt)
- Détection heuristique (peut avoir des faux positifs/négatifs)

**Pour une vérification complète du dépôt** :
```bash
./check-markdown-rules.sh
```

**Pour une correction interactive** :
```bash
claude
> /verifier-regles-md
```

---

## Autres hooks

### Hook pre-push (futur)

**Idée** : Vérifier conformité complète avant push

**Non implémenté pour l'instant**

### Hook post-commit (futur)

**Idée** : Mise à jour automatique de CHANGELOG.MD

**Non implémenté pour l'instant**

---

## Ressources

- Documentation Git hooks : https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks
- Règles Markdown : `.claude/rules/markdown-rules.md`
- Script de vérification : `check-markdown-rules.sh`
- Skill Claude : `/verifier-regles-md`

---

**Créé le** : 2026-02-08
**Mainteneur** : Alex
