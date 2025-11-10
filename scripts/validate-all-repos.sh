#!/bin/bash
# Validate all 12 repositories

echo "=== VALIDATING ALL 12 REPOSITORIES ==="
echo ""

REPOS=(
  "~/dev/laclair/xander-dashboard"
  "~/dev/laclair/ai-device-setup"
  "~/dev/infrastructure/homelab-iac"
  "~/dev/rtis/ih-onboard-form"
  "~/dev/laclair/powershell"
  "~/dev/rtis/powershell"
  "~/dev/laclair/patrick-laclair-me"
  "~/dev/laclair/laclair-family-us"
  "~/dev/laclair/laclair-terminal"
  "~/dev/laclair/netcalc"
  "~/dev/laclair/xanban"
  "~/dev/laclair/ai-workspace"
)

for repo in "${REPOS[@]}"; do
  repo_path=$(eval echo "$repo")
  repo_name=$(basename "$repo_path")
  
  cd "$repo_path"
  
  # Count .md files at root (should be 1 - only README)
  root_md_count=$(ls -1 *.md 2>/dev/null | wc -l | tr -d ' ')
  
  # Check for .ai/ directory
  ai_files=$([ -d ".ai" ] && ls .ai/*.md 2>/dev/null | wc -l | tr -d ' ' || echo "0")
  
  # Check for docs/ directory
  docs_exists=$([ -d "docs" ] && echo "✓" || echo "✗")
  
  # Check for scripts/ subdirs
  scripts_subdirs=$([ -d "scripts/dev" ] && echo "✓" || echo "✗")
  
  if [ "$root_md_count" -le 2 ] && [ "$ai_files" -ge 3 ] && [ "$docs_exists" = "✓" ]; then
    echo "✅ $repo_name"
  else
    echo "⚠️  $repo_name (root:$root_md_count ai:$ai_files docs:$docs_exists scripts:$scripts_subdirs)"
  fi
done

echo ""
echo "✅ Validation complete!"
