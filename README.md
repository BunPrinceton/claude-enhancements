# Claude Code Enhancements

**Productivity tools and workflows for Claude Code CLI**

This folder contains scripts, templates, and documentation to enhance your Claude Code development experience across all your projects.

---

## 📂 What's Inside

### 🚀 Parallel Development System
Run multiple Claude instances simultaneously on the same project for 3-4x faster development.

- **`PARALLEL_CLAUDE_WORKFLOW.md`** - Complete 17-section guide to parallel development
- **`QUICK_START_PARALLEL.md`** - Quick reference card
- **`PARALLEL_SESSION_TEMPLATE.md`** - Reusable session planner
- **`start_parallel_claudes.sh`** - Automated launcher for 4 parallel Claudes

### 🏷️ Version Control Setup
Establish proper versioning across all your repositories for easy rollback and better Claude coordination.

- **`VERSIONING_SETUP_GUIDE.md`** - Complete guide to version control setup
- **`setup_versioning.sh`** - Automated setup script for repos
- **`templates/VERSION_CONTROL.md`** - Template guide for Claude instances
- **`templates/claude_section.md`** - README section template

### 🔐 GitHub Integration
- **`GITHUB_AUTH_GUIDE.md`** - Complete GitHub CLI setup and authentication guide

---

## 🎯 Quick Start

### Launch Parallel Claudes
```bash
cd ~/Documents/claude-enhancements
./start_parallel_claudes.sh ~/Documents/your-project
```

### Setup Version Control for a Repo
```bash
cd ~/Documents/claude-enhancements
./setup_versioning.sh setup ~/Documents/your-project v0.1.0 "Initial setup"
```

### Setup Version Control for All Repos
```bash
./setup_versioning.sh setup-all ~/Documents
```

### Audit Versioning Status
```bash
./setup_versioning.sh audit ~/Documents
```

### Or Manually (4 terminals)
```bash
# Terminal 1
cd ~/Documents/your-project
git checkout -b feature/frontend
claude code

# Terminal 2
cd ~/Documents/your-project
git checkout -b feature/backend
claude code

# Terminal 3
cd ~/Documents/your-project
git checkout -b feature/testing
claude code

# Terminal 4
cd ~/Documents/your-project
git checkout -b feature/docs
claude code
```

---

## 📖 Documentation

### Read These First

1. **`QUICK_START_PARALLEL.md`** - 5-minute overview
2. **`PARALLEL_CLAUDE_WORKFLOW.md`** - Complete guide with examples
3. **`GITHUB_AUTH_GUIDE.md`** - Setup GitHub CLI integration

### Planning a Session

Use **`PARALLEL_SESSION_TEMPLATE.md`** to plan each parallel development session:
```bash
cp PARALLEL_SESSION_TEMPLATE.md ~/Documents/your-project/SESSION_$(date +%Y%m%d).md
# Edit with your tasks for today
```

---

## 🎓 How Parallel Development Works

### The Concept
Instead of one Claude working sequentially:
```
Claude 1: Task A (2h) → Task B (2h) → Task C (2h) → Task D (2h) = 8 hours
```

Run four Claudes in parallel:
```
Claude 1: Task A (2h) ┐
Claude 2: Task B (2h) ├─→ All done in 2 hours!
Claude 3: Task C (2h) │
Claude 4: Task D (2h) ┘
```

**Result: 3-4x faster development**

### Task Specialization

Each Claude focuses on a specific domain:

| Claude | Focus | Examples |
|--------|-------|----------|
| **1** | Frontend UI | Components, styling, UX |
| **2** | Backend Logic | APIs, database, business logic |
| **3** | Assets/Tools | Images, scripts, automation |
| **4** | Testing/QA | Unit tests, integration tests, bugs |

### Git Workflow

Each Claude works on a separate branch:
```
main
├── feature/ui-components (Claude 1)
├── feature/backend-api (Claude 2)
├── feature/asset-tools (Claude 3)
└── feature/testing (Claude 4)
```

After all complete, merge everything:
```bash
git checkout main
git merge feature/ui-components
git merge feature/backend-api
git merge feature/asset-tools
git merge feature/testing
```

---

## ⚙️ Setup Requirements

### GitHub CLI (Optional but Recommended)
```bash
# Already installed! Just authenticate:
sudo chown -R $USER ~/.config  # Fix permissions
gh auth login --with-token      # Paste your token
gh auth status                  # Verify
```

See `GITHUB_AUTH_GUIDE.md` for detailed instructions.

---

## 📋 Example Session

### Morning (3 hours parallel work)

**9:00 AM - Launch**
```bash
cd ~/Documents/crafting-game
../claude-enhancements/start_parallel_claudes.sh .
```

**Give Each Claude a Task:**
- Terminal 1: *"Build inventory UI with drag-and-drop"*
- Terminal 2: *"Implement inventory backend logic"*
- Terminal 3: *"Generate 100 item icons using AI tools"*
- Terminal 4: *"Write tests for inventory system"*

**9:00-11:30 AM - Work**
All Claudes work independently on their branches.

**11:30 AM - Integration**
```bash
git checkout main
git merge feature/ui-components
git merge feature/game-logic
git merge feature/ai-assets
git merge feature/testing
npm test && git push
```

**Result:** 12 person-hours of work completed in 3 hours!

---

## 🔧 Customization

### Modify Launcher Script

Edit `start_parallel_claudes.sh` to customize:
- Branch names
- Number of Claude instances (2-8)
- Default prompts
- GitHub integration

### Add More Templates

Create specialized templates:
```bash
cp PARALLEL_SESSION_TEMPLATE.md GAME_DEV_TEMPLATE.md
# Customize for game development tasks

cp PARALLEL_SESSION_TEMPLATE.md WEB_APP_TEMPLATE.md
# Customize for web app development
```

