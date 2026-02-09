# Hooks Git versionnés

Ce dossier contient les templates de hooks Git du workspace.

**Important** : Les hooks Git (`.git/hooks/`) ne sont pas versionnés par défaut. Ce dossier permet de conserver et partager les hooks.

---

## Installation des hooks

### Installation automatique (après clone)

```bash
# Copier tous les hooks
cp .git-hooks/* .git/hooks/

# Rendre exécutables
chmod +x .git/hooks/*
```

### Installation manuelle

**Hook pre-commit** :
```bash
cp .git-hooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

---

## Hooks disponibles

### pre-commit

**Fonction** : Vérifie la conformité des fichiers Markdown avant commit

**Vérifications** :
- Emojis interdits
- Capitalisation française des titres
- Exceptions pour noms propres

**Documentation** : `docs-public/guides/git-hooks-guide.md`

---

## Mise à jour des hooks

Toujours modifier le template versionné dans `.git-hooks/`, puis copier vers `.git/hooks/` :

```bash
# 1. Modifier le template (source de vérité)
code .git-hooks/pre-commit

# 2. Copier vers le hook actif
cp .git-hooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

# 3. Committer le template
git add .git-hooks/pre-commit
git commit -m "Mise à jour hook pre-commit"
```

---

## Désactivation temporaire

Pour désactiver un hook sans le supprimer :

```bash
# Renommer
mv .git/hooks/pre-commit .git/hooks/pre-commit.disabled

# Réactiver
mv .git/hooks/pre-commit.disabled .git/hooks/pre-commit
```

Ou bypass au commit :
```bash
git commit --no-verify
```

---

**Note** : Le dossier `.git-hooks/` est versionné, contrairement à `.git/hooks/`.
