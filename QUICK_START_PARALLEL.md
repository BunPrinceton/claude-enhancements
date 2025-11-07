# Quick Start: Parallel Claude Development

## 1. Setup GitHub CLI (First Time Only)
```bash
gh auth login
# Follow prompts: GitHub.com → HTTPS → Yes → Browser
```

## 2. Launch 4 Parallel Claudes

### Option A: Automatic Launcher (Easiest)
```bash
./start_parallel_claudes.sh ~/Documents/crafting-game
```

### Option B: Manual (4 separate terminals)
```bash
# Terminal 1 - Frontend
cd ~/Documents/crafting-game
git checkout -b feature/ui
claude code

# Terminal 2 - Backend
cd ~/Documents/crafting-game
git checkout -b feature/logic
claude code

# Terminal 3 - Assets
cd ~/Documents/crafting-game
git checkout -b feature/assets
claude code

# Terminal 4 - Testing
cd ~/Documents/crafting-game
git checkout -b feature/tests
claude code
```

## 3. Give Each Claude a Task

**Claude 1 (Terminal 1):**
> "Build the inventory UI component with drag-and-drop. Work in src/components/Inventory/"

**Claude 2 (Terminal 2):**
> "Build the inventory logic and state management. Work in src/game/inventory/"

**Claude 3 (Terminal 3):**
> "Generate 100 item icons using our AI art tools in ai-art-tools/"

**Claude 4 (Terminal 4):**
> "Write comprehensive tests for the inventory system in tests/"

## 4. Let Them Work (2-3 hours)

Each Claude works independently on their branch.

## 5. Merge Everything

```bash
cd ~/Documents/crafting-game
git checkout main
git pull origin main

# Merge all features
git merge feature/ui
git merge feature/logic
git merge feature/assets
git merge feature/tests

# Test
npm test
npm run build

# Push
git push origin main
```

## Result

**4 person-hours of work in 1 hour! 🚀**

---

## Tips

✅ **DO:**
- Keep each Claude focused on one area
- Use separate branches
- Give clear, specific tasks
- Pull latest main before merging

❌ **DON'T:**
- Have 2 Claudes edit the same file
- Work directly on main branch
- Merge without testing
- Mix tasks between Claudes

---

## Full Documentation

See `PARALLEL_CLAUDE_WORKFLOW.md` for complete details.

## Session Template

Use `PARALLEL_SESSION_TEMPLATE.md` to plan each session.
