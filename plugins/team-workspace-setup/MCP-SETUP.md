# MCP Server Setup

This plugin automatically configures 4 MCP servers, but they require environment variables to be set.

## Required Environment Variables

Add these to your shell configuration file (`~/.zshrc` or `~/.bashrc`):

```bash
# Brave Search API Key (get from team 1Password)
export BRAVE_API_KEY="YOUR_BRAVE_API_KEY_HERE"

# PostgreSQL connection string (get from team 1Password)
export POSTGRES_CONNECTION_STRING="postgresql://username:password@host:5432/database"

# Your workspace path
export WORKSPACE_PATH="/Users/YOUR_USERNAME/Documents/GitHub"
```

## Setup Steps

**1. Add environment variables:**
```bash
# Edit your shell config
nano ~/.zshrc  # or ~/.bashrc if using bash

# Add the exports above with your actual values
# Save and exit (Ctrl+X, then Y, then Enter)
```

**2. Reload your shell:**
```bash
source ~/.zshrc  # or source ~/.bashrc
```

**3. Restart Claude Code completely** (quit and reopen)

**4. Verify MCP servers are running:**
```
/mcp
```

You should see all 4 servers listed:
- brave-search
- postgres
- filesystem
- memory

## Getting Credentials

**Brave API Key:**
- Check team 1Password vault
- Or sign up at: https://brave.com/search/api/

**PostgreSQL Connection String:**
- Check team 1Password vault
- Format: `postgresql://username:password@host:5432/database`

**Workspace Path:**
- Use your actual GitHub/projects directory
- Example: `/Users/yourusername/Documents/GitHub`

## Troubleshooting

**MCPs not showing up?**
```bash
# Check environment variables are set
echo $BRAVE_API_KEY
echo $POSTGRES_CONNECTION_STRING
echo $WORKSPACE_PATH

# If empty, you need to set them and restart Claude Code
```

**Permission denied errors?**
- Make sure paths exist
- Check file permissions on workspace path

**Connection errors?**
- Verify PostgreSQL credentials
- Check network access to database
- Verify Brave API key is valid

## Optional: Per-Project Configuration

You can also set these in a `.env` file in your project (add to `.gitignore`!):

```bash
# .env (DO NOT COMMIT THIS FILE)
BRAVE_API_KEY=your_key_here
POSTGRES_CONNECTION_STRING=postgresql://user:pass@host:5432/db
WORKSPACE_PATH=/path/to/workspace
```

Then load them before starting Claude Code:
```bash
set -a; source .env; set +a
claude
```
