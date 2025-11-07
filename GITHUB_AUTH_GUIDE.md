# GitHub CLI Authentication Guide

## Why GitHub CLI Authentication is Necessary

### For Parallel Claude Workflow

When running multiple Claude instances in parallel on the same project, you need GitHub CLI (`gh`) for:

1. **Branch Management**
   - Creating feature branches from command line
   - Checking branch status across multiple terminals
   - Managing pull requests programmatically

2. **Coordination Between Claudes**
   - Each Claude can check what others are working on via GitHub issues
   - Automated PR creation when features are complete
   - Conflict detection before merging

3. **Repository Information**
   - Quick access to repo details: `gh repo view`
   - Issue tracking: `gh issue list`
   - PR reviews: `gh pr status`

4. **Automation Scripts**
   - The `start_parallel_claudes.sh` script can integrate with GitHub
   - Automated checks for uncommitted work
   - Smart branch naming based on GitHub issues

### Optional But Powerful

**You can do parallel development WITHOUT gh auth**, but you'll miss:
- Automated PR creation
- Issue-based task assignment
- GitHub integration features
- Some convenience commands

**Basic git commands still work fine without gh auth:**
- `git checkout -b feature/name`
- `git commit -m "message"`
- `git push origin branch`

---

## ⚠️ IMPORTANT: Fix Permissions First (Mac Users)

**Before authenticating, you likely need to fix a permission issue!**

### The Problem
GitHub CLI tries to create `~/.config/gh/` but on Mac this directory is often owned by `root`.

### The Fix (Do This First!)
```bash
sudo chown -R $USER ~/.config
```

**Enter your Mac password when prompted.**

This fixes the ownership so `gh` can write its config files.

### Verify It Worked
```bash
ls -la ~/.config/
```

You should see your username (not `root`) as the owner.

---

## How to Authenticate with Personal Access Token

### Step 1: You Already Have a Token ✅

If you have a GitHub Personal Access Token (PAT), skip to Step 3.

### Step 2: Generate Token (If Needed)

1. Go to: https://github.com/settings/tokens
2. Click "Generate new token" → "Generate new token (classic)"
3. Give it a name: `gh-cli-token`
4. Set expiration: 90 days (or your preference)
5. **Select scopes:**
   - ✅ `repo` (all repo access)
   - ✅ `workflow` (if using GitHub Actions)
   - ✅ `read:org` (for organization repos)
