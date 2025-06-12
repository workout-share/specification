# Task Commands

Quick reference for common development tasks using [go-task](https://taskfile.dev/).

## Setup

```bash
task setup    # Install dependencies and pre-commit hooks
```

## Development Workflow

### Make Changes with Enforced Conventional Commits

```bash
# Add new features
task feat -- "add equipment level classification"
task feat -- "add optional program difficulty field"

# Fix bugs
task fix -- "correct validation pattern for rest periods"
task fix -- "resolve QR generation for large files"

# Update documentation
task docs -- "update schema examples"
task docs -- "add usage guide"

# Maintenance
task chore -- "update dependencies"
task chore -- "clean up old files"
```

### Check Release Status

```bash
task check-version        # Show next version (0.2.0)
task preview-changelog    # Preview changelog entries
```

### Schema Operations (Specification Repo)

```bash
task validate-schema      # Validate JSONC syntax
task regenerate-schema    # Update JSON from JSONC
```

### Testing (Tools Repo)

```bash
task test                 # Run all tests
task test-validator       # Test validator only
task validate -- file.yaml    # Validate specific file
task qr -- file.yaml          # Generate QR code
```

## Release Process

```bash
task prepare-release      # Test + update versions
task release              # Create changelog + git tag
```

Then push:
```bash
git push origin main
git push origin --tags
```

## Pre-commit Hooks

Automatically enforces:
- ✅ Conventional commit messages (feat:, fix:, docs:, etc.)
- ✅ Code formatting (whitespace, end-of-files)
- ✅ YAML/JSON validation
- ✅ Schema regeneration (when JSONC changes)
- ✅ Tool testing (when Python files change)

## Available Tasks

Run `task --list` to see all available tasks with descriptions.
