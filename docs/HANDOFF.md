# Documentation Standardization - Implementation Handoff

**Date**: 2025-11-09
**Status**: 1 of 12 repos complete (xander-dashboard ✅)
**Remaining**: 11 repos

## What Was Completed

### ✅ xander-dashboard (COMPLETE)
- **Before**: 20+ scattered .md files at root level
- **After**: Clean structure, only README.md at root
- **Migrated**:
  - 20+ session/deployment files → `docs/maintenance/` or `.ai/session_notes/`
  - XBOX_SETUP.md → `docs/guides/xbox-setup.md`
  - All deployment docs properly dated and organized
- **Structure**: Full `.ai/`, `docs/`, `scripts/` hierarchy in place

## Tools Created

All scripts are in `/tmp/` and ready to use:

1. **`/tmp/apply-standards.sh [repo-path]`**
   - Creates standard directory structure
   - Applies all templates with proper naming
   - Updates .gitignore
   - Creates placeholder docs
   - **Usage**: `/tmp/apply-standards.sh ~/dev/laclair/netcalc`

2. **`/tmp/standardize-repo.sh [repo-path]`**
   - Creates directories only (no templates)
   - Updates .gitignore
   - Used by apply-standards.sh

3. **Templates in `/tmp/templates/`**:
   - `SESSION_CONTEXT.md` - AI session context template
   - `ARCHITECTURE.md` - Architecture documentation template
   - `HANDOFF.md` - Session handoff template
   - `TROUBLESHOOTING.md` - Troubleshooting guide template
   - `scripts-README.md` - Scripts documentation template

## Remaining Repositories (11)

### High Priority (Need Special Handling)

#### 1. ai-device-setup
**Problem**: 8+ AI tool config directories (.claude, .cursor, .gemini, etc.)
**Actions needed**:
1. Run: `/tmp/apply-standards.sh ~/dev/laclair/ai-device-setup`
2. Add to .gitignore:
   ```
   .claude/
   .cursor/
   .gemini/
   .kiro/
   .roo/
   .taskmaster/
   .trae/
   .windsurf/
   .zed/
   .clinerules/
   ```
3. Consolidate useful content from all AI configs into `.ai/SESSION_CONTEXT.md`
4. Move CLAUDE.md, AGENTS.md content → `.ai/SESSION_CONTEXT.md`
5. Move LACLAIR_CODE_STANDARDS.md → `docs/CODE_STANDARDS.md`

#### 2. homelab-iac
**Problem**: 6 dated .md files at root
**Actions needed**:
1. Run: `/tmp/apply-standards.sh ~/dev/infrastructure/homelab-iac`
2. Move files:
   ```bash
   mv INFRASTRUCTURE.md docs/
   mv GITHUB-ACTIONS-OPTIMIZATION-2025-10-12.md docs/maintenance/2025-10-12-github-actions-optimization.md
   mv MONITORING-GAPS-REMEDIATION-2025-10-06.md docs/maintenance/2025-10-06-monitoring-gaps-remediation.md
   mv VERSION-DRIFT-REMEDIATION-PLAN-2025-10-06.md docs/maintenance/2025-10-06-version-drift-remediation.md
   mv DOCKGE-CHANGES-20251023.md docs/maintenance/2025-10-23-dockge-changes.md
   mv CLAUDE-CODE-WEB-SETUP.md .ai/ARCHITECTURE.md  # or merge if exists
   ```

#### 3. ih-onboard-form
**Problem**: Has good structure but needs standardization
**Actions needed**:
1. Run: `/tmp/apply-standards.sh ~/dev/rtis/ih-onboard-form`
2. Copy content from `.claude/CLAUDE.md` → `.ai/SESSION_CONTEXT.md`
3. Move scattered root files:
   ```bash
   mv CLEANUP-COMPLETE.md docs/maintenance/
   mv DATABASE-*.txt docs/maintenance/
   mv GOOD-MORNING-SUMMARY-*.md .ai/session_notes/  # gitignored
   ```
4. Keep existing `documentation/` and `deployment/` dirs
5. Create symlinks for consistency:
   ```bash
   cd docs
   ln -s ../documentation detailed-documentation
   ln -s ../deployment deployment-procedures
   ```

### Medium Priority (Straightforward)

#### 4-5. PowerShell Projects (2 repos)
**Repos**: `~/dev/laclair/powershell`, `~/dev/rtis/powershell`
**Actions for both**:
1. Run: `/tmp/apply-standards.sh [repo-path]`
2. Move files:
   ```bash
   mv CLAUDE.md .ai/SESSION_CONTEXT.md
   mv *_CODE_STANDARDS.md docs/CODE_STANDARDS.md
   # Keep CONTRIBUTING.md at root
   ```

#### 6-8. Web Apps (3 repos)
**Repos**: `patrick-laclair-me`, `laclair-family-us`, `laclair-terminal`
**Actions for all**:
1. Run: `/tmp/apply-standards.sh [repo-path]`
2. Add web-specific docs:
   - `docs/GETTING_STARTED.md` - Local development setup
   - `docs/DEPLOYMENT.md` - Web deployment procedures
   - `scripts/dev/setup.sh` - Environment setup script
   - `scripts/deploy/deploy.sh` - Deployment script

