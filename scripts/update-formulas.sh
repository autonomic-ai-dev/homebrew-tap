#!/usr/bin/env bash
# Update Homebrew tap formulas with the latest release tags and SHA256 digests.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

REPOS=(
  "agent-brain:agent-brain"
  "agent-spine:agent-spine"
)

changed=0

for item in "${REPOS[@]}"; do
  IFS=: read -r repo formula_name <<< "$item"
  formula_file="${ROOT_DIR}/Formula/${formula_name}.rb"

  if [[ ! -f "$formula_file" ]]; then
    echo "Warning: formula file ${formula_file} not found; skipping." >&2
    continue
  fi

  echo "==> Checking ${repo} (Formula/${formula_name}.rb)..."

  # Find latest release tag (including pre-releases)
  latest_tag="$(gh release list -R "autonomic-ai-dev/${repo}" --limit 1 --json tagName -q '.[0].tagName' 2>/dev/null || true)"
  if [[ -z "$latest_tag" ]]; then
    echo "    Could not find latest tag for ${repo}; skipping." >&2
    continue
  fi

  version="${latest_tag#v}"
  asset_name="${repo}-aarch64-apple-darwin"

  # Find sha256 digest
  sha256="$(gh release view "$latest_tag" -R "autonomic-ai-dev/${repo}" --json assets -q ".assets[] | select(.name == \"${asset_name}\") | .digest" 2>/dev/null || true)"
  if [[ -n "$sha256" && "$sha256" == sha256:* ]]; then
    sha256="${sha256#sha256:}"
  fi

  # Fallback to computing sha256 if not present in release API
  if [[ -z "$sha256" ]]; then
    url="https://github.com/autonomic-ai-dev/${repo}/releases/download/${latest_tag}/${asset_name}"
    tmp_asset="/tmp/${asset_name}-$$-download"
    if curl -fsSL "$url" -o "$tmp_asset" 2>/dev/null; then
      sha256="$(shasum -a 256 "$tmp_asset" | awk '{print $1}')"
      rm -f "$tmp_asset"
    fi
  fi

  if [[ -z "$sha256" ]]; then
    echo "    Could not resolve sha256 for ${repo} ${latest_tag}; skipping." >&2
    continue
  fi

  current_version="$(grep -m1 'version "' "$formula_file" | sed -E 's/.*version "([^"]+)".*/\1/' || true)"
  current_sha="$(grep -m1 'sha256 "' "$formula_file" | sed -E 's/.*sha256 "([^"]+)".*/\1/' || true)"

  if [[ "$current_version" != "$version" || "$current_sha" != "$sha256" ]]; then
    echo "    Updating ${formula_name}: ${current_version} -> ${version}"
    sed -i.bak -E "s/^  version \"[^\"]+\"/  version \"${version}\"/" "$formula_file"
    sed -i.bak -E "s/download\/v[^\/]+\//download\/${latest_tag}\//" "$formula_file"
    sed -i.bak -E "s/^    sha256 \"[^\"]+\"/    sha256 \"${sha256}\"/" "$formula_file"
    rm -f "${formula_file}.bak"
    changed=1
  else
    echo "    Up to date (${version})"
  fi

done


if [[ "$changed" -eq 1 ]]; then
  echo "CHANGES_MADE=true" >> "${GITHUB_OUTPUT:-/dev/null}"
else
  echo "CHANGES_MADE=false" >> "${GITHUB_OUTPUT:-/dev/null}"
fi
