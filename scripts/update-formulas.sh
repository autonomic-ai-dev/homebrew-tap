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

echo "==> Determining ecosystem baseline and stack version across all organ formulas..."
stack_file="${ROOT_DIR}/Formula/autonomic-stack.rb"
current_stack_version="$(grep -m1 'version "' "$stack_file" | sed -E 's/.*version "([^"]+)".*/\1/' || true)"

read -r ecosystem_baseline target_stack_version < <(python3 -c '
import os, sys, re

formulas = [
    "agent-brain.rb",
    "agent-spine.rb"
]

formula_dir = sys.argv[1]

def parse_baseline(v):
    m = re.match(r"^(\d+)\.(\d+)\.(\d+)(?:-([a-zA-Z0-9]+)\.(\d+))?", v)
    if not m:
        return (0, 0, 0, 1, "", 0)
    major, minor, patch, pre_tag, pre_num = m.groups()
    is_release = 1 if not pre_tag else 0
    return (int(major), int(minor), int(patch), is_release, pre_tag or "", int(pre_num or 0))

def get_baseline_str(v):
    m = re.match(r"^(\d+\.\d+\.\d+(?:-[a-zA-Z0-9]+\.\d+)?)", v)
    return m.group(1) if m else v

organ_versions = []
baselines = []
for f_name in formulas:
    path = os.path.join(formula_dir, f_name)
    if not os.path.exists(path):
        continue
    with open(path, "r") as f:
        content = f.read()
    m = re.search(r"version \"([^\"]+)\"", content)
    if m:
        ver = m.group(1)
        base = get_baseline_str(ver)
        organ_versions.append(ver)
        baselines.append((base, parse_baseline(base)))

if not baselines:
    sys.exit(1)

min_base = min(baselines, key=lambda x: x[1])[0]

max_patch = 0
for v in organ_versions:
    if v.startswith(min_base + "."):
        patch_suffix = v[len(min_base) + 1:]
        try:
            p_num = int(patch_suffix)
            if p_num > max_patch:
                max_patch = p_num
        except ValueError:
            pass

if max_patch > 0:
    stack_version = f"{min_base}.{max_patch}"
else:
    stack_version = min_base

print(f"{min_base} {stack_version}")
' "${ROOT_DIR}/Formula")

echo "    Current autonomic-stack version: ${current_stack_version}"
echo "    Ecosystem baseline:              ${ecosystem_baseline}"
echo "    Target autonomic-stack version:  ${target_stack_version}"

if [[ "$current_stack_version" != "$target_stack_version" ]]; then
  echo "==> Updating autonomic-stack.rb to ${target_stack_version}..."
  stack_tag="v${ecosystem_baseline}"
  stack_asset="agent-body-aarch64-apple-darwin"
  stack_sha="$(gh release view "$stack_tag" -R "autonomic-ai-dev/agent-body" --json assets -q ".assets[] | select(.name == \"${stack_asset}\") | .digest" 2>/dev/null || true)"
  if [[ -n "$stack_sha" && "$stack_sha" == sha256:* ]]; then
    stack_sha="${stack_sha#sha256:}"
  fi
  if [[ -z "$stack_sha" ]]; then
    url="https://github.com/autonomic-ai-dev/agent-body/releases/download/${stack_tag}/${stack_asset}"
    tmp_asset="/tmp/${stack_asset}-$$-download"
    if curl -fsSL "$url" -o "$tmp_asset" 2>/dev/null; then
      stack_sha="$(shasum -a 256 "$tmp_asset" | awk '{print $1}')"
      rm -f "$tmp_asset"
    fi
  fi
  if [[ -n "$stack_sha" ]]; then
    sed -i.bak -E "s/^  version \"[^\"]+\"/  version \"${target_stack_version}\"/" "$stack_file"
    sed -i.bak -E "s/download\/v[^\/]+\//download\/${stack_tag}\//" "$stack_file"
    sed -i.bak -E "s/^  sha256 \"[^\"]+\"/  sha256 \"${stack_sha}\"/" "$stack_file"
    rm -f "${stack_file}.bak"
    echo "    Updated autonomic-stack to ${target_stack_version} (payload ${stack_tag}, ${stack_sha})"
    changed=1
  else
    echo "    Warning: Could not resolve sha256 for agent-body ${stack_tag}; skipping autonomic-stack bump." >&2
  fi
else
  echo "    autonomic-stack is up to date (${target_stack_version})"
fi

if [[ "$changed" -eq 1 ]]; then
  echo "CHANGES_MADE=true" >> "${GITHUB_OUTPUT:-/dev/null}"
else
  echo "CHANGES_MADE=false" >> "${GITHUB_OUTPUT:-/dev/null}"
fi
