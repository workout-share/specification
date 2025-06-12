# Release Workflow

This project uses [git-cliff](https://git-cliff.org/) for automated changelog generation and version management.

## Making a Release

### 1. Make Changes with Conventional Commits

Use conventional commit format for all changes:

```bash
# New features (minor version bump)
git commit -m "feat: add equipment level classification"
git commit -m "feat(schema): add optional program difficulty field"

# Bug fixes (patch version bump)  
git commit -m "fix: correct validation pattern for rest periods"
git commit -m "fix(docs): fix typos in schema examples"

# Breaking changes (major version bump)
git commit -m "feat!: add required program_id field"
git commit -m "feat(schema)!: change reps field to be required"

# Other types
git commit -m "docs: update README with new examples"
git commit -m "refactor: simplify exercise validation logic"
git commit -m "chore: update dependencies"
```

### 2. Preview Next Version

Check what version git-cliff will assign:

```bash
# See the bumped version
git-cliff --bumped-version

# Preview the changelog
git-cliff --bump
```

### 3. Generate Release

Create changelog and tag:

```bash
# Generate changelog for next version
git-cliff --bump -o CHANGELOG.md

# Create git tag (git-cliff determines version automatically)
git tag -a "v$(git-cliff --bumped-version)" -m "Release v$(git-cliff --bumped-version)"
```

### 4. Push Release

```bash
# Push commits and tags
git push origin main
git push origin --tags

# Create GitHub release (optional - can be done via GitHub UI)
```

## Conventional Commit Types

- **feat**: New features → minor version bump
- **fix**: Bug fixes → patch version bump  
- **feat!** or **fix!**: Breaking changes → major version bump
- **docs**: Documentation changes
- **refactor**: Code refactoring
- **style**: Code formatting
- **test**: Testing changes
- **chore**: Maintenance tasks

## Version Bumping Rules

git-cliff automatically determines version bumps based on commits since last tag:

- **Patch** (0.1.0 → 0.1.1): Only fix commits
- **Minor** (0.1.0 → 0.2.0): Any feat commits
- **Major** (0.1.0 → 1.0.0): Any feat! or fix! commits

## Examples

```bash
# After committing "feat: add new field"
git-cliff --bumped-version    # → 0.2.0
git-cliff --bump -o CHANGELOG.md
git tag -a "v0.2.0" -m "Release v0.2.0"

# After committing "feat!: breaking change"  
git-cliff --bumped-version    # → 1.0.0
git-cliff --bump -o CHANGELOG.md
git tag -a "v1.0.0" -m "Release v1.0.0"
```
