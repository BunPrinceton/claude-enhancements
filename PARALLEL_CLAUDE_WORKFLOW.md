# Parallel Claude Instances Workflow
## Multi-Agent Development Strategy for Same Project

### 🎯 Goal
Run multiple Claude Code instances simultaneously, each working on different parts of the same project to maximize development speed and productivity.

---

## 1. GitHub CLI Setup (5 minutes)

### Authenticate GitHub CLI
```bash
# Login to GitHub
gh auth login

# Follow prompts:
# - GitHub.com
# - HTTPS
# - Yes (authenticate Git)
# - Login with browser (easiest)
```

### Verify Authentication
```bash
gh auth status
gh repo view BunPrinceton/crafting-game
```

---

## 2. Parallel Claude Architecture

### Strategy: Task Specialization
Each Claude instance focuses on a specific domain/task type:

```
┌─────────────────────────────────────────────────────────────┐
│                     CRAFTING GAME PROJECT                   │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Claude 1          Claude 2          Claude 3         Claude 4  │
│  Frontend UI       Backend Logic     AI Art Gen      Testing    │
│  ├─ Components     ├─ Game Engine    ├─ Assets       ├─ Unit   │
│  ├─ Styling        ├─ Inventory      ├─ Sprites      ├─ E2E    │
│  └─ UX/Polish      └─ Crafting       └─ Animation    └─ Debug  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 3. Setup Methods

### Method A: Multiple Terminal Windows (Recommended)
**Best for:** Task-focused parallel work

```bash
# Terminal 1: Frontend Development
cd ~/Documents/crafting-game
claude code
# Task: "Work on UI components and styling"

# Terminal 2: Backend Development (new terminal)
cd ~/Documents/crafting-game
claude code
# Task: "Work on game engine and crafting logic"

# Terminal 3: Asset Generation (new terminal)
cd ~/Documents/crafting-game
claude code
# Task: "Generate and optimize game assets"

# Terminal 4: Testing & QA (new terminal)
cd ~/Documents/crafting-game
claude code
# Task: "Write tests and fix bugs"
```

### Method B: Browser + CLI Hybrid
**Best for:** Mixed research and coding

```
Browser Tab 1: Claude.ai - High-level design/architecture
Browser Tab 2: Claude.ai - Documentation writing
Browser Tab 3: Claude.ai - Research & planning

Terminal 1: Claude Code - Implementation
Terminal 2: Claude Code - Testing
```

### Method C: Feature Branch Strategy
**Best for:** Large parallel features

```bash
# Claude 1: Main feature A
git checkout -b feature/inventory-system
claude code

# Claude 2: Main feature B (new terminal)
git checkout -b feature/combat-system
claude code

# Claude 3: Bug fixes (new terminal)
git checkout -b fix/rendering-bugs
claude code
```

---

## 4. Task Distribution Matrix

### Project Type: Crafting Game

| Claude Instance | Primary Focus | Tasks | Branch |
|----------------|---------------|-------|--------|
| **Claude 1** | Frontend UI | React components, styling, animations | `feature/ui-components` |
| **Claude 2** | Game Logic | Inventory, crafting recipes, game state | `feature/game-logic` |
| **Claude 3** | AI Assets | Image generation, asset pipeline, optimization | `feature/ai-assets` |
| **Claude 4** | Testing | Unit tests, E2E tests, bug fixes | `feature/testing` |

### Coordination Strategy
- Each instance works on **separate files** when possible
- Use **feature branches** for isolation
- **Merge to main** only when feature complete
- **Pull latest** before starting new work

---

## 5. Parallel Workflow Example

### Scenario: Building Inventory System + Art Assets

**Terminal 1 - Frontend Claude:**
```
You: "I need you to build the inventory UI component in React.
     Create a grid-based inventory with drag-and-drop support.
     Work in the src/components/Inventory/ directory."
```

**Terminal 2 - Backend Claude:**
```
You: "I need you to build the inventory logic system.
     Create data structures for items, inventory slots, and crafting.
     Work in the src/game/inventory/ directory."
```

**Terminal 3 - Asset Claude:**
```
You: "I need you to generate 100 inventory item icons using our AI art pipeline.
     Use the tools in ai-art-tools/ and organize by category."
```

**Terminal 4 - Testing Claude:**
```
You: "I need you to write comprehensive tests for the inventory system.
     Cover edge cases like full inventory, item stacking, invalid items."
