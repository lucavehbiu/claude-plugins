# Quick Start Guide

Get up and running with the Team Workspace Setup plugin in 5 minutes.

## For Team Members (Installing the Plugin)

### Step 1: Install (Choose One Method)

**Method A: From Git (Recommended)**
```bash
mkdir -p ~/.claude/plugins/marketplaces/my-team-plugins
cd ~/.claude/plugins/marketplaces/my-team-plugins
git clone https://github.com/YOUR-ORG/team-workspace-setup.git
```

**Method B: From Zip**
```bash
cd ~/.claude/plugins/marketplaces/my-team-plugins
unzip ~/Downloads/team-workspace-setup.zip
```

### Step 2: Verify Installation

```bash
bash ~/.claude/plugins/marketplaces/my-team-plugins/team-workspace-setup/scripts/verify-installation.sh
```

### Step 3: Configure MCP Servers

Edit: `~/Library/Application Support/Claude/claude_desktop_config.json`

```json
{
  "mcpServers": {
    "brave-search": {
      "command": "/opt/homebrew/bin/npx",
      "args": ["@modelcontextprotocol/server-brave-search"],
      "env": {
        "BRAVE_API_KEY": "GET_FROM_TEAM_1PASSWORD",
        "BRAVE_TIMEOUT": "30000"
      }
    },
    "postgres": {
      "command": "/opt/homebrew/bin/npx",
      "args": ["@modelcontextprotocol/server-postgres", "postgresql://data_admin:PASSWORD@localhost:5432/ig_data_admin"]
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/Users/YOUR_USERNAME/Documents/GitHub/"]
    },
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    }
  }
}
```

Replace:
- `GET_FROM_TEAM_1PASSWORD` with actual API key
- `PASSWORD` with database password
- `YOUR_USERNAME` with your username

### Step 4: Enable Plugin

Open Claude Code and run:
```
/plugins enable team-workspace-setup@my-team-plugins
```

### Step 5: Restart Claude Code

Close and reopen Claude Code.

### Step 6: Test

```
/context
```

You should see Claude ready to fetch documentation using Context7.

---

## For Plugin Maintainers (Sharing with Team)

### Quick Distribution

**Option 1: GitHub**
```bash
cd ~/.claude/plugins/marketplaces/my-team-plugins/team-workspace-setup
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/YOUR-ORG/team-workspace-setup.git
git push -u origin main
```

**Option 2: Create Zip**
```bash
bash ~/.claude/plugins/marketplaces/my-team-plugins/team-workspace-setup/scripts/package-plugin.sh
```

This creates a zip file in `~/Downloads/` ready to share.

### Update Plugin

```bash
cd ~/.claude/plugins/marketplaces/my-team-plugins/team-workspace-setup
# Make changes
git add .
git commit -m "Update: description"
# Update version in .claude-plugin/plugin.json
git tag v1.0.1
git push origin main --tags
```

---

## Available Commands

Once installed, you can use:

- **`/context`** - Fetch latest docs for project technologies
- **`/format`** - Format SQL queries
- **`/puppeter`** - Open browser for testing
- **`/serena`** - Check Serena MCP status

---

## Troubleshooting

**Commands not working?**
```bash
# Check if enabled
grep "team-workspace-setup" ~/.claude/settings.json

# Enable manually
/plugins enable team-workspace-setup@my-team-plugins
```

**MCP servers not connecting?**
```bash
# Check Node.js
node --version  # Should be v16+

# Check npx
which npx

# Install jq for status line
brew install jq
```

**Need help?**
- Read full docs: `README.md`
- Detailed setup: `SETUP.md`
- Contact: DevOps team or `#claude-code-users` Slack

---

## What's Included

✅ 4 custom commands (/context, /format, /puppeter, /serena)
✅ Audio notification when Claude stops
✅ Colorful status line showing user@host and path
✅ MCP server configurations
✅ Complete documentation
✅ Verification and packaging scripts

---

## Next Steps

1. ✅ Install and verify
2. ✅ Configure MCP servers
3. ✅ Test commands
4. 📖 Read `SETUP.md` for advanced configuration
5. 🚀 Share with team
6. 💬 Join `#claude-code-users` on Slack

---

**Version**: 1.0.0
**Last Updated**: 2026-02-05
**Support**: DevOps Team
