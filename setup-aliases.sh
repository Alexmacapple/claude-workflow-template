# Claude Workspace - Alias zsh
# Variable a ajuster selon votre workspace
CLAUDE_WORKSPACE="${CLAUDE_WORKSPACE:-$HOME/Claude}"

# Navigation
alias cdcl="cd $CLAUDE_WORKSPACE"
alias cdconfig="cd $CLAUDE_WORKSPACE/.claude"
alias cdrules="cd $CLAUDE_WORKSPACE/.claude/rules"
alias cdskills="cd $CLAUDE_WORKSPACE/.claude/skills"
alias cdactive="cd $CLAUDE_WORKSPACE/active"
alias cdarchive="cd $CLAUDE_WORKSPACE/archive"

# Edition (VS Code)
alias editclaude="code $CLAUDE_WORKSPACE/CLAUDE.MD"
alias editconfig="code $CLAUDE_WORKSPACE/.claude"

# Consultation
alias catclaude="cat $CLAUDE_WORKSPACE/CLAUDE.MD"
alias catstructure="cat $CLAUDE_WORKSPACE/STRUCTURE.txt"

# Outils
alias checkmd="$CLAUDE_WORKSPACE/check-markdown-rules.sh"

# Gestion zsh
alias catzshrc="cat ~/.zshrc"
alias editzshrc="code ~/.zshrc"
alias reloadzshrc="source ~/.zshrc && echo 'Config zsh rechargee'"
