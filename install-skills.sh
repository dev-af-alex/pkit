#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$ROOT_DIR/.codex/prompts"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
DEST_ROOT="$CODEX_HOME/skills"

if [[ ! -d "$SRC_DIR" ]]; then
  echo "Source directory not found: $SRC_DIR" >&2
  exit 1
fi

mkdir -p "$DEST_ROOT"

count=0
for prompt in "$SRC_DIR"/*.md; do
  [[ -e "$prompt" ]] || continue
  name="$(basename "$prompt" .md)"
  dest_dir="$DEST_ROOT/$name"
  mkdir -p "$dest_dir"

  # Extract description from YAML frontmatter if present.
  description=""
  if head -n 1 "$prompt" | grep -q '^---'; then
    description="$(
      awk '
        BEGIN { in_fm=0 }
        NR==1 && $0 ~ /^---/ { in_fm=1; next }
        in_fm && $0 ~ /^---/ { exit }
        in_fm && $0 ~ /^description:[[:space:]]*/ {
          sub(/^description:[[:space:]]*/, "", $0)
          print $0
          exit
        }
      ' "$prompt"
    )"
  fi
  if [[ -z "$description" ]]; then
    description="Imported from $(basename "$prompt")"
  fi

  {
    echo "---"
    echo "name: $name"
    echo "description: $description"
    echo "---"
    echo
    echo "# Imported Prompt"
    echo
    cat "$prompt"
    echo
  } > "$dest_dir/SKILL.md"

  count=$((count + 1))
done

echo "Installed $count skills into $DEST_ROOT"
echo "Restart your AI Assistant/IDE to pick up new skills."
