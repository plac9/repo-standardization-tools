#!/bin/bash
# Repository Documentation Standardization Script
# Creates standard structure across all projects

set -euo pipefail

REPO_PATH="${1:-.}"
cd "$REPO_PATH"

echo "🚀 Standardizing repository: $(basename $PWD)"
echo ""

# ============================================
# Phase 1: Create Directory Structure
# ============================================
echo "📁 Creating directory structure..."

mkdir -p .ai/session_notes
mkdir -p docs/{maintenance,guides}
mkdir -p scripts/{dev,deploy,troubleshoot,maintenance}
mkdir -p releases

echo "✅ Directories created"
echo ""

# ============================================
# Phase 2: Create .gitkeep files
# ============================================
echo "📝 Creating .gitkeep files..."

touch .ai/.gitkeep
touch docs/maintenance/.gitkeep
touch docs/guides/.gitkeep
touch scripts/dev/.gitkeep
touch scripts/deploy/.gitkeep
touch scripts/troubleshoot/.gitkeep
touch scripts/maintenance/.gitkeep
touch releases/.gitkeep

echo "✅ .gitkeep files created"
echo ""

# ============================================
# Phase 3: Update .gitignore
# ============================================
echo "🔒 Updating .gitignore..."

if [ ! -f .gitignore ]; then
    touch .gitignore
fi

# Check if already has our rules
if ! grep -q "# AI Documentation (Session-Specific)" .gitignore 2>/dev/null; then
    cat >> .gitignore << 'EOF'

# ============================================
# AI Documentation (Session-Specific)
# ============================================
# Session notes are ephemeral, not committed
.ai/session_notes/
.ai/*.scratch.md
.ai/*.tmp.md

# But commit core AI docs
!.ai/SESSION_CONTEXT.md
!.ai/ARCHITECTURE.md
!.ai/HANDOFF.md
!.ai/CHANGELOG.md
!.ai/session_brand.json
!.ai/.gitkeep

# ============================================
# Release Artifacts
# ============================================
# Releases are built locally, not committed
releases/*
!releases/.gitkeep
!releases/README.md

# ============================================
# Script Outputs
# ============================================
scripts/**/*.log
scripts/**/output/
scripts/**/tmp/
EOF
    echo "✅ .gitignore updated"
else
    echo "✅ .gitignore already has standardization rules"
fi

echo ""
echo "✅ Repository standardization complete!"
echo ""
echo "Next steps:"
echo "  1. Create template files (SESSION_CONTEXT.md, etc.)"
echo "  2. Migrate existing documentation"
echo "  3. Update README.md"
