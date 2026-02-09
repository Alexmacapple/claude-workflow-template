# Guidelines Claude Code - Document de reference

Reference technique basee sur la documentation officielle (code.claude.com/docs/)

**Note** : L'architecture "3 niveaux" (Skills, Agents, Rules) est une abstraction de ce workspace pour organiser le travail. Ce ne sont pas des concepts couples dans Claude Code.

---

## Memoire hierarchique

Claude Code charge automatiquement les fichiers `CLAUDE.md` selon cette hierarchie (du moins au plus specifique) :

| Priorite | Type | Emplacement |
|----------|------|-------------|
| 1 | Managed policy | `/Library/Application Support/ClaudeCode/CLAUDE.md` (macOS) |
| 2 | Utilisateur | `~/.claude/CLAUDE.md` |
| 3 | Projet | `./CLAUDE.md` ou `./.claude/CLAUDE.md` |
| 4 | Rules | `./.claude/rules/*.md` (auto-charge selon `paths`) |
| 5 | Local | `./CLAUDE.local.md` (gitignored) |
| 6 | Auto memory | `~/.claude/projects/<projet>/memory/MEMORY.md` (200 premieres lignes) |

**Les instructions plus specifiques prennent precedence sur les generales.**

Les fichiers CLAUDE.md au-dessus du repertoire de travail sont charges integralement au demarrage. Les fichiers dans les sous-repertoires se chargent a la demande.

---

## Skills (.claude/skills/*/SKILL.md)

**Role** : Workflows invocables par `/commande` ou par Claude.

**Champs frontmatter** :

| Champ | Description |
|-------|-------------|
| `name` | Identifiant (minuscules, tirets). Si omis, utilise le nom du repertoire |
| `description` | Ce que le skill fait et quand l'utiliser |
| `argument-hint` | Hint pendant l'autocompletion (ex: `[issue-number]`) |
| `allowed-tools` | Outils utilisables sans permission (ex: `Read, Grep, Glob`) |
| `model` | Modele a utiliser quand le skill est actif |
| `context` | `fork` = execution dans un subagent isole |
| `agent` | Type de subagent avec `context: fork` (ex: `Explore`, `Plan`) |
| `user-invocable` | `false` = seul Claude peut l'invoquer |
| `disable-model-invocation` | `true` = seul l'utilisateur peut l'invoquer |
| `hooks` | Hooks scopes au lifecycle du skill |

**Variables** : `$ARGUMENTS`, `$0`, `$1`, `${CLAUDE_SESSION_ID}`

---

## Agents (.claude/agents/*.md)

**Role** : Sous-agents specialises, invoques via `Task()`.

**Champs frontmatter** :

| Champ | Description |
|-------|-------------|
| `name` | Identifiant unique (minuscules, tirets) |
| `description` | Quand Claude devrait deleguer a cet agent |
| `tools` | Outils disponibles (herite tous si omis) |
| `disallowedTools` | Outils a refuser |
| `model` | `sonnet`, `opus`, `haiku`, ou `inherit` |
| `permissionMode` | `default`, `acceptEdits`, `delegate`, `dontAsk`, `bypassPermissions`, `plan` |
| `maxTurns` | Nombre max de tours |
| `skills` | Skills pre-charges dans le contexte de l'agent |
| `mcpServers` | Serveurs MCP disponibles |
| `memory` | Scope de memoire persistante : `user`, `project`, `local` |
| `hooks` | Hooks du lifecycle de l'agent |

**Contrainte** : Les agents ne peuvent pas spawner d'autres agents.

---

## Rules (.claude/rules/*.md)

**Role** : Contraintes et bonnes pratiques chargees automatiquement.

**Frontmatter** : Seul le champ `paths` est supporte.

```yaml
---
paths:
  - "src/api/**/*.ts"
  - "**/*.ts"
---
```

**Regles de chargement** :
- Rules **avec** `paths` : chargees quand les fichiers matchent les patterns
- Rules **sans** `paths` : chargees **systematiquement** (toujours actives)
- Les patterns commencant par `{` ou `*` doivent etre entre guillemets (YAML)

---

## Hooks Claude Code

A ne pas confondre avec les hooks Git (`.git/hooks/`). Les hooks Claude Code s'executent dans le cycle de vie de Claude Code.

**Configuration** : `~/.claude/settings.json`, `.claude/settings.json`, ou `.claude/settings.local.json`

**Evenements principaux** :

| Evenement | Matcher sur | Description |
|-----------|-------------|-------------|
| `SessionStart` | Source de demarrage | Au demarrage d'une session |
| `UserPromptSubmit` | - | Quand un prompt est soumis |
| `PreToolUse` | Nom de l'outil | Avant execution (peut bloquer) |
| `PostToolUse` | Nom de l'outil | Apres execution reussie |
| `PostToolUseFailure` | Nom de l'outil | Apres echec d'un outil |
| `Notification` | Type | Sur notification |
| `SubagentStart` | Type d'agent | Quand un subagent demarre |
| `SubagentStop` | Type d'agent | Quand un subagent se termine |
| `Stop` | - | Quand Claude finit de repondre |
| `PreCompact` | `manual` ou `auto` | Avant compaction du contexte |

**Types de hooks** :
- `command` : Execute une commande shell (exit 0 = allow, exit 2 = block)
- `prompt` : Envoie a Claude (Haiku) pour decision simple
- `agent` : Spawn un subagent pour verification

**Format** :
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Rappel'",
            "timeout": 5
          }
        ]
      }
    ]
  }
}
```

---

## Bonnes pratiques

### Contexte minimal

- Les fichiers CLAUDE.md doivent etre concis (charges a chaque session)
- Deleguer aux agents via `Task()` pour eviter l'explosion du contexte
- Utiliser `context: fork` pour isolation dans les skills

### Organisation

- **Skills** : Un skill = un workflow precis, orchestrateur
- **Agents** : Specialisation forte, outils restreints, une responsabilite
- **Rules** : Une rule = un domaine, auto-chargee, contraintes verifiables
- **Memoire** : Chaque niveau ne contient que ce qui lui appartient

---

## Ressources

- [Documentation officielle](https://code.claude.com/docs/)
- [Memoire et CLAUDE.md](https://code.claude.com/docs/en/memory.md)
- [Skills](https://code.claude.com/docs/en/skills.md)
- [Agents](https://code.claude.com/docs/en/sub-agents.md)
- [Hooks](https://code.claude.com/docs/en/hooks.md)

---

**Document cree le** : 2026-02-08
**Derniere mise a jour** : 2026-02-09
**Source** : Documentation officielle Claude Code (code.claude.com/docs/)
**Mainteneur** : Alex
