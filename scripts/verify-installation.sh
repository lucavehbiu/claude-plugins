#!/bin/bash
# verify-installation.sh
# Verifies that the Team Workspace Setup plugin is correctly installed

set -e

echo "🔍 Verifying Team Workspace Setup Plugin Installation..."
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
PASS=0
FAIL=0
WARN=0

# Check function
check() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $1"
        ((PASS++))
    else
        echo -e "${RED}✗${NC} $1"
        ((FAIL++))
    fi
}

check_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
    ((WARN++))
}

# 1. Check plugin directory exists
echo "1. Checking plugin directory..."
if [ -d "$HOME/.claude/plugins/marketplaces/my-team-plugins/team-workspace-setup" ]; then
    check "Plugin directory exists"
else
    echo -e "${RED}✗${NC} Plugin directory not found"
    ((FAIL++))
    exit 1
fi

# 2. Check plugin.json exists
echo ""
echo "2. Checking plugin configuration..."
if [ -f "$HOME/.claude/plugins/marketplaces/my-team-plugins/team-workspace-setup/.claude-plugin/plugin.json" ]; then
    check "plugin.json exists"
else
    echo -e "${RED}✗${NC} plugin.json not found"
    ((FAIL++))
fi

# 3. Check commands exist
echo ""
echo "3. Checking custom commands..."
for cmd in context format puppeter serena; do
    if [ -f "$HOME/.claude/plugins/marketplaces/my-team-plugins/team-workspace-setup/commands/${cmd}.md" ]; then
        check "Command /$cmd exists"
    else
        echo -e "${RED}✗${NC} Command /$cmd not found"
        ((FAIL++))
    fi
done

# 4. Check MCP configuration
echo ""
echo "4. Checking MCP server configuration..."
MCP_CONFIG="$HOME/Library/Application Support/Claude/claude_desktop_config.json"
if [ -f "$MCP_CONFIG" ]; then
    check "MCP config file exists"

    # Check for required MCP servers
    for server in brave-search postgres filesystem memory; do
        if grep -q "\"$server\"" "$MCP_CONFIG"; then
            check "MCP server '$server' configured"
        else
            check_warn "MCP server '$server' not configured (optional)"
        fi
    done
else
    check_warn "MCP config file not found (will be created on first run)"
fi

# 5. Check prerequisites
echo ""
echo "5. Checking prerequisites..."

# Check Node.js
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    check "Node.js installed ($NODE_VERSION)"
else
    echo -e "${RED}✗${NC} Node.js not installed"
    ((FAIL++))
fi

# Check npm
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm --version)
    check "npm installed ($NPM_VERSION)"
else
    echo -e "${RED}✗${NC} npm not installed"
    ((FAIL++))
fi

# Check npx
if command -v npx &> /dev/null; then
    check "npx available"
else
    echo -e "${RED}✗${NC} npx not available"
    ((FAIL++))
fi

# Check jq (for status line)
if command -v jq &> /dev/null; then
    JQ_VERSION=$(jq --version)
    check "jq installed ($JQ_VERSION)"
else
    check_warn "jq not installed (status line won't work)"
    echo "  Install with: brew install jq"
fi

# 6. Check Claude settings
echo ""
echo "6. Checking Claude Code settings..."
SETTINGS_FILE="$HOME/.claude/settings.json"
if [ -f "$SETTINGS_FILE" ]; then
    check "Claude settings file exists"

    # Check if plugin is enabled
    if grep -q "team-workspace-setup@my-team-plugins" "$SETTINGS_FILE"; then
        check "Plugin enabled in settings"
    else
        check_warn "Plugin not enabled (run: /plugins enable team-workspace-setup@my-team-plugins)"
    fi
else
    check_warn "Claude settings file not found (will be created on first run)"
fi

# 7. Check documentation
echo ""
echo "7. Checking documentation..."
for doc in README.md SETUP.md DEPLOYMENT.md CHANGELOG.md LICENSE; do
    if [ -f "$HOME/.claude/plugins/marketplaces/my-team-plugins/team-workspace-setup/$doc" ]; then
        check "$doc exists"
    else
        check_warn "$doc not found"
    fi
done

# Summary
echo ""
echo "=========================================="
echo "VERIFICATION SUMMARY"
echo "=========================================="
echo -e "${GREEN}Passed:${NC} $PASS"
if [ $WARN -gt 0 ]; then
    echo -e "${YELLOW}Warnings:${NC} $WARN"
fi
if [ $FAIL -gt 0 ]; then
    echo -e "${RED}Failed:${NC} $FAIL"
fi
echo ""

if [ $FAIL -eq 0 ]; then
    echo -e "${GREEN}✓ Installation looks good!${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Enable the plugin: /plugins enable team-workspace-setup@my-team-plugins"
    echo "2. Configure MCP servers (see SETUP.md)"
    echo "3. Restart Claude Code"
    echo "4. Test with: /context"
    exit 0
else
    echo -e "${RED}✗ Installation has issues. Please review and fix.${NC}"
    echo ""
    echo "See SETUP.md for detailed installation instructions."
    exit 1
fi