6. Click "Generate token"
7. **COPY THE TOKEN IMMEDIATELY** (you won't see it again!)

### Step 3: Authenticate with Your Token

**⚠️ SECURITY WARNING: Never paste tokens in chat conversations or commit them to git!**

**Option A: Interactive (Recommended - Most Secure)**
```bash
gh auth login --with-token
# Paste your token (no quotes!)
# Press Ctrl+D to finish
```

**Option B: One-line (Quick)**
```bash
echo "YOUR_TOKEN_HERE" | gh auth login --with-token
```

**Option C: Environment variable (Best for scripts)**
```bash
export GH_TOKEN="YOUR_TOKEN_HERE"
echo "$GH_TOKEN" | gh auth login --with-token
unset GH_TOKEN
```

**If you get "permission denied":**
- You forgot to run `sudo chown -R $USER ~/.config` first!
- Go back to the "Fix Permissions First" section above

### Step 4: Verify Authentication

```bash
gh auth status
```

Expected output:
```
github.com
  ✓ Logged in to github.com as YourUsername (oauth_token)
  ✓ Git operations for github.com configured to use https protocol.
  ✓ Token: *******************
```

---

## ⚠️ NEVER Paste Tokens in Chat!

**DO NOT paste your token in this conversation or any chat!**

Tokens pasted in conversations can be:
- ❌ Stored in conversation history
- ❌ Potentially exposed if conversations are shared
- ❌ Compromised if someone gains access to your chat history

**Always authenticate in your terminal, not in chat!**

If you accidentally paste a token in chat:
1. **Immediately revoke it** at https://github.com/settings/tokens
2. Generate a new token
3. Authenticate with the new token in your terminal

---

## Troubleshooting: Permission Denied Error

### The Problem

```
mkdir /Users/bds2/.config/gh: permission denied
```

This happens because `~/.config/` is owned by `root` instead of your user.

### The Fix

**Option 1: Fix ownership (Recommended)**
```bash
# Run in your terminal (will ask for password)
sudo chown -R $USER ~/.config
```

**Option 2: Use token auth (Workaround)**
```bash
# Token auth doesn't need the config directory
echo "YOUR_TOKEN" | gh auth login --with-token
```

**Option 3: Change GH config location**
```bash
# Use a different config directory
export GH_CONFIG_DIR="$HOME/.gh-config"
mkdir -p "$GH_CONFIG_DIR"
gh auth login
```

---

## What Happens After Authentication?

Once authenticated, you can:

### 1. View Your Repos
```bash
gh repo list
gh repo view BunPrinceton/crafting-game
```

### 2. Manage Pull Requests
```bash
# Create PR
gh pr create --title "Feature XYZ" --body "Description"

# List PRs
gh pr list

# Check PR status
gh pr status
```

### 3. Manage Issues
```bash
# Create issue
gh issue create --title "Task for Claude 1" --assignee BunPrinceton

# List issues
gh issue list

# Close issue
gh issue close 42
```

### 4. Clone Repos Easily
```bash
gh repo clone BunPrinceton/crafting-game
```

### 5. Use in Automation
```bash
# Check auth before running scripts
if gh auth status > /dev/null 2>&1; then
    echo "Authenticated!"
    gh pr create --title "Auto PR"
else
    echo "Not authenticated, skipping PR creation"
fi
```

---

## For Parallel Claude Workflow

After authentication, you can enhance your parallel workflow:

### Enhanced start_parallel_claudes.sh

```bash
#!/bin/bash
# Can now integrate GitHub features

# Check if authenticated
if ! gh auth status > /dev/null 2>&1; then
    echo "⚠️  Not authenticated with GitHub"
    echo "Run: gh auth login"
    exit 1
fi

# Create GitHub issue for each Claude task
gh issue create --title "[Claude 1] Frontend UI" --label "frontend"
gh issue create --title "[Claude 2] Backend Logic" --label "backend"
gh issue create --title "[Claude 3] AI Assets" --label "assets"
gh issue create --title "[Claude 4] Testing" --label "testing"

# Launch Claudes (rest of script)...
```

### Auto PR Creation

After merging all branches:
```bash
# Merge all features
git merge feature/ui-components
git merge feature/game-logic
git merge feature/ai-assets
git merge feature/testing

# Auto-create PR with all changes
gh pr create --title "Parallel Session $(date +%Y-%m-%d)" \
             --body "Completed 4 parallel tasks:\n- UI\n- Logic\n- Assets\n- Testing"
```

---

## Quick Commands Reference

```bash
# Authentication
gh auth login                      # Interactive login
gh auth login --with-token         # Token login
gh auth status                     # Check status
gh auth logout                     # Logout

# Repository
gh repo view                       # View current repo
gh repo list                       # List your repos
gh repo clone owner/repo           # Clone repo

# Pull Requests
gh pr create                       # Create PR
gh pr list                         # List PRs
gh pr view 123                     # View PR #123
gh pr merge 123                    # Merge PR #123

# Issues
gh issue create                    # Create issue
gh issue list                      # List issues
gh issue view 42                   # View issue #42
gh issue close 42                  # Close issue #42

# Workflows (GitHub Actions)
gh workflow list                   # List workflows
gh workflow run workflow.yml       # Trigger workflow
gh run list                        # List workflow runs
```

---

## Security Best Practices

### DO:
✅ Use tokens with minimal necessary scopes
✅ Set token expiration dates
✅ Delete tokens from files after use
✅ Use environment variables for automation
✅ Revoke unused tokens regularly

### DON'T:
❌ Commit tokens to git
❌ Share tokens in chat/email
❌ Use tokens with full admin access
❌ Set tokens to never expire
❌ Leave token files in /tmp

---

## Quick Start Summary

**Complete authentication workflow:**

1. **Fix permissions first:**
   ```bash
   sudo chown -R $USER ~/.config
   ```

2. **Generate token at:** https://github.com/settings/tokens
   - Check: `repo`, `workflow`, `read:org`

3. **Authenticate in your terminal (NOT in chat!):**
   ```bash
   gh auth login --with-token
   # Paste token, press Ctrl+D
   ```

4. **Verify:**
   ```bash
   gh auth status
   ```

**That's it! You're ready for parallel Claude development!**

---

*Created: November 6, 2025*
*For: crafting-game parallel development workflow*
