#!/bin/bash

# Pedro's Elite Development Environment - GitHub Deployment Helper
# Interactive script to deploy your dev environment to GitHub

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Icons
SUCCESS="✅"
INFO="ℹ️"
ROCKET="🚀"
GEAR="⚙️"

log() {
    local level=$1
    shift
    local message="$*"
    
    case $level in
        "SUCCESS") echo -e "${GREEN}${SUCCESS} $message${NC}" ;;
        "INFO") echo -e "${CYAN}${INFO} $message${NC}" ;;
        "ROCKET") echo -e "${BLUE}${ROCKET} $message${NC}" ;;
        "GEAR") echo -e "${YELLOW}${GEAR} $message${NC}" ;;
    esac
}

echo ""
log "ROCKET" "Pedro's Elite Development Environment - GitHub Deployment"
echo ""

# Get current directory
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_DIR"

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    log "INFO" "Initializing Git repository..."
    git init
    git add .
    git commit -m "🚀 Initial commit: Elite development environment"
fi

# Get GitHub username
echo -e "${WHITE}Step 1: GitHub Repository Creation${NC}"
echo ""
echo -n "Enter your GitHub username: "
read -r github_username

if [ -z "$github_username" ]; then
    echo "❌ GitHub username is required"
    exit 1
fi

# Repository details
repo_name="pedro-dev-environment"
repo_url="https://github.com/$github_username/$repo_name.git"

echo ""
log "INFO" "Repository will be created at: https://github.com/$github_username/$repo_name"
echo ""

# Manual GitHub creation instructions
echo -e "${WHITE}Step 2: Create GitHub Repository Manually${NC}"
echo ""
echo "🌐 Please follow these steps:"
echo ""
echo "1. Open your browser and go to: ${CYAN}https://github.com/new${NC}"
echo ""
echo "2. Fill in the repository details:"
echo "   • Repository name: ${GREEN}$repo_name${NC}"
echo "   • Description: ${GREEN}🚀 One-command setup for elite development environment${NC}"
echo "   • Visibility: ${GREEN}Public${NC} ✅"
echo "   • Initialize options: ${YELLOW}Leave ALL unchecked${NC} (we have our own files)"
echo ""
echo "3. Click ${GREEN}'Create repository'${NC}"
echo ""

# Wait for user to create repository
echo -n "Press Enter when you've created the GitHub repository..."
read -r

echo ""
log "GEAR" "Setting up Git remote and pushing to GitHub..."

# Add remote if it doesn't exist
if ! git remote get-url origin > /dev/null 2>&1; then
    git remote add origin "$repo_url"
    log "SUCCESS" "Added GitHub remote: $repo_url"
else
    log "INFO" "Remote 'origin' already exists"
    git remote set-url origin "$repo_url"
    log "SUCCESS" "Updated remote URL: $repo_url"
fi

# Push to GitHub
echo ""
log "GEAR" "Pushing to GitHub..."

if git push -u origin main; then
    log "SUCCESS" "🎉 Successfully pushed to GitHub!"
else
    echo ""
    echo "❌ Push failed. This might be because:"
    echo "   • Repository name doesn't match: $repo_name"
    echo "   • Username is incorrect: $github_username"
    echo "   • Repository wasn't created on GitHub"
    echo ""
    echo "Manual push commands:"
    echo "   git remote set-url origin $repo_url"
    echo "   git push -u origin main"
    exit 1
fi

echo ""
echo "🎯 ${WHITE}Repository Successfully Deployed!${NC}"
echo ""
echo "📍 Your repository is now available at:"
echo "   ${CYAN}https://github.com/$github_username/$repo_name${NC}"
echo ""

# Test the one-command setup
echo -e "${WHITE}Step 3: Test One-Command Setup${NC}"
echo ""
echo "🧪 You can now test the one-command installation:"
echo ""
echo -e "${GREEN}curl -s https://raw.githubusercontent.com/$github_username/$repo_name/main/setup.sh | bash${NC}"
echo ""

echo "⚠️  ${YELLOW}Note: Wait a few minutes for GitHub to process the files before testing${NC}"
echo ""

log "SUCCESS" "🚀 Elite development environment successfully deployed to GitHub!"
echo ""
echo "📚 Next steps:"
echo "   1. Test the installation on a different machine"
echo "   2. Share the repository with your team"
echo "   3. Keep the environment updated with 'git pull && ./setup.sh'"
echo ""
echo "🎉 Congratulations! Your elite dev environment is now portable across any workstation!"