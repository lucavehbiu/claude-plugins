# Team Workspace Setup Guide

Quick setup guide for team members.

## Prerequisites

- Claude Code installed
- Node.js and npm installed
- Homebrew (macOS) or equivalent package manager
- `jq` installed: `brew install jq`

## Quick Start

### Step 1: Install the Plugin

**Option A: From Git Repository**
```bash
cd ~/.claude/plugins/marketplaces/my-team-plugins/
git clone https://github.com/your-org/team-workspace-setup.git
```

**Option B: From Zip File**
```bash
cd ~/.claude/plugins/marketplaces/my-team-plugins/
unzip team-workspace-setup.zip
```

### Step 2: Configure MCP Servers

Edit your MCP configuration file:
```bash
code ~/Library/Application\ Support/Claude/claude_desktop_config.json
```

Add the following configuration (update credentials as needed):

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
      "args": [
        "@modelcontextprotocol/server-postgres",
        "postgresql://data_admin:GET_FROM_TEAM_1PASSWORD@localhost:5432/ig_data_admin"
      ]
    },
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/Users/YOUR_USERNAME/Documents/GitHub/"
      ]
    },
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    }
  },
  "preferences": {
    "menuBarEnabled": true
  }
}
```

### Step 3: Get Required Credentials

Retrieve from team 1Password vault:
- **Brave API Key**: `brave-search-api-key`
- **PostgreSQL Password**: `postgres-data-admin`

Or contact DevOps team for access.

### Step 4: Enable Recommended Plugins

Open Claude Code and run:

```
/plugins enable serena@claude-plugins-official
/plugins enable commit-commands@claude-code-plugins
/plugins enable pr-review-toolkit@claude-code-plugins
/plugins enable feature-dev@claude-code-plugins
/plugins enable frontend-design@claude-code-plugins
/plugins enable python-development@claude-code-workflows
```

### Step 5: Enable Team Workspace Plugin

```
/plugins enable team-workspace-setup@my-team-plugins
```

### Step 6: Restart Claude Code

Close and reopen Claude Code to apply all settings.

## Verification

Test each component:

### 1. Test Commands

```
/context
```
Should recognize and offer to fetch docs.

```
/format
```
Should be ready to format SQL.

```
/serena
```
Should check for Serena MCP.

### 2. Test Status Line

Check bottom of Claude Code - should show:
```
username@hostname ~/path/to/dir [Model Name]
```
in colors.

### 3. Test MCP Servers

```
Can you search the web for "Claude Code documentation"?
```
Should use Brave Search.

```
Can you query the database for table names?
```
Should use PostgreSQL.

### 4. Test Audio Notification

Start any task and let Claude finish - should hear Glass sound.

## Common Setup Issues

### Issue: Commands not found
**Solution**: Ensure plugin is enabled and restart Claude Code.

### Issue: MCP servers not connecting
**Solution**:
1. Check `npx` is available: `which npx`
2. Verify credentials in config file
3. Check Claude Desktop logs

### Issue: Status line not colored
**Solution**:
1. Install `jq`: `brew install jq`
2. Verify terminal supports colors
3. Restart Claude Code

### Issue: No sound notification
**Solution**: macOS only feature - verify sound file exists:
```bash
ls -la /System/Library/Sounds/Glass.aiff
```

## Team-Specific Configuration

### Database Access

Team database connection:
- **Host**: `localhost:5432`
- **Database**: `ig_data_admin`
- **User**: `data_admin`
- **Password**: From 1Password vault

### Workspace Directory

Set filesystem MCP to team standard:
```
/Users/YOUR_USERNAME/Documents/GitHub/
```

### Context7 Setup

For `/context` command to work:
1. Ensure Context7 MCP is installed
2. Add to `claude_desktop_config.json` if not already there

## Getting Help

- **Plugin Issues**: Create issue in team repo
- **Credentials**: Contact DevOps team
- **Claude Code**: https://github.com/anthropics/claude-code
- **MCP Servers**: https://modelcontextprotocol.io

## Next Steps

1. Join team Slack channel: `#claude-code-users`
2. Review team coding standards in `/format` command
3. Explore other team plugins in marketplace
4. Share feedback and suggestions

Happy coding with Claude!