---

## 💡 Best Practices

### ✅ DO:
- Keep each Claude focused on one domain
- Use separate branches religiously
- Pull latest main before starting
- Test integration before pushing
- Document what each Claude is doing

### ❌ DON'T:
- Have two Claudes edit the same file
- Work directly on main branch
- Merge without testing
- Mix tasks between Claudes
- Forget to commit regularly

---

## 🎯 Use Cases

### Perfect For:
- ✅ Large features with clear separation
- ✅ Tight deadlines
- ✅ Independent subsystems
- ✅ Parallel research + implementation
- ✅ Multi-platform development
- ✅ Different programming languages

### Not Ideal For:
- ❌ Small quick tasks
- ❌ Highly interdependent code
- ❌ Unclear requirements
- ❌ Learning/exploration phase
- ❌ Single-file changes

---

## 📊 Performance Metrics

### Expected Results
- **Sequential**: 1 Claude × 8 hours = 8 hours of work
- **Parallel**: 4 Claudes × 2 hours = 8 hours of work in 2 hours
- **Speedup**: ~3x (accounting for integration overhead)
- **Actual Efficiency**: 75-80% (due to merge conflicts, coordination)

### Track Your Sessions
```bash
# Use the template to track:
- Start time
- End time
- Features completed
- Time saved vs sequential
- Issues encountered
```

---

## 🚀 Getting Started

1. **Read the quick start:**
   ```bash
   cat QUICK_START_PARALLEL.md
   ```

2. **Authenticate GitHub CLI:**
   ```bash
   cat GITHUB_AUTH_GUIDE.md
   ```

3. **Launch your first parallel session:**
   ```bash
   ./start_parallel_claudes.sh ~/Documents/your-project
   ```

4. **Track your progress:**
   ```bash
   cp PARALLEL_SESSION_TEMPLATE.md ~/Documents/your-project/SESSION_TODAY.md
   ```

---

## 🆘 Support

### Documentation
- Full workflow: `PARALLEL_CLAUDE_WORKFLOW.md`
- Quick reference: `QUICK_START_PARALLEL.md`
- GitHub setup: `GITHUB_AUTH_GUIDE.md`
- Session planning: `PARALLEL_SESSION_TEMPLATE.md`

### Common Issues

**Permission Denied (.config/gh):**
```bash
sudo chown -R $USER ~/.config
```

**Merge Conflicts:**
- Keep Claudes focused on separate files
- Use clear file partitioning strategy
- See workflow guide for details

**Claudes Working on Same Code:**
- Better task definition needed
- Review session planning template
- Assign specific directories to each Claude

---

## 📁 Folder Structure

```
~/Documents/claude-enhancements/
├── README.md                          # This file
├── PARALLEL_CLAUDE_WORKFLOW.md        # Complete guide (17 sections)
├── QUICK_START_PARALLEL.md            # Quick reference
├── PARALLEL_SESSION_TEMPLATE.md       # Reusable session planner
├── VERSIONING_SETUP_GUIDE.md          # Version control setup guide
├── GITHUB_AUTH_GUIDE.md               # GitHub CLI setup
├── start_parallel_claudes.sh          # Auto-launcher script
├── setup_versioning.sh                # Version control setup script
└── templates/
    ├── VERSION_CONTROL.md             # Template for .github/
    └── claude_section.md              # Template for README sections
```

---

## 🎓 Advanced Usage

### Custom Launcher
Create project-specific launchers:
```bash
cp start_parallel_claudes.sh ~/Documents/crafting-game/start_4_claudes.sh
# Edit with project-specific branches and prompts
```

### GitHub Issue Integration
```bash
# Create issues for each Claude task
gh issue create --title "[Claude 1] Frontend"
gh issue create --title "[Claude 2] Backend"
gh issue create --title "[Claude 3] Testing"
gh issue create --title "[Claude 4] Docs"
```

### Automated PR Creation
```bash
# After merging all branches
gh pr create --title "Parallel Session $(date +%Y-%m-%d)" \
             --body "Features: UI, Backend, Testing, Docs"
```

---

## 📝 Version History

- **v1.1** (Nov 9, 2025) - Version control system
  - Complete versioning setup guide
  - Automated setup script for all repos
  - Templates for VERSION_CONTROL.md
  - Auditing tools
  - Applied to 20 repositories (1.7/10 → 6-7/10 average score)

- **v1.0** (Nov 6, 2025) - Initial release
  - Parallel development workflow
  - GitHub CLI integration
  - Session planning templates
  - Auto-launcher script

---

## 🤝 Contributing

This is your personal toolkit! Customize freely:
- Add new templates
- Modify scripts
- Create project-specific versions
- Share improvements across your projects

---

## 📞 Quick Links

- **Claude Code Docs**: https://docs.claude.com/claude-code
- **GitHub CLI Docs**: https://cli.github.com/manual/
- **Git Branching**: https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging

---

**Ready to go 4x faster? Launch your first parallel session now!**

```bash
./start_parallel_claudes.sh ~/Documents/your-project
```

---

*Created: November 6, 2025*
*Location: ~/Documents/claude-enhancements/*
*Purpose: Enhance Claude Code productivity across all projects*

---

## For Claude Code Instances

**Version Control Guidelines:** See [`.github/VERSION_CONTROL.md`](.github/VERSION_CONTROL.md) for complete versioning guidelines.

### Quick Reference
- **New features**: Always create feature branch (`git checkout -b feature/name`)
- **Feature complete**: Tag working state (`git tag -a v0.X.0 -m "description"`)
- **Before risky changes**: Tag current state as backup
- **Rollback**: `git checkout <tag-name>` to return to working version

### Current Version
Check latest tag: `git describe --tags --abbrev=0`

