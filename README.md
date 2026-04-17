# my-dev-toolkit

A personal Claude Code setup — slash commands, MCP servers, and project templates that make AI-assisted development faster and more consistent.

## What's Inside

| Component | Count | What It Does |
|-----------|-------|--------------|
| Slash Commands | 4 | One-command workflows (`/backlog`, `/claude-init`, `/mcp`, `/system-design`) |
| MCP Servers | 2 | External tool integrations (docs lookup, step-by-step reasoning) |

## Install

```bash
git clone https://github.com/kaiqkt/my-dev-toolkit.git ~/my-dev-toolkit
cd ~/my-dev-toolkit
chmod +x install.sh
./install.sh
```

To install MCP servers, open Claude Code and run:

```
/mcp
```

## Commands

| Command | Description |
|---------|-------------|
| `/backlog` | Create and manage tasks in a local backlog (`docs/backlog/`) |
| `/backlog list` | List all tasks across the backlog in a table |
| `/claude-init` | Generate a `CLAUDE.md` for any project |
| `/mcp` | Install MCP servers from `mcp/mcp.json` |
| `/mcp list` | List available MCP servers |
| `/system-design` | Guided system design workflow |

## MCP Servers

| Name | Package | Description |
|------|---------|-------------|
| `context7` | `@upstash/context7-mcp` | Library docs lookup — latest docs instead of stale training data |
| `sequential-thinking` | `@anthropic/sequential-thinking-mcp` | Step-by-step reasoning for system design and architecture |

## License

[MIT](LICENSE)