#### 9-11. Tools (3 repos)
**Repos**: `netcalc`, `xanban`, `ai-workspace`
**Actions**:
1. Run: `/tmp/apply-standards.sh [repo-path]`
2. **netcalc**: Add Swift-specific docs
3. **xanban**: Organize existing scripts/ into subdirs
4. **ai-workspace**: Already well-organized, just standardize

## Quick Apply Script

For simple repos (no migration needed), use this one-liner:

```bash
for repo in patrick-laclair-me laclair-family-us laclair-terminal netcalc xanban; do
  echo "Standardizing $repo..."
  /tmp/apply-standards.sh ~/dev/laclair/$repo
done
```

## After Applying to Each Repo

1. **Review SESSION_CONTEXT.md**:
   ```bash
   cd [repo]
   vim .ai/SESSION_CONTEXT.md  # Customize with project details
   ```

2. **Customize docs**:
   - Fill in GETTING_STARTED.md with actual setup steps
   - Add DEPLOYMENT.md with real deployment procedures
   - Document actual troubleshooting in TROUBLESHOOTING.md

3. **Update README.md** (add this section):
   ```markdown
   ## Documentation

   - 📘 **[Getting Started](docs/GETTING_STARTED.md)** - Setup and first steps
   - 🏗️ **[Architecture](docs/ARCHITECTURE.md)** - System design
   - 🚀 **[Deployment](docs/DEPLOYMENT.md)** - Deployment procedures
   - 🔧 **[Troubleshooting](docs/TROUBLESHOOTING.md)** - Common issues
   - 📖 **[Full Documentation](docs/README.md)** - Complete index

   ### For AI Agents
   - **[Session Context](.ai/SESSION_CONTEXT.md)** - Current project state
   - **[Architecture](.ai/ARCHITECTURE.md)** - Technical decisions
   - **[Handoff](.ai/HANDOFF.md)** - Session transitions
   ```

4. **Commit**:
   ```bash
   git add .ai docs scripts .gitignore
   git commit -m "Standardize documentation structure

   - Implement .ai/ for AI session context
   - Organize docs/ with troubleshooting and guides
   - Structure scripts/ by purpose
   - Update .gitignore for session management

   🤖 Generated with Claude Code"
   ```

## Dotfiles Aliases

Add to `~/.zshrc`:

```bash
# === PROJECT DOCUMENTATION ALIASES ===

# Navigate to docs
alias pdocs='cd docs && ls -la'

# View AI context
alias pcontext='cat .ai/SESSION_CONTEXT.md | less'
alias parch='cat .ai/ARCHITECTURE.md | less'
alias phandoff='cat .ai/HANDOFF.md | less'

# View scripts
alias pscripts='cd scripts && tree -L 2'

# Quick session note
function pnote() {
    local note_file=".ai/session_notes/$(date +%Y-%m-%d).md"
    mkdir -p .ai/session_notes
    echo "## $(date +%H:%M) - $*" >> "$note_file"
    echo "" >> "$note_file"
    echo "✅ Session note added to $note_file"
}

# Update session context timestamp
function ptouch() {
    if [ -f .ai/SESSION_CONTEXT.md ]; then
        sed -i '' "s/\*\*Last Updated\*\*:.*/\*\*Last Updated\*\*: $(date +%Y-%m-%d\ %H:%M)/" .ai/SESSION_CONTEXT.md
        echo "✅ Updated SESSION_CONTEXT.md timestamp"
    else
        echo "❌ No SESSION_CONTEXT.md found"
    fi
}
```

## Validation Checklist

For each repository:

- [ ] Only README.md (and standard files) at root
- [ ] .ai/ directory with 4 core files + session_brand.json
- [ ] docs/ directory with organized documentation
- [ ] scripts/ organized into subdirectories
- [ ] .gitignore excludes .ai/session_notes/ and releases/
- [ ] README.md references new documentation structure
- [ ] All scattered docs migrated to appropriate locations
- [ ] No orphaned or duplicate documentation

## Progress Tracking

### Completed (1/12)
- ✅ xander-dashboard

### In Progress (0/12)
- (none)

### Pending (11/12)
- ❌ ai-device-setup (HIGH - complex)
- ❌ homelab-iac (HIGH)
- ❌ ih-onboard-form (HIGH)
- ❌ laclair/powershell
- ❌ rtis/powershell
- ❌ patrick-laclair-me
- ❌ laclair-family-us
- ❌ laclair-terminal
- ❌ netcalc
- ❌ xanban
- ❌ ai-workspace

## Estimated Time Remaining

- **Complex repos** (3): ~2 hours (ai-device-setup, homelab-iac, ih-onboard-form)
- **Simple repos** (8): ~2 hours (run script + basic customization)
- **Total**: ~4 hours of focused work

## Success Criteria

✅ When complete:
1. All 12 repos have consistent structure
2. No scattered docs at root (except standard files)
3. Every repo has .ai/SESSION_CONTEXT.md with current state
4. Can find any documentation in <30 seconds
5. Can start new AI session and immediately understand any project
6. Scripts organized and documented
7. Clean, maintainable, professional

---

**Next Session**: Continue with ai-device-setup (worst remaining case)
**Scripts Location**: `/tmp/apply-standards.sh` and `/tmp/templates/`
**This Handoff**: `/tmp/DOCUMENTATION-STANDARDIZATION-HANDOFF.md`
