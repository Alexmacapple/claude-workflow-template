#!/bin/bash

# setup.sh
# Script d'installation interactif du workspace Claude
# Usage: ./setup.sh

set -e

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

WORKSPACE_DIR="$(cd "$(dirname "$0")" && pwd)"

echo -e "${BLUE}════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Installation du workspace Claude${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════${NC}"
echo ""
echo "  Workspace : $WORKSPACE_DIR"
echo ""

# Verifier qu'on est dans le bon dossier
if [ ! -f "$WORKSPACE_DIR/CLAUDE.MD" ]; then
  echo -e "${RED}Erreur: CLAUDE.MD non trouve dans $WORKSPACE_DIR${NC}"
  exit 1
fi

cd "$WORKSPACE_DIR"

# --- Etape 1 : Hook pre-commit ---

echo -e "${YELLOW}[1/3] Hook pre-commit (verification Markdown)${NC}"
echo ""

read -p "  Installer le hook pre-commit ? [O/n] " INSTALL_HOOK
INSTALL_HOOK=${INSTALL_HOOK:-O}

if [[ "$INSTALL_HOOK" =~ ^[OoYy]$ ]]; then
  if [ -d ".git" ]; then
    mkdir -p .git/hooks
    if [ -L ".git/hooks/pre-commit" ] || [ -f ".git/hooks/pre-commit" ]; then
      rm -f .git/hooks/pre-commit
    fi
    ln -s ../../.git-hooks/pre-commit .git/hooks/pre-commit
    chmod +x .git-hooks/pre-commit
    echo -e "  ${GREEN}OK${NC} Hook pre-commit installe"
  else
    echo -e "  ${YELLOW}--${NC} Pas de depot Git (.git/ absent). Initialisez avec 'git init' d'abord."
  fi
else
  echo "  -- Ignore"
fi

echo ""

# --- Etape 2 : Liens symboliques ---

echo -e "${YELLOW}[2/3] Liens symboliques${NC}"
echo ""

# Lien config-claude
if [ -L "config-claude" ]; then
  echo "  config-claude/ existe deja"
else
  ln -s .claude config-claude
  echo -e "  ${GREEN}OK${NC} config-claude/ -> .claude/"
fi

# Lien hooks dans .claude
if [ -L ".claude/hooks" ]; then
  echo "  .claude/hooks existe deja"
else
  ln -s ../.git-hooks .claude/hooks
  echo -e "  ${GREEN}OK${NC} .claude/hooks -> .git-hooks/"
fi

# Lien memoire personnelle (optionnel)
if [ -f ~/.claude/CLAUDE.MD ]; then
  if [ ! -L ".claude/CLAUDE-personal.MD" ]; then
    ln -s ~/.claude/CLAUDE.MD .claude/CLAUDE-personal.MD
    echo -e "  ${GREEN}OK${NC} .claude/CLAUDE-personal.MD -> memoire personnelle"
  else
    echo "  .claude/CLAUDE-personal.MD existe deja"
  fi
else
  echo -e "  ${YELLOW}--${NC} ~/.claude/CLAUDE.MD non trouve (optionnel)"
fi

# Lien gitignore
if [ ! -L ".claude/gitignore" ]; then
  ln -s ../.gitignore .claude/gitignore
  echo -e "  ${GREEN}OK${NC} .claude/gitignore -> .gitignore"
fi

echo ""

# --- Etape 3 : Alias zsh ---

echo -e "${YELLOW}[3/3] Alias zsh${NC}"
echo ""

read -p "  Installer les alias dans ~/.zshrc ? [o/N] " INSTALL_ALIASES
INSTALL_ALIASES=${INSTALL_ALIASES:-N}

if [[ "$INSTALL_ALIASES" =~ ^[OoYy]$ ]]; then
  if [ -f "setup-aliases.sh" ]; then
    # Verifier si deja installe
    if grep -q "CLAUDE_WORKSPACE" ~/.zshrc 2>/dev/null; then
      echo -e "  ${YELLOW}--${NC} Les alias semblent deja installes dans ~/.zshrc"
    else
      echo "" >> ~/.zshrc
      echo "# --- Claude Workspace Aliases ---" >> ~/.zshrc
      cat setup-aliases.sh >> ~/.zshrc
      echo -e "  ${GREEN}OK${NC} Alias ajoutes dans ~/.zshrc"
      echo "  Rechargez avec : source ~/.zshrc"
    fi
  else
    echo -e "  ${YELLOW}--${NC} setup-aliases.sh non trouve"
  fi
else
  echo "  -- Ignore (vous pouvez le faire plus tard : cat setup-aliases.sh >> ~/.zshrc)"
fi

echo ""

# --- Rendre les scripts executables ---

chmod +x check-markdown-rules.sh 2>/dev/null || true

# --- Resume ---

echo -e "${BLUE}════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}  Installation terminee${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════${NC}"
echo ""
echo "  Prochaines etapes :"
echo ""
echo "  1. Personnaliser CLAUDE.MD avec vos conventions"
echo "  2. Creer votre premier projet : /init mon-premier-projet"
echo "  3. Lire le guide : cat MON-PREMIER-PROJET-HOW-TO.MD"
echo ""
echo "  Configurer Git (si pas deja fait) :"
echo "    git config --global user.name \"Votre Nom\""
echo "    git config --global user.email \"votre@email.com\""
echo ""
