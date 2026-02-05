#!/bin/bash

# Verification script for team-workspace-setup plugin

echo "🔍 Verifying Team Workspace Setup Plugin"
echo "=========================================="
echo ""

# Check skills structure
echo "✓ Skills Structure:"
if [ -d "skills/context" ] && [ -f "skills/context/SKILL.md" ] && \
   [ -d "skills/format" ] && [ -f "skills/format/SKILL.md" ] && \
   [ -d "skills/puppeter" ] && [ -f "skills/puppeter/SKILL.md" ] && \
   [ -d "skills/serena" ] && [ -f "skills/serena/SKILL.md" ]; then
    echo "  ✅ All 4 skills correctly structured"
    ls -1 skills/*/SKILL.md | sed 's/^/    - /'
else
    echo "  ❌ Skills structure incorrect"
fi
echo ""

# Check plugin.json
echo "✓ Plugin Configuration:"
if [ -f ".claude-plugin/plugin.json" ]; then
    echo "  ✅ plugin.json exists"

    # Count MCP servers
    mcp_count=$(grep -c '"command"' .claude-plugin/plugin.json)
    echo "  📊 MCP servers configured: $mcp_count"

    # List MCP servers
    echo "  MCP servers:"
    grep -B 1 '"command"' .claude-plugin/plugin.json | grep -v '"command"' | grep -v '^--$' | sed 's/.*"\(.*\)".*/    - \1/'
else
    echo "  ❌ plugin.json not found"
fi
echo ""

# Check environment variables
echo "✓ Environment Variables:"
vars=("BRAVE_API_KEY" "POSTGRES_CONNECTION_STRING" "WORKSPACE_PATH" "UPSTASH_CONTEXT7_TOKEN")
for var in "${vars[@]}"; do
    if [ -n "${!var}" ]; then
        echo "  ✅ $var is set"
    else
        echo "  ⚠️  $var is NOT set (may be optional)"
    fi
done
echo ""

# Final summary
echo "=========================================="
echo "📋 Next Steps:"
echo "1. Set missing environment variables in ~/.zshrc or ~/.bashrc"
echo "2. Restart Claude Code completely"
echo "3. Run: /skills"
echo "4. Run: /mcp"
echo "5. Test a skill: /context"
echo ""
echo "📖 For detailed setup: cat MCP-SETUP.md"
