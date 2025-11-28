#!/bin/bash

# Script to initialize and push repo directory to GitHub
# This script must be run from within the repo directory

set -e  # Exit on error

echo "🚀 Initializing GitHub repository for Wiki PR workflow..."

# Check if we're in the repo directory
if [ ! -f "README.md" ] || [ ! -d ".github" ]; then
    echo "❌ Error: This script must be run from the repo directory"
    echo "Please run: cd /Volumes/13EjectionPlug/code/dev-wiki-website/repo"
    exit 1
fi

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "📦 Initializing git repository..."
    git init
    echo "✅ Git initialized"
else
    echo "✅ Git already initialized"
fi

# Create entries directory (will be in .gitignore but should exist)
mkdir -p entries
echo "✅ Created entries directory"

# Add all files
echo "📝 Adding files to git..."
git add .
git status

# Create initial commit
echo "💾 Creating initial commit..."
git commit -m "Initial setup: PR review workflow for Wiki entries

- Added GitHub Actions workflow for PR merge handling
- Workflow directly updates Cloudflare KV on PR merge
- Includes README and CONTRIBUTING documentation
- Configured for Monkey Knows Wiki project"

# Set main branch
echo "🌿 Setting main branch..."
git branch -M main

# Check if remote exists
if git remote get-url origin &> /dev/null; then
    echo "✅ Remote 'origin' already configured:"
    git remote get-url origin
else
    echo "⚠️  Remote 'origin' not configured"
    echo "Please add remote manually with:"
    echo "  git remote add origin git@github-yyh0808:yyh0808/monkeyknows.git"
    echo ""
    echo "Then run:"
    echo "  git push -u origin main"
    exit 0
fi

# Ask user if they want to push
read -p "🔄 Push to GitHub now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🚀 Pushing to GitHub..."
    git push -u origin main
    echo ""
    echo "✅ Successfully pushed to GitHub!"
    echo ""
    echo "🎉 Next steps:"
    echo "1. Go to your GitHub repository: https://github.com/yyh0808/monkeyknows"
    echo "2. Navigate to 'Settings' > 'Secrets and variables' > 'Actions'"
    echo "3. Add the following secrets:"
    echo "   - CF_ACCOUNT_ID"
    echo "   - CF_API_TOKEN"
    echo "   - CF_KV_NAMESPACE_ID"
    echo "4. The workflow will be active for all future PR merges!"
else
    echo "⏸️  Push cancelled. You can push later with:"
    echo "  git push -u origin main"
fi
