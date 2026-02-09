#!/bin/bash

# check-markdown-rules.sh
# Vérification rapide de conformité des fichiers Markdown aux règles markdown-rules.md
# Usage: ./check-markdown-rules.sh

set -e

# Couleurs pour sortie
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Vérification conformité Markdown${NC}"
echo -e "${BLUE}  Référence: .claude/rules/markdown-rules.md${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo ""

# Variables
WORKSPACE_DIR="$(cd "$(dirname "$0")" && pwd)"
VIOLATIONS=0
TOTAL_FILES=0
CONFORME_FILES=0

# Créer fichier temporaire pour rapport
REPORT_FILE=$(mktemp)

echo -e "${YELLOW}[1/4] Scan des fichiers Markdown...${NC}"
echo ""

# Trouver tous les fichiers .MD et .md (exclure node_modules, .git, builds)
MD_FILES=$(find "$WORKSPACE_DIR" \
  -type f \( -name "*.MD" -o -name "*.md" \) \
  ! -path "*/node_modules/*" \
  ! -path "*/.git/*" \
  ! -path "*/dist/*" \
  ! -path "*/build/*" \
  ! -path "*/.next/*" \
  2>/dev/null)

TOTAL_FILES=$(echo "$MD_FILES" | wc -l | tr -d ' ')
echo -e "  ${GREEN}✓${NC} Fichiers trouvés: ${TOTAL_FILES}"
echo ""

echo -e "${YELLOW}[2/4] Vérification des emojis interdits...${NC}"
echo ""

# Pattern d'emojis courants à détecter
EMOJI_PATTERN='[✅❌⚠️⏳🎯📚🔥💡🏆⭐🔴🟡🟢🚀📝✨🎉🔧📊🎨🛠️💻🔍📌⚡🌟]'

while IFS= read -r file; do
  if [ -f "$file" ]; then
    # Chercher emojis (ignorer les blocs de code pour éviter faux positifs)
    # Note: grep simple, pas parfait mais suffisant pour détection rapide
    EMOJI_COUNT=$(grep -o "$EMOJI_PATTERN" "$file" 2>/dev/null | wc -l | tr -d ' ')

    if [ "$EMOJI_COUNT" -gt 0 ]; then
      RELATIVE_PATH=$(echo "$file" | sed "s|$WORKSPACE_DIR/||")
      echo -e "  ${RED}✗${NC} $RELATIVE_PATH"
      echo "      → $EMOJI_COUNT emoji(s) détecté(s)" >> "$REPORT_FILE"

      # Afficher les lignes avec emojis
      grep -n "$EMOJI_PATTERN" "$file" 2>/dev/null | head -3 | while IFS=: read -r line_num line_content; do
        echo "      Ligne $line_num: $(echo "$line_content" | cut -c1-60)..." >> "$REPORT_FILE"
      done
      echo "" >> "$REPORT_FILE"

      VIOLATIONS=$((VIOLATIONS + 1))
    fi
  fi
done <<< "$MD_FILES"

if [ "$VIOLATIONS" -eq 0 ]; then
  echo -e "  ${GREEN}✓${NC} Aucun emoji détecté"
fi
echo ""

echo -e "${YELLOW}[3/4] Vérification capitalisation des titres...${NC}"
echo ""

CAPS_VIOLATIONS=0

while IFS= read -r file; do
  if [ -f "$file" ]; then
    # Chercher titres avec capitalisation anglaise (heuristique)
    # Pattern: "## Mot Mot" où les deux mots commencent par une majuscule
    # Exclure les noms propres courants
    CAPS_LINES=$(grep -n '^##\+ [A-Z][a-zéèêëàâäôöùûü]* [A-Z]' "$file" 2>/dev/null | \
      grep -v "Claude Code\|GitHub\|GitLab\|Git\|PostgreSQL\|MongoDB\|Redis\|Docker\|React\|Vue\.js\|Node\.js\|Next\.js\|TypeScript\|JavaScript\|VS Code\|API REST\|HTTP\|JSON\|YAML\|HTML\|CSS\|SQL\|ADR\|PRD\|BRIEF\|STACK\|MVP\|CI/CD\|WCAG\|CRUD\|Hooks Git\|Python\|Java\|Express\|TailwindCSS\|Prisma\|PDF\|PNG\|JPEG\|SVG\|YOLO\|JWT\|Vite\|Vercel\|Railway\|Commander\.js\|Nullish Coalescing\|No Spec\|CLI\|Task()\|File System\|Lightning Talk\|Front Matter\|REST\|Zod\|Option [A-Z]\|CSRF\|Talk Standard\|Routes API\|Code Source\|Projet [A-Z]\|Applications Web\|Projets par\|Outils CLI\|Pattern AAA\|OWASP Top" || true)

    if [ ! -z "$CAPS_LINES" ]; then
      RELATIVE_PATH=$(echo "$file" | sed "s|$WORKSPACE_DIR/||")
      echo -e "  ${RED}✗${NC} $RELATIVE_PATH"
      echo "      → Capitalisation anglaise potentielle détectée" >> "$REPORT_FILE"

      echo "$CAPS_LINES" | head -3 | while IFS=: read -r line_num line_content; do
        echo "      Ligne $line_num: $line_content" >> "$REPORT_FILE"
      done
      echo "" >> "$REPORT_FILE"

      CAPS_VIOLATIONS=$((CAPS_VIOLATIONS + 1))
    fi
  fi
done <<< "$MD_FILES"

if [ "$CAPS_VIOLATIONS" -eq 0 ]; then
  echo -e "  ${GREEN}✓${NC} Capitalisation française respectée"
fi

VIOLATIONS=$((VIOLATIONS + CAPS_VIOLATIONS))
echo ""

echo -e "${YELLOW}[4/4] Génération du rapport...${NC}"
echo ""

# Calculer fichiers conformes
CONFORME_FILES=$((TOTAL_FILES - VIOLATIONS))
CONFORME_PCT=0
if [ "$TOTAL_FILES" -gt 0 ]; then
  CONFORME_PCT=$((CONFORME_FILES * 100 / TOTAL_FILES))
fi

# Afficher statistiques
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Résultats${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo ""
echo "  Fichiers analysés:     $TOTAL_FILES"
echo "  Fichiers conformes:    $CONFORME_FILES ($CONFORME_PCT%)"
echo "  Fichiers non conformes: $VIOLATIONS"
echo ""

if [ "$VIOLATIONS" -eq 0 ]; then
  echo -e "${GREEN}✓ Tous les fichiers Markdown sont conformes !${NC}"
  rm -f "$REPORT_FILE"
  exit 0
else
  echo -e "${RED}✗ Des violations ont été détectées${NC}"
  echo ""
  echo -e "${YELLOW}Détails des violations:${NC}"
  echo ""
  cat "$REPORT_FILE"

  echo -e "${YELLOW}Recommandations:${NC}"
  echo "  1. Utilisez /verifier-regles-md pour un rapport détaillé"
  echo "  2. Corrigez manuellement les violations détectées"
  echo "  3. Relancez ce script pour vérifier"
  echo ""

  rm -f "$REPORT_FILE"
  exit 1
fi
