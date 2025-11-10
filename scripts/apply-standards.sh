#!/bin/bash
# Complete Repository Standardization Application
# Applies structure + templates to a repository

set -euo pipefail

REPO_PATH="${1}"
REPO_NAME=$(basename "$REPO_PATH")
TEMPLATES_DIR="/tmp/templates"
DATE=$(date +%Y-%m-%d)
DATETIME=$(date "+%Y-%m-%d %H:%M")

cd "$REPO_PATH"

echo "════════════════════════════════════════════════════════════════"
echo "  Applying Documentation Standards to: $REPO_NAME"
echo "════════════════════════════════════════════════════════════════"
echo ""

# Step 1: Run standardization script
echo "Step 1: Creating directory structure..."
/tmp/standardize-repo.sh "$REPO_PATH"
echo ""

# Step 2: Apply templates
echo "Step 2: Applying templates..."

# Function to apply template with substitutions
apply_template() {
    local template="$1"
    local dest="$2"
    local project_name="$3"

    sed -e "s/\[PROJECT_NAME\]/$project_name/g" \
        -e "s/\[DATE\]/$DATE/g" \
        -e "s/\[REPO_NAME\]/${REPO_NAME}/g" \
        "$TEMPLATES_DIR/$template" > "$dest"

    echo "  ✓ Created $dest"
}

# Apply .ai/ templates
apply_template "SESSION_CONTEXT.md" ".ai/SESSION_CONTEXT.md" "$REPO_NAME"
apply_template "ARCHITECTURE.md" ".ai/ARCHITECTURE.md" "$REPO_NAME"
apply_template "HANDOFF.md" ".ai/HANDOFF.md" "$REPO_NAME"

# Create CHANGELOG
cat > .ai/CHANGELOG.md << EOF
# $REPO_NAME - Changelog

## [$DATE] - Documentation Standardization

### Added
- Standard documentation structure
- AI session context system
- Troubleshooting guide framework
- Organized script directories

### Changed
- Migrated scattered documentation to organized structure
- Updated .gitignore for session management

---

**Note**: Maintain this log for significant changes to keep AI agents informed.
EOF
echo "  ✓ Created .ai/CHANGELOG.md"

# Apply docs/ templates
apply_template "TROUBLESHOOTING.md" "docs/TROUBLESHOOTING.md" "$REPO_NAME"

# Create docs index
cat > docs/README.md << EOF
# $REPO_NAME - Documentation Index

## Getting Started
- **[Getting Started](GETTING_STARTED.md)** - Setup and first steps
- **[Configuration](CONFIGURATION.md)** - Configuration reference

## Architecture & Design
- **[Architecture](ARCHITECTURE.md)** - System design and decisions
- **[API Documentation](API.md)** - API reference (if applicable)

## Operations
- **[Deployment](DEPLOYMENT.md)** - Deployment procedures
- **[Troubleshooting](TROUBLESHOOTING.md)** - Common issues and solutions
- **[Maintenance](maintenance/INDEX.md)** - Maintenance records

## Guides
- See [\`guides/\`](guides/) directory for detailed guides

---

**For AI Agents**: Session context is in \`.ai/SESSION_CONTEXT.md\`
EOF
echo "  ✓ Created docs/README.md"

# Apply scripts README
apply_template "scripts-README.md" "scripts/README.md" "$REPO_NAME"

# Create maintenance index
cat > docs/maintenance/INDEX.md << EOF
# $REPO_NAME - Maintenance Log Index

## Recent Maintenance

### $DATE - Documentation Standardization
- Implemented standard documentation structure
- Organized existing documentation
- Created troubleshooting framework

---

## Maintenance Log Format

Maintenance logs should follow this naming convention:
\`YYYY-MM-DD-description.md\`

Each log should include:
- Date and duration
- What was done
- Issues encountered
- Outcome/status
- Follow-up actions needed

EOF
echo "  ✓ Created docs/maintenance/INDEX.md"

echo ""
echo "Step 3: Creating placeholder files..."

# Create placeholder docs
for doc in GETTING_STARTED DEPLOYMENT CONFIGURATION API; do
    if [ ! -f "docs/${doc}.md" ]; then
        cat > "docs/${doc}.md" << EOF
# $REPO_NAME - $doc

**Status**: To be completed
**Last Updated**: $DATE

[Content to be added]

---

**Note**: This is a placeholder. Add project-specific content as needed.
EOF
        echo "  ✓ Created docs/${doc}.md (placeholder)"
    fi
done

echo ""
echo "════════════════════════════════════════════════════════════════"
echo "  ✅ Standardization Complete!"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Created structure:"
echo "  📁 .ai/              - AI session documentation"
echo "  📁 docs/             - Human documentation"
echo "  📁 scripts/          - Utility scripts (organized)"
echo "  📁 releases/         - Release artifacts (gitignored)"
echo ""
echo "Next steps:"
echo "  1. Review .ai/SESSION_CONTEXT.md and customize"
echo "  2. Migrate existing docs to appropriate locations"
echo "  3. Update README.md with new structure references"
echo "  4. Commit: git add .ai docs scripts .gitignore"
echo ""
