
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

