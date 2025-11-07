# Parallel Claude Session - [DATE]

## Session Goal
[What are we building today? e.g., "Complete inventory system with UI, logic, assets, and tests"]

---

## Claude 1 - Frontend UI

**Branch:** `feature/ui-components`

**Focus:** React components, styling, user interface

**Tasks:**
- [ ] Create inventory grid component
- [ ] Add drag-and-drop functionality
- [ ] Implement responsive styling
- [ ] Polish animations and transitions

**Files to modify:**
- `src/components/Inventory/`
- `src/components/UI/`
- `src/styles/`

**Prompt:**
```
Work on the frontend UI for the crafting game.
Focus on building React components in src/components/.
Create an inventory grid with drag-and-drop support.
Make it responsive and polished with smooth animations.
```

---

## Claude 2 - Game Logic

**Branch:** `feature/game-logic`

**Focus:** Backend systems, game engine, data structures

**Tasks:**
- [ ] Design item data structures
- [ ] Implement inventory state management
- [ ] Create crafting recipe system
- [ ] Build item stacking logic

**Files to modify:**
- `src/game/engine/`
- `src/game/inventory/`
- `src/game/crafting/`
- `src/state/`

**Prompt:**
```
Work on the backend game logic for the crafting game.
Focus on inventory and crafting systems.
Create robust data structures for items, recipes, and inventory.
Implement state management for game logic.
```

---

## Claude 3 - AI Asset Generation

**Branch:** `feature/ai-assets`

**Focus:** Asset generation, image processing, pipelines

**Tasks:**
- [ ] Generate 100 inventory item icons
- [ ] Generate 50 crafting material icons
- [ ] Optimize images for web (resize, compress)
- [ ] Organize assets by category

**Files to modify:**
- `ai-art-tools/`
- `scripts/asset-pipeline/`
- `assets/generated/`

**Prompt:**
```
Work on AI asset generation for the crafting game.
Use the tools in ai-art-tools/ to generate game assets.
Generate 100 item icons and 50 material icons.
Optimize and organize them for use in the game.
```

---

## Claude 4 - Testing & Quality

**Branch:** `feature/testing`

**Focus:** Unit tests, integration tests, bug fixes

**Tasks:**
- [ ] Write inventory component tests
- [ ] Write crafting logic tests
- [ ] Create integration tests
- [ ] Fix any existing bugs

**Files to modify:**
- `tests/`
- `__tests__/`
- `src/**/*.test.ts`

**Prompt:**
```
Work on testing and quality assurance for the crafting game.
Write comprehensive tests for inventory and crafting systems.
Cover edge cases like full inventory, invalid items, etc.
Fix any bugs you find during testing.
```

---

## Timeline

- **9:00 AM** - Launch all 4 Claudes in parallel
- **9:00-11:30 AM** - Independent parallel work
- **11:30 AM** - Integration and merge
- **12:00 PM** - Testing and deployment

**Expected completion:** 11:30 AM (2.5 hours of parallel work)

---

## Integration Checklist

- [ ] All 4 feature branches complete
- [ ] Pull latest main before merge
- [ ] Merge feature/ui-components
- [ ] Merge feature/game-logic
- [ ] Merge feature/ai-assets
- [ ] Merge feature/testing
- [ ] Resolve any merge conflicts
- [ ] Run `npm test` - all tests pass
- [ ] Run `npm run build` - build succeeds
- [ ] Manual testing in browser
- [ ] Push to main
- [ ] Create PR if needed

---

## Commands to Run

### Launch Parallel Claudes
```bash
./start_parallel_claudes.sh ~/Documents/crafting-game
```

### Or Manual Launch (4 terminals)
```bash
# Terminal 1
cd ~/Documents/crafting-game && git checkout feature/ui-components && claude code

# Terminal 2
cd ~/Documents/crafting-game && git checkout feature/game-logic && claude code

# Terminal 3
cd ~/Documents/crafting-game && git checkout feature/ai-assets && claude code

# Terminal 4
cd ~/Documents/crafting-game && git checkout feature/testing && claude code
```

### Integration Commands
```bash
cd ~/Documents/crafting-game
git checkout main
git pull origin main

git merge feature/ui-components
git merge feature/game-logic
git merge feature/ai-assets
git merge feature/testing

npm test
npm run build

git push origin main
```

---

## Notes & Observations

**What worked well:**
-

**What didn't work:**
-

**Improvements for next time:**
-

**Time saved vs sequential:**
- Sequential estimate: [X] hours
- Parallel actual: [Y] hours
- Speedup: [X/Y]x faster

---

## Results

**Commits:**
- feature/ui-components: [commit hash]
- feature/game-logic: [commit hash]
- feature/ai-assets: [commit hash]
- feature/testing: [commit hash]

**Merged to main:** [commit hash]

**Features completed:**
- ✅ [Feature 1]
- ✅ [Feature 2]
- ✅ [Feature 3]
- ✅ [Feature 4]

---

*Template created: November 6, 2025*
*Use this template for each parallel development session*