```

### Timeline
- **All start simultaneously** at 9:00 AM
- **All complete independently** by 10:30 AM
- **Integration session** at 11:00 AM (you coordinate merges)

**Result:** 4 person-hours of work in 1.5 hours!

---

## 6. Git Workflow for Parallel Development

### Branch Strategy

```bash
main
├── feature/ui-components (Claude 1)
├── feature/game-logic (Claude 2)
├── feature/ai-assets (Claude 3)
└── feature/testing (Claude 4)
```

### Workflow Steps

**Initial Setup (Each Claude):**
```bash
# Start from latest main
git checkout main
git pull origin main

# Create feature branch
git checkout -b feature/your-feature-name

# Start Claude Code
claude code
```

**During Work:**
```bash
# Each Claude commits to their own branch
git add .
git commit -m "feat: added inventory grid component"
git push origin feature/ui-components
```

**Integration (You coordinate):**
```bash
# Merge feature branches sequentially
git checkout main

git merge feature/ui-components
git merge feature/game-logic
git merge feature/ai-assets
git merge feature/testing

git push origin main
```

---

## 7. Avoiding Merge Conflicts

### File Partitioning Strategy

**Assign clear boundaries:**
```
Claude 1 owns:
├── src/components/UI/
├── src/styles/
└── public/assets/ui/

Claude 2 owns:
├── src/game/engine/
├── src/game/inventory/
└── src/game/crafting/

Claude 3 owns:
├── ai-art-tools/
├── scripts/asset-pipeline/
└── assets/generated/

Claude 4 owns:
├── tests/
├── __tests__/
└── cypress/
```

**Shared files:** Only one Claude modifies at a time, or use separate sections

---

## 8. Communication Protocol

### Master Task Board (You maintain)
Create a simple markdown checklist:

```markdown
# Today's Parallel Tasks - Nov 6, 2025

## Claude 1 - Frontend UI
- [ ] Inventory grid component
- [ ] Drag-and-drop functionality
- [ ] Responsive styling

## Claude 2 - Game Logic
- [ ] Item data structures
- [ ] Inventory state management
- [ ] Crafting recipe system

## Claude 3 - AI Assets
- [ ] Generate 100 item icons
- [ ] Generate 50 material icons
- [ ] Optimize for web

## Claude 4 - Testing
- [ ] Inventory component tests
- [ ] Crafting logic tests
- [ ] Integration tests
```

### Update Pattern
- **You** create the task list
- **Each Claude** gets their section
- **You** check off completed tasks
- **You** coordinate integration

---

## 9. Advanced: Automated Coordination

### Option A: Shared Task File
Create `CURRENT_TASKS.md` that all Claudes can read:

```bash
# Each Claude checks this before starting
cat CURRENT_TASKS.md

# Format:
# IN_PROGRESS: [Claude 1] src/components/Inventory.tsx
# IN_PROGRESS: [Claude 2] src/game/inventory.ts
# COMPLETED: [Claude 3] ai-art-tools/generate_items.py
```

### Option B: GitHub Issues
Use `gh` CLI for coordination:

```bash
# Create issues for each task
gh issue create --title "Build inventory UI" --label "frontend" --assignee "Claude1"
gh issue create --title "Build inventory logic" --label "backend" --assignee "Claude2"

# Each Claude checks their assigned issues
gh issue list --assignee @me

# Close when done
gh issue close 42
```

---

## 10. Best Practices

### ✅ DO:
- **Give each Claude a clear, isolated scope**
- **Use feature branches religiously**
- **Pull latest main before starting new work**
- **Commit frequently with descriptive messages**
- **Test before merging to main**
- **Document which Claude is working on what**

### ❌ DON'T:
- Have two Claudes modify the same file simultaneously
- Merge to main without testing integration
- Work directly on main branch
- Mix tasks across Claude instances (keep specialized)
- Forget to pull latest changes
- Leave Claudes running on stale branches

---

## 11. Example Session Plan

### Morning Session (3 hours of parallel work)

**9:00 AM - Startup**
```bash
# Terminal 1
cd ~/Documents/crafting-game
git checkout -b feature/inventory-ui
claude code
# Prompt: "Build inventory UI grid component with drag-and-drop"

# Terminal 2
cd ~/Documents/crafting-game
git checkout -b feature/inventory-logic
claude code
# Prompt: "Build inventory data structures and state management"

# Terminal 3
cd ~/Documents/crafting-game
git checkout -b feature/item-icons
claude code
# Prompt: "Generate 100 game item icons using AI art pipeline"
```

**9:00-11:30 AM - Parallel Execution**
- All Claudes work independently
- You check in every 30 minutes
- Each commits to their branch

**11:30 AM - Integration**
```bash
# You coordinate the merge
git checkout main
git pull origin main

