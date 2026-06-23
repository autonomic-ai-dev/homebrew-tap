#!/usr/bin/env bash
# Bump autonomic + autonomic-stack formula versions (local or CI).
set -euo pipefail

VERSION="${1:-}"
if [ -z "$VERSION" ]; then
  VERSION="$(gh release view --repo autonomic-ai-dev/agent-body --json tagName -q .tagName)"
fi
VERSION="${VERSION#v}"

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
for f in "$ROOT/Formula/autonomic.rb" "$ROOT/Formula/autonomic-stack.rb"; do
  sed -i.bak -E "s/^  version \"[^\"]+\"/  version \"${VERSION}\"/" "$f"
  rm -f "${f}.bak"
done
echo "Bumped formulas to ${VERSION}"
