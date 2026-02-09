# Claude Workflow Template

Template de workspace pour Claude Code avec architecture modulaire : Rules, Skills, Agents et memoire hierarchique.

---

## Demarrage rapide

### 1. Creer votre repo depuis ce template

Cliquez sur **"Use this template"** en haut de cette page GitHub, ou :

```bash
gh repo create mon-workflow --template Alexmacapple/claude-workflow-template --public --clone
cd mon-workflow
```

### 2. Installer

```bash
chmod +x setup.sh
./setup.sh
```

Le script interactif va :
- Installer le hook pre-commit (verification Markdown)
- Creer les liens symboliques utiles
- Proposer d'installer les alias zsh

### 3. Creer votre premier projet

```bash
/init mon-premier-projet
```

---

## Ce qui est inclus

### Architecture Claude Code

| Composant | Emplacement | Description |
|-----------|-------------|-------------|
| 8 Rules | `.claude/rules/` | Markdown, Git, naming, TypeScript, API, frontend, security, tests |
| 1 Skill | `.claude/skills/` | `/verifier-regles-md` - Audit conformite Markdown |
| 1 Commande | `.claude/commands/` | `/init` - Initialiser un nouveau projet |

### Documentation

- **GUIDELINES-CLAUDE-CODE.MD** : Reference technique (memoire, skills, agents, rules, hooks)
- **MON-PREMIER-PROJET-HOW-TO.MD** : Guide pas-a-pas pour creer un projet
- **FAQ.MD** : Questions frequentes
- **GLOSSAIRE.MD** : Definitions des termes cles
- **docs-public/guides/** : 7 guides detailles (rules, skills, agents, hooks, etc.)

### Outils

- **check-markdown-rules.sh** : Verification rapide de conformite Markdown (CLI)
- **setup.sh** : Installation interactive apres clone
- **setup-aliases.sh** : ~10 alias zsh parametrables
- **Hook pre-commit** : Bloque les commits avec violations Markdown

### Templates projet

4 templates dans `templates/` : API, CLI, frontend, fullstack. Chacun avec BRIEF, STACK, CLAUDE.md et .gitignore pre-configures.

---

## Structure

```
.
├── CLAUDE.MD                    # Memoire workspace (a personnaliser)
├── GUIDELINES-CLAUDE-CODE.MD    # Reference technique Claude Code
├── MON-PREMIER-PROJET-HOW-TO.MD # Guide premier projet
├── FAQ.MD / GLOSSAIRE.MD        # Documentation
├── .claude/
│   ├── rules/                   # 8 rules par domaine (auto-chargees)
│   ├── skills/                  # Workflows invocables (/commande)
│   ├── commands/                # Slash commands (/init)
│   └── claude.local.template.md # Template memoire locale
├── .git-hooks/                  # Hook pre-commit Markdown
├── docs-public/guides/          # 7 guides detailles
├── templates/                   # 4 templates projet
├── active/                      # Vos projets en cours
├── archive/                     # Projets termines
├── setup.sh                     # Installation interactive
├── setup-aliases.sh             # Alias zsh
└── check-markdown-rules.sh      # Verification Markdown CLI
```

---

## Personnalisation

Apres installation, adaptez ces fichiers a vos besoins :

1. **CLAUDE.MD** : Ajoutez vos conventions et preferences
2. **~/.claude/CLAUDE.MD** : Creez votre memoire personnelle (globale)
3. **claude.local.md** : Copiez depuis `.claude/claude.local.template.md` pour vos secrets
4. **setup-aliases.sh** : Ajustez la variable `CLAUDE_WORKSPACE` si necessaire

---

## Memoire hierarchique

Ce template exploite la memoire hierarchique de Claude Code :

```
1. ~/.claude/CLAUDE.MD           → Preferences personnelles (tous workspaces)
2. ./CLAUDE.MD                   → Conventions du workspace (ce fichier)
3. ./active/projet/CLAUDE.MD     → Specs du projet
4. ./active/projet/claude.local.md → Secrets, notes (gitignored)
5. .claude/rules/*.md            → Rules auto-chargees selon fichiers
```

---

## Exemple d'utilisation avancee

Voir le repo d'origine pour un exemple complet avec PRD, evaluations et backlog :
https://github.com/Alexmacapple/claude-workflow-perso

---

## Licence

MIT

---

**Version** : 1.0.0
**Cree avec** : Claude Code