git merge feature/inventory-ui
git merge feature/inventory-logic
git merge feature/item-icons

# Test integration
npm test
npm run build

# Push to main
git push origin main

# Create PR if needed
gh pr create --title "Inventory system + item icons" --body "Complete inventory feature"
```

**Result:** 3 people worth of work done in 3 hours!

---

## 12. Monitoring & Control

### Check Claude Progress
```bash
# Terminal 1 status
ps aux | grep "claude code"

# Git activity per branch
git log --oneline feature/inventory-ui
git log --oneline feature/inventory-logic

# File changes
git diff main feature/inventory-ui --stat
```

### Terminate if Needed
```bash
# Stop a Claude instance
# Just Ctrl+C in the terminal

# Preserve work
git add .
git commit -m "WIP: saving progress"
git push origin feature/branch-name
```

---

## 13. Cost Optimization

### Parallel Instance Pricing
- Each Claude instance counts as separate API usage
- **Running 4 Claudes = 4x the cost**
- Use strategically for high-value parallel work

### When to Use Parallel:
✅ Large features with clear separation
✅ Tight deadlines
✅ Independent subsystems
✅ Research + implementation simultaneously

### When NOT to Use Parallel:
❌ Small quick tasks
❌ Highly interdependent code
❌ Unclear requirements
❌ Learning/exploration phase

---

## 14. Quick Start Commands

### Setup GitHub CLI (First Time)
```bash
gh auth login
gh auth status
```

### Start 4 Parallel Claudes
```bash
# Terminal 1
cd ~/Documents/crafting-game && git checkout -b feature/ui && claude code

# Terminal 2
cd ~/Documents/crafting-game && git checkout -b feature/logic && claude code

# Terminal 3
cd ~/Documents/crafting-game && git checkout -b feature/assets && claude code

# Terminal 4
cd ~/Documents/crafting-game && git checkout -b feature/tests && claude code
```

### Merge All Features
```bash
cd ~/Documents/crafting-game
git checkout main
git merge feature/ui
git merge feature/logic
git merge feature/assets
git merge feature/tests
git push origin main
```

---

## 15. Template: Daily Parallel Plan

Copy this template for each session:

```markdown
# Parallel Claude Session - [DATE]

## Session Goal
[What are we building today?]

## Claude 1 - [Specialty]
**Branch:** feature/[name]
**Tasks:**
- [ ] Task 1
- [ ] Task 2
**Files:** src/[directories]

## Claude 2 - [Specialty]
**Branch:** feature/[name]
**Tasks:**
- [ ] Task 1
- [ ] Task 2
**Files:** src/[directories]

## Claude 3 - [Specialty]
**Branch:** feature/[name]
**Tasks:**
- [ ] Task 1
- [ ] Task 2
**Files:** [directories]

## Claude 4 - [Specialty]
**Branch:** feature/[name]
**Tasks:**
- [ ] Task 1
- [ ] Task 2
**Files:** [directories]

## Integration Checklist
- [ ] All features complete
- [ ] No merge conflicts
- [ ] Tests passing
- [ ] Build successful
- [ ] Merged to main
- [ ] Pushed to remote
```

---

## 16. Success Metrics

Track your parallel efficiency:

```
Standard Development:
- 1 Claude × 4 hours = 4 hours of work

Parallel Development:
- 4 Claudes × 1 hour = 4 hours of work (in 1 hour!)
- Speedup: 4x
- Actual efficiency: ~3x (due to integration overhead)
```

**Expected Results:**
- 3-4x faster feature completion
- Better code quality (specialized focus)
- Faster iteration cycles
- More comprehensive testing

---

## 17. Next Steps

1. **Authenticate GitHub CLI:**
   ```bash
   gh auth login
   ```

2. **Create your first parallel plan** using the template above

3. **Test with 2 Claudes** on small independent tasks

4. **Scale to 4 Claudes** once comfortable

5. **Iterate and optimize** your workflow

---

## 🚀 Ready to Go Parallel!

Your parallel Claude workflow is now documented and ready to use. Start with 2 instances on clearly separated tasks, then scale up as you get comfortable with the coordination overhead.

**Remember:** The key to successful parallel development is **clear task boundaries** and **good git hygiene**!

---

*Created: November 6, 2025*
*For: crafting-game project*
*Strategy: Multi-agent parallel development*
