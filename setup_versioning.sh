#!/bin/bash

# Git Versioning Setup Script for Claude Code Projects
# Adds version control guides, tags, and README sections to repositories

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/templates"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() { echo -e "${BLUE}ℹ${NC} $1"; }
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }

# Function to setup versioning for a single repo
setup_repo() {
    local repo_path=$1
    local tag_version=${2:-"v0.1.0"}
    local tag_message=${3:-"Baseline: Initial version control setup"}

    if [ ! -d "$repo_path" ]; then
        print_error "Repository not found: $repo_path"
        return 1
    fi

    cd "$repo_path"

    if [ ! -d ".git" ]; then
        print_error "Not a git repository: $repo_path"
        return 1
    fi

    local repo_name=$(basename "$repo_path")
    print_info "Setting up $repo_name..."

    # 1. Add VERSION_CONTROL.md to .github/
    mkdir -p .github
    if [ ! -f ".github/VERSION_CONTROL.md" ]; then
        cp "$TEMPLATE_DIR/VERSION_CONTROL.md" .github/VERSION_CONTROL.md
        print_success "Added .github/VERSION_CONTROL.md"
    else
        print_warning ".github/VERSION_CONTROL.md already exists, skipping"
    fi

    # 2. Add Claude section to README if exists
    if [ -f "README.md" ]; then
        if ! grep -q "For Claude Code Instances" README.md; then
            cat "$TEMPLATE_DIR/claude_section.md" >> README.md
            print_success "Added Claude section to README.md"
        else
            print_warning "Claude section already in README.md, skipping"
        fi
    else
        print_warning "No README.md found, skipping"
    fi

    # 3. Create tag if doesn't exist
    if ! git rev-parse "$tag_version" >/dev/null 2>&1; then
        git tag -a "$tag_version" -m "$tag_message"
        print_success "Created tag: $tag_version"
    else
        print_warning "Tag $tag_version already exists, skipping"
    fi

    # 4. Commit changes
    if git diff --quiet && git diff --cached --quiet; then
        print_info "No changes to commit"
    else
        git add .github/VERSION_CONTROL.md README.md 2>/dev/null || true
        git commit -m "docs: Add version control guide for Claude instances

- Added .github/VERSION_CONTROL.md with comprehensive versioning guidelines
- Updated README.md with quick reference for Claude Code instances
- Establishes feature branch workflow and tagging strategy
- Enables easy rollback to working states

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
        print_success "Committed changes"
    fi

    # 5. Ask about pushing
    echo ""
    read -p "Push to remote? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        local branch=$(git branch --show-current)
        git push origin "$branch" --tags
        print_success "Pushed to origin/$branch with tags"
    else
        print_info "Skipped push. Run manually: git push origin $(git branch --show-current) --tags"
    fi

    echo ""
}

# Function to setup multiple repos
setup_multiple_repos() {
    local repo_dir=$1

    if [ ! -d "$repo_dir" ]; then
        print_error "Directory not found: $repo_dir"
        return 1
    fi

    print_info "Searching for git repositories in $repo_dir..."

    local count=0
    for dir in "$repo_dir"/*/ ; do
        if [ -d "$dir/.git" ]; then
            ((count++))
            echo ""
            echo "═══════════════════════════════════════════════════════════════"
            setup_repo "$dir" "v0.1.0" "Baseline: Version control setup"
            echo "═══════════════════════════════════════════════════════════════"
        fi
    done

    echo ""
    print_success "Setup complete for $count repositories"
}

# Function to audit versioning status
audit_repos() {
    local repo_dir=$1

    echo "═══════════════════════════════════════════════════════════════"
    echo "VERSIONING AUDIT"
    echo "═══════════════════════════════════════════════════════════════"
    printf "%-30s | %-8s | %-15s | %-10s\n" "Repository" "Tags" "Latest Tag" "Has Guide"
    echo "───────────────────────────────────────────────────────────────"

    for dir in "$repo_dir"/*/ ; do
        if [ -d "$dir/.git" ]; then
            cd "$dir"
            local name=$(basename "$dir")
            local tag_count=$(git tag | wc -l)
            local latest_tag=$(git describe --tags --abbrev=0 2>/dev/null || echo "None")
            local has_guide="No"
            [ -f ".github/VERSION_CONTROL.md" ] && has_guide="Yes"

            printf "%-30s | %-8s | %-15s | %-10s\n" "$name" "$tag_count" "$latest_tag" "$has_guide"
        fi
    done

    echo "═══════════════════════════════════════════════════════════════"
}

# Main script
show_help() {
    cat << EOF
Git Versioning Setup for Claude Code Projects

Usage:
  $0 <command> [options]

Commands:
  setup <repo-path> [tag] [message]   Setup versioning for single repo
  setup-all <directory>               Setup versioning for all repos in directory
  audit <directory>                   Audit versioning status of all repos

Examples:
  # Setup single repo
  $0 setup ~/Documents/my-project v0.1.0 "Initial setup"

  # Setup all repos in directory
  $0 setup-all ~/Documents

  # Audit all repos
  $0 audit ~/Documents

Templates:
  Templates are located in: $TEMPLATE_DIR
  - VERSION_CONTROL.md - Guide for .github/
  - claude_section.md  - Section for README.md

EOF
}

# Parse command
case "${1:-}" in
    setup)
        if [ -z "${2:-}" ]; then
            print_error "Repository path required"
            show_help
            exit 1
        fi
        setup_repo "$2" "${3:-v0.1.0}" "${4:-Baseline: Version control setup}"
        ;;
    setup-all)
        if [ -z "${2:-}" ]; then
            print_error "Directory path required"
            show_help
            exit 1
        fi
        setup_multiple_repos "$2"
        ;;
    audit)
        if [ -z "${2:-}" ]; then
            print_error "Directory path required"
            show_help
            exit 1
        fi
        audit_repos "$2"
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        print_error "Unknown command: ${1:-}"
        echo ""
        show_help
        exit 1
        ;;
esac
