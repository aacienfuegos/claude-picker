#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="${HOME}/.local/bin"
SHELL_RC="${HOME}/.zshrc"

# ── binary ────────────────────────────────────────────────────────────────────

mkdir -p "$BIN_DIR"
cp "$SCRIPT_DIR/claude-picker" "$BIN_DIR/claude-picker"
chmod +x "$BIN_DIR/claude-picker"
echo "✓ claude-picker installed to $BIN_DIR"

# Ensure BIN_DIR is in PATH
if [[ ":${PATH}:" != *":${BIN_DIR}:"* ]]; then
  echo "" >> "$SHELL_RC"
  echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$SHELL_RC"
  echo "✓ Added $BIN_DIR to PATH in $SHELL_RC"
fi

# ── shell wrapper ─────────────────────────────────────────────────────────────

if grep -q "claude-picker" "$SHELL_RC" 2>/dev/null; then
  echo "⚠ Shell wrapper already present in $SHELL_RC — skipping"
else
  {
    echo ""
    echo "# claude-picker"
    cat "$SCRIPT_DIR/shell/claude.zsh"
  } >> "$SHELL_RC"
  echo "✓ Shell wrapper added to $SHELL_RC"
fi

echo ""
echo "Done. Run:  source $SHELL_RC"
