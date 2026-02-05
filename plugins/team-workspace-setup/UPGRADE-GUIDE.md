# Upgrade Guide: v1.0.0 → v1.1.0

## What Changed

This update fixes critical issues with skills not being recognized and adds 3 new MCP servers.

### Critical Fixes
- ✅ **Skills now work!** - Restructured from flat files to subdirectories
- ✅ Added 3 missing MCPs: context7, serena, playwright

### What You Get
- **4 working skills**: `/context`, `/format`, `/puppeter`, `/serena`
- **7 MCP servers** (3 new): context7, serena, playwright
- **Better docs**: Clear setup instructions, verification script

## How to Upgrade

### Step 1: Update the Plugin

**If installed via git:**
```bash
cd ~/.claude/plugins/marketplaces/my-team-plugins/team-workspace-setup
git pull origin main
```

**If installed via zip:**
1. Download the new version
2. Extract to `~/.claude/plugins/marketplaces/my-team-plugins/team-workspace-setup/`
3. Overwrite existing files when prompted

### Step 2: Set Environment Variables (Optional)

Some MCPs need environment variables. Add to `~/.zshrc` or `~/.bashrc`:

```bash
# Required for some MCPs
export BRAVE_API_KEY="your_key_here"
export POSTGRES_CONNECTION_STRING="postgresql://user:pass@host:5432/db"
export WORKSPACE_PATH="/Users/yourusername/Documents/GitHub"

# Optional for context7
export UPSTASH_CONTEXT7_TOKEN="your_token_here"
```

Then reload:
```bash
source ~/.zshrc
```

### Step 3: Restart Claude Code

Completely quit and reopen Claude Code (not just restart session).

### Step 4: Verify Installation

Run the verification script:
```bash
cd ~/.claude/plugins/marketplaces/my-team-plugins/team-workspace-setup
./verify-setup.sh
```

Or manually check:
```
/skills    # Should show 4 skills
/mcp       # Should show 7 servers
/context   # Test a skill
```

## What Works Without Config

These MCPs work immediately (no env vars needed):
- ✅ **memory** - Persistent memory across sessions
- ✅ **serena** - Code analysis and refactoring
- ✅ **playwright** - Browser automation

These need environment variables:
- ⚙️ **brave-search** - needs BRAVE_API_KEY
- ⚙️ **postgres** - needs POSTGRES_CONNECTION_STRING
- ⚙️ **filesystem** - needs WORKSPACE_PATH
- ⚙️ **context7** - needs UPSTASH_CONTEXT7_TOKEN (optional)

## Troubleshooting

**Skills still not showing?**
1. Check directory structure: `ls -R skills/`
2. Should see: `skills/context/SKILL.md`, `skills/format/SKILL.md`, etc.
3. Restart Claude Code completely

**MCPs failing?**
1. Run `./verify-setup.sh` to check env vars
2. See detailed setup: `cat MCP-SETUP.md`
3. Check Claude Code logs for specific errors

**Old skills directory?**
If you see both flat files and subdirectories in `skills/`, delete the flat files:
```bash
cd skills/
rm -f *.md  # Remove old flat files
ls -la      # Should only see subdirectories
```

## What's Next

After upgrading:
1. Test each skill: `/context`, `/format`, `/puppeter`, `/serena`
2. Test MCPs that don't need config: `/mcp` (look for memory, serena, playwright)
3. Set up remaining MCPs as needed (see MCP-SETUP.md)

## Need Help?

- 📖 Read: `MCP-SETUP.md` for detailed MCP configuration
- 🔍 Run: `./verify-setup.sh` to check your setup
- 🐛 Issues: https://github.com/lucavehbiu/claude-plugins/issues
