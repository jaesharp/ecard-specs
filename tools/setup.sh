#!/usr/bin/env bash
# Install npm dependencies and configure git hooks for ecard-specs.
# Run from any directory within the repository.

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

echo "Installing npm dependencies..."
npm --prefix tools install

echo "Configuring git hooks path..."
git config core.hooksPath .githooks

echo "Done. Formatting check will run on git push."
echo "  To format:  npm --prefix tools run format"
echo "  To check:   npm --prefix tools test"
