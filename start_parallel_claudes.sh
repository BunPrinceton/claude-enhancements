#!/bin/bash
# Quick launcher for parallel Claude Code instances
# Usage: ./start_parallel_claudes.sh [project_dir]

PROJECT_DIR="${1:-$HOME/Documents/crafting-game}"
cd "$PROJECT_DIR" || exit 1

echo "=================================="
echo "PARALLEL CLAUDE LAUNCHER"
echo "=================================="
echo "Project: $PROJECT_DIR"
echo ""
echo "This will open 4 separate terminal windows with Claude Code"
echo "Each on a different feature branch for parallel development"
echo ""
echo "Press ENTER to continue, Ctrl+C to cancel..."
read -r

# Ensure we're on latest main
git checkout main
git pull origin main

# Define feature branches
BRANCHES=(
    "feature/ui-components"
    "feature/game-logic"
    "feature/ai-assets"
    "feature/testing"
)

PROMPTS=(
    "Frontend UI: Work on React components, styling, and user interface"
    "Backend Logic: Work on game engine, inventory, and crafting systems"
    "AI Assets: Work on asset generation, optimization, and pipeline tools"
    "Testing: Write tests, fix bugs, and ensure quality"
)

# Create branches if they don't exist
for branch in "${BRANCHES[@]}"; do
    git rev-parse --verify "$branch" >/dev/null 2>&1 || git checkout -b "$branch"
done

git checkout main

# Launch Terminal windows (macOS)
for i in {0..3}; do
    branch="${BRANCHES[$i]}"
    prompt="${PROMPTS[$i]}"

    echo "Opening Terminal $((i+1)): $branch"

    osascript <<EOF
tell application "Terminal"
    do script "cd '$PROJECT_DIR' && git checkout $branch && echo '\\n================================' && echo 'CLAUDE $((i+1)): $prompt' && echo '================================\\n' && echo 'Suggested prompt:' && echo '\"$prompt\"' && echo '' && claude code"
end tell
EOF

    sleep 2
done

echo ""
echo "✅ Launched 4 parallel Claude instances!"
echo ""
echo "Each Claude is on a separate branch:"
for i in {0..3}; do
    echo "  Terminal $((i+1)): ${BRANCHES[$i]}"
done
echo ""
echo "When done, merge with:"
echo "  git checkout main"
echo "  git merge feature/ui-components"
echo "  git merge feature/game-logic"
echo "  git merge feature/ai-assets"
echo "  git merge feature/testing"
echo "  git push origin main"
echo ""
