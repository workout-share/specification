#!/bin/bash
# Version bump script for workout-share projects with git-cliff integration
# Usage: ./bump-version.sh [spec|tools] [patch|minor|major] "feat: description" or "fix: description"

set -e

REPO_TYPE=$1
BUMP_TYPE=$2
COMMIT_MSG=$3

if [ $# -ne 3 ]; then
    echo "Usage: $0 [spec|tools] [patch|minor|major] \"conventional commit message\""
    echo "Examples:"
    echo "  $0 spec minor \"feat: add equipment level classification\""
    echo "  $0 tools patch \"fix: resolve QR code generation for large programs\""
    echo "  $0 spec major \"feat!: add required program_id field\""
    echo ""
    echo "Conventional commit types: feat, fix, docs, style, refactor, test, chore"
    exit 1
fi

# Get current version
if [ "$REPO_TYPE" = "spec" ]; then
    CURRENT_VERSION=$(cat VERSION)
    VERSION_FILE="VERSION"
    SCHEMA_FILE="schema/workout-share-schema.jsonc"
elif [ "$REPO_TYPE" = "tools" ]; then
    CURRENT_VERSION=$(grep "version = " pyproject.toml | cut -d '"' -f 2)
    VERSION_FILE="pyproject.toml"
else
    echo "Error: First argument must be 'spec' or 'tools'"
    exit 1
fi

echo "Current version: $CURRENT_VERSION"

# Calculate new version
IFS='.' read -ra VERSION_PARTS <<< "$CURRENT_VERSION"
MAJOR=${VERSION_PARTS[0]}
MINOR=${VERSION_PARTS[1]}
PATCH=${VERSION_PARTS[2]}

case $BUMP_TYPE in
    patch)
        PATCH=$((PATCH + 1))
        ;;
    minor)
        MINOR=$((MINOR + 1))
        PATCH=0
        ;;
    major)
        MAJOR=$((MAJOR + 1))
        MINOR=0
        PATCH=0
        ;;
    *)
        echo "Error: Bump type must be 'patch', 'minor', or 'major'"
        exit 1
        ;;
esac

NEW_VERSION="$MAJOR.$MINOR.$PATCH"
echo "New version: $NEW_VERSION"

# Update version files
if [ "$REPO_TYPE" = "spec" ]; then
    echo "$NEW_VERSION" > VERSION
    sed -i '' "s/Workout Share Schema v[0-9]\+\.[0-9]\+\.[0-9]\+/Workout Share Schema v$NEW_VERSION/" "$SCHEMA_FILE"
    
    # Regenerate JSON schema
    echo "Regenerating JSON schema..."
    cd ../tools
    uv run strip-comments.py "../specification/$SCHEMA_FILE" > "../specification/schema/workout-share-schema.json"
    cd ../specification
elif [ "$REPO_TYPE" = "tools" ]; then
    sed -i '' "s/version = \"[0-9]\+\.[0-9]\+\.[0-9]\+\"/version = \"$NEW_VERSION\"/" pyproject.toml
fi

# Commit changes with conventional commit format
git add -A
git commit -m "chore(release): bump version to v$NEW_VERSION"

# Add the feature/fix commit
git commit --amend -m "$COMMIT_MSG

Bump version to v$NEW_VERSION"

# Generate changelog using git-cliff
echo "Generating changelog..."
git-cliff --tag "v$NEW_VERSION" > CHANGELOG.md
git add CHANGELOG.md
git commit -m "docs: update changelog for v$NEW_VERSION"

# Create tag
echo "Creating git tag v$NEW_VERSION"
git tag -a "v$NEW_VERSION" -m "Version $NEW_VERSION

$COMMIT_MSG"

echo "✅ Version bumped to v$NEW_VERSION"
echo "📖 Changelog updated automatically"
echo "📌 Git tag v$NEW_VERSION created"
echo ""
echo "Next steps:"
echo "  git push origin main"
echo "  git push origin v$NEW_VERSION"
echo "  Create GitHub release from tag (changelog already generated)"