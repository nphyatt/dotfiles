#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$SCRIPT_DIR/skills"
SNIPPET="$SCRIPT_DIR/snippets/linear-workflow.md"

MARKER_START="<!-- BEGIN:linear-workflow -->"
MARKER_END="<!-- END:linear-workflow -->"

usage() {
  echo "Usage: install-linear-workflow.sh <project-path>"
  echo ""
  echo "Installs the Linear workflow into a project:"
  echo "  - Symlinks skills into <project>/.claude/skills/"
  echo "  - Inserts/updates workflow section in <project>/CLAUDE.md"
  echo ""
  echo "Re-running updates the CLAUDE.md section if the source changed."
  echo ""
  echo "Examples:"
  echo "  install-linear-workflow.sh ~/code/my-app"
  echo "  install-linear-workflow.sh ."
  exit 1
}

[[ $# -lt 1 ]] && usage

PROJECT="$(cd "$1" && pwd)"

if [[ ! -d "$PROJECT" ]]; then
  echo "Error: $PROJECT is not a directory"
  exit 1
fi

echo "Installing Linear workflow into $PROJECT"
echo ""

# --- Symlink skills ---
TARGET_SKILLS="$PROJECT/.claude/skills"
mkdir -p "$TARGET_SKILLS"

for skill in "$SKILLS_DIR"/linear-*.md; do
  name="$(basename "$skill")"
  target="$TARGET_SKILLS/$name"

  if [[ -L "$target" ]]; then
    existing="$(readlink "$target")"
    if [[ "$existing" == "$skill" ]]; then
      echo "  skip: $name (symlink up to date)"
    else
      ln -sf "$skill" "$target"
      echo "  updated: $name symlink"
    fi
  elif [[ -f "$target" ]]; then
    echo "  WARN: $name exists as a regular file — remove it manually to use symlink"
  else
    ln -s "$skill" "$target"
    echo "  linked: $name"
  fi
done

echo ""

# --- Insert or update CLAUDE.md snippet ---
CLAUDE_MD="$PROJECT/CLAUDE.md"
WRAPPED_SNIPPET="$(printf '%s\n' "$MARKER_START"; cat "$SNIPPET"; printf '\n%s' "$MARKER_END")"

if [[ -f "$CLAUDE_MD" ]] && grep -q "$MARKER_START" "$CLAUDE_MD"; then
  # Extract existing block and compare
  existing="$(sed -n "/$MARKER_START/,/$MARKER_END/p" "$CLAUDE_MD")"
  if [[ "$existing" == "$WRAPPED_SNIPPET" ]]; then
    echo "  skip: CLAUDE.md workflow section is up to date"
  else
    # Replace the block between markers (inclusive)
    # Use a temp file for portable sed behavior
    tmp="$(mktemp)"
    awk -v start="$MARKER_START" -v end="$MARKER_END" -v replacement="$WRAPPED_SNIPPET" '
      $0 == start { skip=1; print replacement; next }
      $0 == end { skip=0; next }
      !skip { print }
    ' "$CLAUDE_MD" > "$tmp"
    mv "$tmp" "$CLAUDE_MD"
    echo "  updated: CLAUDE.md workflow section"
  fi
else
  # Append with a blank line separator if file exists
  if [[ -f "$CLAUDE_MD" ]]; then
    echo "" >> "$CLAUDE_MD"
  fi
  echo "$WRAPPED_SNIPPET" >> "$CLAUDE_MD"
  echo "  added: CLAUDE.md workflow section"
fi

echo ""
echo "Done."
