#!/bin/bash
# package-plugin.sh
# Creates a distribution package of the plugin

set -e

PLUGIN_NAME="team-workspace-setup"
PLUGIN_DIR="$HOME/.claude/plugins/marketplaces/my-team-plugins/$PLUGIN_NAME"
VERSION=$(grep '"version"' "$PLUGIN_DIR/.claude-plugin/plugin.json" | head -1 | sed 's/.*"version": "\(.*\)".*/\1/')
OUTPUT_DIR="$HOME/Downloads"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)

echo "📦 Packaging Team Workspace Setup Plugin"
echo "Version: $VERSION"
echo ""

# Check if plugin directory exists
if [ ! -d "$PLUGIN_DIR" ]; then
    echo "❌ Error: Plugin directory not found at $PLUGIN_DIR"
    exit 1
fi

# Create temporary directory
TEMP_DIR=$(mktemp -d)
echo "Using temporary directory: $TEMP_DIR"

# Copy plugin files
echo "Copying plugin files..."
cp -r "$PLUGIN_DIR" "$TEMP_DIR/$PLUGIN_NAME"

# Change to temp directory
cd "$TEMP_DIR/$PLUGIN_NAME"

# Remove sensitive data (if any)
echo "Sanitizing files..."
if [ -f "scripts/sanitize.sh" ]; then
    bash scripts/sanitize.sh
fi

# Remove development files
echo "Removing development files..."
rm -rf .git
rm -rf node_modules
rm -rf .DS_Store
find . -name "*.log" -delete
find . -name ".DS_Store" -delete

# Create zip archive
cd "$TEMP_DIR"
ZIP_NAME="$PLUGIN_NAME-v$VERSION-$TIMESTAMP.zip"
echo "Creating archive: $ZIP_NAME"
zip -r "$OUTPUT_DIR/$ZIP_NAME" "$PLUGIN_NAME" -x "*.git*" -x "*node_modules*" -x "*.DS_Store"

# Create tar.gz archive (alternative)
TAR_NAME="$PLUGIN_NAME-v$VERSION-$TIMESTAMP.tar.gz"
echo "Creating archive: $TAR_NAME"
tar -czf "$OUTPUT_DIR/$TAR_NAME" "$PLUGIN_NAME" --exclude=".git*" --exclude="node_modules" --exclude=".DS_Store"

# Cleanup
rm -rf "$TEMP_DIR"

echo ""
echo "✅ Plugin packaged successfully!"
echo ""
echo "Archives created:"
echo "  ZIP: $OUTPUT_DIR/$ZIP_NAME"
echo "  TAR: $OUTPUT_DIR/$TAR_NAME"
echo ""
echo "File sizes:"
ls -lh "$OUTPUT_DIR/$ZIP_NAME" | awk '{print "  ZIP: " $5}'
ls -lh "$OUTPUT_DIR/$TAR_NAME" | awk '{print "  TAR: " $5}'
echo ""
echo "Next steps:"
echo "1. Test the archive by extracting and installing"
echo "2. Share with your team via:"
echo "   - GitHub release"
echo "   - Team shared drive"
echo "   - Email/Slack"
echo ""
echo "For GitHub release:"
echo "  gh release create v$VERSION $OUTPUT_DIR/$ZIP_NAME $OUTPUT_DIR/$TAR_NAME"
