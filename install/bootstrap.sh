#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "usage: $0 /path/to/project" >&2
  exit 1
fi

target="$1"
repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ ! -d "$target" ]; then
  echo "target not found: $target" >&2
  exit 1
fi

copy() {
  local src="$repo/$1"
  local dst="$target/$2"
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
  echo "copied $2"
}

copy copilot/copilot-instructions.md .github/copilot-instructions.md
copy copilot/instructions/memory-bank.instructions.md .github/instructions/memory-bank.instructions.md
copy copilot/prompts/mb-prune.prompt.md .github/prompts/mb-prune.prompt.md

if [ -d "$target/memory-bank" ]; then
  echo "memory-bank/ already exists, left untouched"
else
  cp -r "$repo/template" "$target/memory-bank"
  echo "created memory-bank/ with seven skeleton files"
fi

echo
echo "Done. Next:"
echo "  1. Fill in memory-bank/summary.md"
echo "  2. Add user/global-tone.md at user scope if you want the voice rules"
echo "  3. Start a new chat and confirm the agent reads summary.md first"
