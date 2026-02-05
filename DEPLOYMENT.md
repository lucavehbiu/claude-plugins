# Deployment Guide

How to package and share this plugin with your team.

## Option 1: GitHub Repository (Recommended)

### Initial Setup

1. **Create GitHub Repository**

   ```bash
   cd ~/.claude/plugins/marketplaces/my-team-plugins/team-workspace-setup
   git init
   git add .
   git commit -m "Initial commit: Team workspace setup plugin v1.0.0"
   ```

2. **Create Repository on GitHub**
   - Go to https://github.com/new
   - Name: `team-workspace-setup`
   - Make it private if it contains sensitive configurations
   - Don't initialize with README (we already have one)

3. **Push to GitHub**

   ```bash
   git remote add origin https://github.com/YOUR-ORG/team-workspace-setup.git
   git branch -M main
   git push -u origin main
   ```

### Team Member Installation

Team members install with:

```bash
# Create directory if it doesn't exist
mkdir -p ~/.claude/plugins/marketplaces/my-team-plugins

# Clone the plugin
cd ~/.claude/plugins/marketplaces/my-team-plugins
git clone https://github.com/YOUR-ORG/team-workspace-setup.git

# Enable the plugin
# In Claude Code, run:
# /plugins enable team-workspace-setup@my-team-plugins
```

### Updating the Plugin

**For maintainers:**
```bash
cd ~/.claude/plugins/marketplaces/my-team-plugins/team-workspace-setup
# Make changes
git add .
git commit -m "Update: description of changes"
git tag v1.0.1  # Increment version
git push origin main --tags
```

**For team members:**
```bash
cd ~/.claude/plugins/marketplaces/my-team-plugins/team-workspace-setup
git pull origin main
# Restart Claude Code
```

## Option 2: Zip Distribution

### Create Distribution Package

```bash
cd ~/.claude/plugins/marketplaces/my-team-plugins
zip -r team-workspace-setup-v1.0.0.zip team-workspace-setup/ \
  -x "*.git*" \
  -x "*node_modules*" \
  -x "*.DS_Store"
```

### Share with Team

1. Upload `team-workspace-setup-v1.0.0.zip` to:
   - Team shared drive
   - Confluence/Wiki
   - Internal file server
   - Email (if small enough)

2. Team members install:
   ```bash
   cd ~/.claude/plugins/marketplaces/my-team-plugins
   unzip ~/Downloads/team-workspace-setup-v1.0.0.zip
   ```

## Option 3: Internal NPM Registry (Advanced)

If your team has an internal NPM registry:

### Package Setup

1. **Create package.json**

   ```bash
   cd ~/.claude/plugins/marketplaces/my-team-plugins/team-workspace-setup
   cat > package.json << 'EOF'
   {
     "name": "@your-org/claude-team-workspace",
     "version": "1.0.0",
     "description": "Team workspace setup for Claude Code",
     "main": ".claude-plugin/plugin.json",
     "files": [
       ".claude-plugin/",
       "commands/",
       ".mcp.json",
       "README.md",
       "SETUP.md"
     ],
     "publishConfig": {
       "registry": "https://npm.your-company.com"
     }
   }
   EOF
   ```

2. **Publish**

   ```bash
   npm publish
   ```

3. **Team Installation**

   ```bash
   cd ~/.claude/plugins/marketplaces/my-team-plugins
   npm install -g @your-org/claude-team-workspace
   # Link to Claude plugins directory
   ln -s $(npm root -g)/@your-org/claude-team-workspace team-workspace-setup
   ```

## Option 4: Docker Image (For Standardized Environments)

Create a Docker image with Claude Code + plugin pre-configured.

### Dockerfile

```dockerfile
FROM anthropics/claude-code:latest

# Copy plugin
COPY team-workspace-setup /root/.claude/plugins/marketplaces/my-team-plugins/team-workspace-setup/

# Copy default settings
COPY claude_desktop_config.json /root/Library/Application Support/Claude/

# Enable plugin by default
RUN echo '{"enabledPlugins": {"team-workspace-setup@my-team-plugins": true}}' > /root/.claude/settings.json

CMD ["claude-code"]
```

## Security Considerations

### Before Sharing

1. **Remove Sensitive Data**
   - API keys
   - Database passwords
   - Personal file paths
   - Email addresses

2. **Use Environment Variables**
   - Replace hardcoded credentials with `${VARIABLE_NAME}`
   - Document required environment variables
   - Provide `.env.example` file

3. **Review Files**
   ```bash
   # Check for accidental secrets
   cd ~/.claude/plugins/marketplaces/my-team-plugins/team-workspace-setup
   grep -r "password\|api_key\|secret\|token" .
   ```

### Sanitization Script

```bash
#!/bin/bash
# sanitize.sh - Remove sensitive data before sharing

cd ~/.claude/plugins/marketplaces/my-team-plugins/team-workspace-setup

# Replace sensitive values
find . -type f -name "*.json" -o -name "*.md" | while read file; do
  sed -i.bak 's/YOUR_BRAVE_API_KEY[a-zA-Z0-9]*/YOUR_BRAVE_API_KEY/g' "$file"
  sed -i.bak 's/postgresql:\/\/[^"]*/"postgresql:\/\/username:password@localhost:5432\/database"/g' "$file"
  sed -i.bak 's/\/Users\/[^\/]*\//"\/Users\/YOUR_USERNAME\//g' "$file"
done

# Remove backup files
find . -name "*.bak" -delete

echo "Sanitization complete! Review changes before committing."
```

## Team Onboarding Checklist

Create this checklist for new team members:

### Installation Checklist

- [ ] Clone plugin repository
- [ ] Install prerequisites (Node.js, jq)
- [ ] Configure MCP servers in `claude_desktop_config.json`
- [ ] Get API keys from 1Password
- [ ] Update database connection string
- [ ] Set workspace path
- [ ] Enable recommended plugins
- [ ] Enable team workspace plugin
- [ ] Restart Claude Code
- [ ] Test `/context` command
- [ ] Test `/format` command
- [ ] Test status line display
- [ ] Test MCP server connections
- [ ] Join team Slack channel

## Versioning

Follow semantic versioning:

- **Major (1.0.0)**: Breaking changes
- **Minor (0.1.0)**: New features, backward compatible
- **Patch (0.0.1)**: Bug fixes

Update `version` in:
- `.claude-plugin/plugin.json`
- `package.json` (if using NPM)
- Git tags

## Documentation Updates

When updating the plugin, also update:

1. **README.md** - Main documentation
2. **SETUP.md** - Installation instructions
3. **CHANGELOG.md** - Version history
4. **plugin.json** - Version number

## Support

Set up team support channels:

- **Slack**: `#claude-code-users`
- **Email**: devops@yourcompany.com
- **Wiki**: https://wiki.yourcompany.com/claude-code
- **Issues**: GitHub Issues on repository

## Maintenance

Schedule regular maintenance:

- [ ] Monthly: Review and update commands
- [ ] Quarterly: Update MCP server versions
- [ ] Annually: Major version review
- [ ] As needed: Security patches

## Rollback Procedure

If an update causes issues:

```bash
cd ~/.claude/plugins/marketplaces/my-team-plugins/team-workspace-setup
git log  # Find previous working version
git checkout v1.0.0  # Replace with working version tag
# Restart Claude Code
```

## Analytics (Optional)

Track plugin usage:

1. Add telemetry to commands (opt-in)
2. Monitor adoption rate
3. Collect feedback
4. Iterate based on team needs
