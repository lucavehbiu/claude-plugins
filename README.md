# Claude Plugins Marketplace

Custom Claude Code plugins for team productivity and standardization.

## Available Plugins

### Team Workspace Setup

Team-standardized commands, MCP server configurations, and productivity enhancements.

**Features:**
- Custom commands: `/context`, `/format`, `/puppeter`, `/serena`
- Audio notifications when Claude finishes tasks
- Enhanced colorful status line
- Pre-configured MCP server templates

[View Plugin Documentation →](plugins/team-workspace-setup/README.md)

## Installation

Installing is super simple - just run these commands in Claude Code:

**1. Add the marketplace:**
```
/plugin marketplace add lucavehbiu/claude-plugins
```
You should see: `✓ Successfully added marketplace: team-plugins`

**2. Install the plugin:**
```
/plugin install team-workspace-setup@team-plugins
```

**3. Enable it:**
```
/plugin enable team-workspace-setup@team-plugins
```

**4. Restart Claude Code**

**5. Test it works:**
```
/context
```

That's it! No manual cloning or file copying needed. The plugin installs directly from GitHub.

### What You Get

- ✅ `/context` - Fetch latest docs using Context7 MCP
- ✅ `/format` - Format SQL queries with team standards
- ✅ `/puppeter` - Open Arc browser for testing
- ✅ `/serena` - Check Serena MCP status
- ✅ 🔊 Audio notification when Claude finishes (Glass sound)
- ✅ 🎨 Colorful status line: `user@hostname ~/path [Model]`

### Updating

When we push updates to the plugin, refresh with:
```
/plugin marketplace update team-plugins
/plugin update team-workspace-setup@team-plugins
```

## For Contributors

See [plugins/team-workspace-setup/README.md](plugins/team-workspace-setup/README.md) for development instructions.

## License

MIT License - See individual plugin directories for details.
