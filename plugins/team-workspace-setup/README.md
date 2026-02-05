# Claude Code Team Workspace Setup Plugin

A comprehensive Claude Code plugin that provides team-standardized commands, MCP server configurations, and productivity enhancements for development teams.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/lucavehbiu/claude-plugins/releases)

## Features

### Custom Commands

- **`/context`** - Use Context7 MCP to get latest documentation for project technologies
- **`/format`** - Format SQL queries using standardized team formatting rules
- **`/puppeter`** - Open Arc browser and navigate to URL for automated testing
- **`/serena`** - Ensure Serena MCP is running and utilize project memories

### Productivity Enhancements

- **Sound notifications** - Audio alert when Claude stops (Glass sound)
- **Enhanced status line** - Shows user@hostname, current directory, and model name with colors
- **Pre-configured MCP servers** - Ready-to-use integrations

### Auto-Configured MCP Servers

This plugin automatically configures 7 MCP servers:

1. **Brave Search** - Web search capabilities (needs BRAVE_API_KEY)
2. **PostgreSQL** - Database access and queries (needs POSTGRES_CONNECTION_STRING)
3. **Filesystem** - File system operations (needs WORKSPACE_PATH)
4. **Memory** - Persistent memory across sessions (no config needed)
5. **Context7** - Latest library documentation (needs UPSTASH_CONTEXT7_TOKEN)
6. **Serena** - Code analysis and refactoring (no config needed)
7. **Playwright** - Browser automation for testing (no config needed)

**⚠️ Important:** Some MCPs require environment variables to be set. See [MCP-SETUP.md](MCP-SETUP.md) for configuration instructions.

## 🚀 Quick Start

**1. Install the plugin:**
```bash
mkdir -p ~/.claude/plugins/marketplaces/my-team-plugins
cd ~/.claude/plugins/marketplaces/my-team-plugins
git clone https://github.com/lucavehbiu/claude-plugins.git team-workspace-setup
```

**2. Enable in Claude Code:**
```
/plugins enable team-workspace-setup@my-team-plugins
```

**3. Restart Claude Code**

**4. Test it:**
```
/context
```

📖 **For detailed setup instructions, see [QUICKSTART.md](QUICKSTART.md)**

## Installation

### For Team Members

**Option 1: Git Clone (Recommended)**
```bash
cd ~/.claude/plugins/marketplaces/my-team-plugins
git clone https://github.com/lucavehbiu/claude-plugins.git team-workspace-setup
```

**Option 2: Download Zip**
1. Download from [Releases](https://github.com/lucavehbiu/claude-plugins/releases)
2. Extract to `~/.claude/plugins/marketplaces/my-team-plugins/team-workspace-setup/`

## MCP Server Setup

### Required Configuration

Add these to your `~/Library/Application Support/Claude/claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "brave-search": {
      "command": "/opt/homebrew/bin/npx",
      "args": ["@modelcontextprotocol/server-brave-search"],
      "env": {
        "BRAVE_API_KEY": "YOUR_BRAVE_API_KEY",
        "BRAVE_TIMEOUT": "30000"
      }
    },
    "postgres": {
      "command": "/opt/homebrew/bin/npx",
      "args": [
        "@modelcontextprotocol/server-postgres",
        "postgresql://username:password@localhost:5432/database"
      ]
    },
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/path/to/your/workspace"
      ]
    },
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    }
  }
}
```

### Getting API Keys

- **Brave Search**: Get your API key at https://brave.com/search/api/
- **PostgreSQL**: Use your database connection string
- **Filesystem**: Set to your team's workspace directory

## Usage

### Using Commands

Simply type the command in Claude Code:

```
/context
```

Claude will automatically use Context7 to fetch the latest documentation for technologies in your project.

```
/format
```

Paste your SQL query, and Claude will format it according to team standards.

```
/puppeter
```

Provide a URL and Claude will open Arc browser to test the page.

```
/serena
```

Ensures Serena MCP is active and checks project memories in `.serena/memories/`.

## Customization

### For Your Team

1. **Update API Keys**: Replace placeholder values in MCP server configurations
2. **Modify Skills**: Edit `SKILL.md` files in `skills/` subdirectories
3. **Adjust Settings**: Update `plugin.json` for custom hooks or status line
4. **Add Team Tools**: Include additional MCP servers your team uses

### Sharing with Team

#### Option 1: Git Repository (Recommended)

1. Create a team repository:
   ```bash
   cd ~/.claude/plugins/marketplaces/my-team-plugins/team-workspace-setup
   git init
   git add .
   git commit -m "Initial team workspace setup"
   git remote add origin https://github.com/your-org/team-workspace-setup.git
   git push -u origin main
   ```

2. Team members install:
   ```bash
   cd ~/.claude/plugins/marketplaces/my-team-plugins/
   git clone https://github.com/your-org/team-workspace-setup.git
   ```

#### Option 2: Zip Distribution

1. Package the plugin:
   ```bash
   cd ~/.claude/plugins/marketplaces/my-team-plugins/
   zip -r team-workspace-setup.zip team-workspace-setup/
   ```

2. Share `team-workspace-setup.zip` with your team
3. Team members extract to `~/.claude/plugins/marketplaces/my-team-plugins/`

## Dependencies

### Recommended Plugins

This plugin works best with these official plugins enabled:

- `serena@claude-plugins-official` - Advanced code manipulation
- `commit-commands@claude-code-plugins` - Git workflow automation
- `pr-review-toolkit@claude-code-plugins` - PR review assistance
- `feature-dev@claude-code-plugins` - Feature development workflows
- `frontend-design@claude-code-plugins` - Frontend design assistance
- `python-development@claude-code-workflows` - Python development tools

Enable these via Claude Code settings or:
```
/plugins enable serena@claude-plugins-official
```

## Troubleshooting

### Commands Not Working

1. Verify plugin is installed: `/plugins list`
2. Enable the plugin: `/plugins enable team-workspace-setup@my-team-plugins`
3. Restart Claude Code

### MCP Servers Not Connecting

1. Check `claude_desktop_config.json` syntax
2. Verify API keys are set correctly
3. Ensure `npx` is available: `which npx`
4. Check MCP server logs in Claude Desktop

### Status Line Not Showing

1. Ensure `jq` is installed: `brew install jq`
2. Check settings are applied in `~/.claude/settings.json`
3. Restart Claude Code

## 🔒 Security

This plugin has been sanitized to remove:
- ✅ API keys and credentials
- ✅ Personal information (emails, usernames)
- ✅ Database passwords
- ✅ Private file paths

All sensitive values are replaced with placeholders like `YOUR_API_KEY` or environment variables.

## 📖 Documentation

- **[QUICKSTART.md](QUICKSTART.md)** - Get started in 5 minutes
- **[SETUP.md](SETUP.md)** - Detailed installation and configuration
- **[DEPLOYMENT.md](DEPLOYMENT.md)** - How to distribute to your team
- **[CHANGELOG.md](CHANGELOG.md)** - Version history and updates

## 🤝 Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run sanitization: `bash scripts/sanitize.sh`
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/lucavehbiu/claude-plugins/issues)
- **Discussions**: [GitHub Discussions](https://github.com/lucavehbiu/claude-plugins/discussions)
- **Documentation**: See the documentation files in this repository

## 📄 License

This project is licensed under the MIT License - See [LICENSE](LICENSE) file for details.

## 📈 Version History

See [CHANGELOG.md](CHANGELOG.md) for detailed version history.

**Current Version**: 1.0.0 (2026-02-05)

---

**Made with ❤️ for productive development teams**
