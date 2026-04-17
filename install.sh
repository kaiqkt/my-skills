#!/usr/bin/env bash
set -euo pipefail

COMMANDS_SRC="$(cd "$(dirname "$0")/commands" && pwd)"
COMMANDS_DST="$HOME/.claude/commands"

echo "Installing my-dev-toolkit..."

# Install slash commands
mkdir -p "$COMMANDS_DST"
for file in "$COMMANDS_SRC"/*.md; do
  name="$(basename "$file")"
  cp "$file" "$COMMANDS_DST/$name"
  echo "  [commands] $name"
done

echo ""
echo "Done. Restart Claude Code to apply changes."
echo ""
echo "To install MCP servers, run: /mcp"
