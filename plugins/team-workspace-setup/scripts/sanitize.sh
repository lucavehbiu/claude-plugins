#!/bin/bash
# sanitize.sh - Remove sensitive data before sharing

cd "$(dirname "$0")/.."

echo "🧹 Sanitizing plugin for distribution..."

# Replace sensitive values in all files
find . -type f \( -name "*.json" -o -name "*.md" \) | while read file; do
  # Skip node_modules
  if [[ "$file" == *"node_modules"* ]]; then
    continue
  fi

  # Create backup
  cp "$file" "$file.bak"

  # Replace API keys
  sed -i '' 's/BSA[a-zA-Z0-9_-]*/YOUR_BRAVE_API_KEY/g' "$file"
  
  # Replace database passwords
  sed -i '' 's/investigamer/YOUR_DB_PASSWORD/g' "$file"
  
  # Replace connection strings
  sed -i '' 's/postgres:\/\/data_admin:[^@]*@/postgres:\/\/data_admin:PASSWORD@/g' "$file"
  
  # Replace specific usernames
  sed -i '' 's/\/Users\/lucavehbiu/\/Users\/YOUR_USERNAME/g' "$file"
  
  # Replace email addresses
  sed -i '' 's/lvehbiu@reelmetrics\.com/YOUR_EMAIL@company.com/g' "$file"
  
  # Replace specific passwords
  sed -i '' 's/Karantina2020@@2/YOUR_PASSWORD/g' "$file"
  sed -i '' 's/Ikokarqiu@@22/YOUR_PASSWORD/g' "$file"
done

# Remove backup files
find . -name "*.bak" -delete

echo "✅ Sanitization complete!"
echo ""
echo "⚠️  Manual review recommended before sharing:"
echo "  - Check for any remaining sensitive data"
echo "  - Verify credentials are replaced"
echo "  - Review git history if using git"
