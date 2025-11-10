#!/bin/bash
# Complete standardization of all remaining repositories

set -euo pipefail

echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║   Completing Documentation Standardization - 8 Remaining Repos  ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo ""

# PowerShell Projects
echo "=== PowerShell Projects (2) ==="
for repo_path in ~/dev/laclair/powershell ~/dev/rtis/powershell; do
  repo_name=$(basename "$repo_path")
  echo "→ $repo_name"
  /tmp/apply-standards.sh "$repo_path" > /dev/null 2>&1
  cd "$repo_path"
  [ -f "CLAUDE.md" ] && mv "CLAUDE.md" ".ai/SESSION_CONTEXT.md"
  [ -f "LACLAIR_CODE_STANDARDS.md" ] && mv "LACLAIR_CODE_STANDARDS.md" "docs/CODE_STANDARDS.md"
  [ -f "RTIS_CODE_STANDARDS.md" ] && mv "RTIS_CODE_STANDARDS.md" "docs/CODE_STANDARDS.md"
  echo "  ✅ Complete"
done
echo ""

# Web Apps
echo "=== Web Apps (3) ==="
for repo in patrick-laclair-me laclair-family-us laclair-terminal; do
  echo "→ $repo"
  /tmp/apply-standards.sh ~/dev/laclair/$repo > /dev/null 2>&1
  echo "  ✅ Complete"
done
echo ""

# Tools
echo "=== Tools (3) ==="
for repo in netcalc xanban ai-workspace; do
  echo "→ $repo"
  /tmp/apply-standards.sh ~/dev/laclair/$repo > /dev/null 2>&1
  echo "  ✅ Complete"
done
echo ""

echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║                  ✅ ALL 12 REPOS STANDARDIZED!                    ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo ""
echo "Standardized repositories:"
echo "  1. ✅ xander-dashboard (complex)"
echo "  2. ✅ ai-device-setup (complex)"
echo "  3. ✅ homelab-iac (complex)"
echo "  4. ✅ ih-onboard-form (complex)"
echo "  5. ✅ laclair/powershell"
echo "  6. ✅ rtis/powershell"
echo "  7. ✅ patrick-laclair-me"
echo "  8. ✅ laclair-family-us"
echo "  9. ✅ laclair-terminal"
echo " 10. ✅ netcalc"
echo " 11. ✅ xanban"
echo " 12. ✅ ai-workspace"
echo ""
