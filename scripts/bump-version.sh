#!/usr/bin/env bash
# Bump autonomic + autonomic-stack formula versions (local or CI).
set -euo pipefail

VERSION="${1:-}"
if [ -z "$VERSION" ]; then
  VERSION="$(gh release view --repo autonomic-ai-dev/agent-body --json tagName -q .tagName)"
fi
VERSION="${VERSION#v}"

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# Bump autonomic.rb
autonomic_file="$ROOT/Formula/autonomic.rb"
sed -i.bak -E "s/^  version \"[^\"]+\"/  version \"${VERSION}\"/" "$autonomic_file"
rm -f "${autonomic_file}.bak"
echo "Bumped Formula/autonomic.rb to ${VERSION}"

# Run update-formulas to verify and synchronize baseline
bash "$ROOT/scripts/update-formulas.sh"

