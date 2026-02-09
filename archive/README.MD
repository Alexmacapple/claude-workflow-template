# Archive

Ce dossier contient les **projets termines et archives**.

## Objectif

- Garder une trace des projets completes
- Permettre de referencer des solutions passees
- Eviter l'encombrement dans `active/`

## Archiver un projet

1. **Mettre a jour la documentation** (README, ADR, bilan)
2. **Nettoyer** (supprimer node_modules/, .env, claude.local.md)
3. **Deplacer** : `mv active/mon-projet archive/`
4. **Ajouter une date d'archivage** dans le README du projet

## Recuperation

```bash
mv archive/mon-projet active/
```
