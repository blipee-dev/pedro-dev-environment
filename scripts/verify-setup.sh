#!/bin/bash

# Pedro's Elite Development Environment - Setup Verification
# Test key components without full installation

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# Icons
SUCCESS="✅"
ERROR="❌"
WARNING="⚠️"
INFO="ℹ️"

log() {
    local level=$1
    shift
    local message="$*"
    local timestamp=$(date '+%H:%M:%S')
    
    case $level in
        "SUCCESS") echo -e "${GREEN}${SUCCESS} [$timestamp] $message${NC}" ;;
        "ERROR") echo -e "${RED}${ERROR} [$timestamp] $message${NC}" ;;
        "WARNING") echo -e "${YELLOW}${WARNING} [$timestamp] $message${NC}" ;;
        "INFO") echo -e "${CYAN}${INFO} [$timestamp] $message${NC}" ;;
    esac
}

echo ""
log "INFO" "🧪 Pedro's Elite Development Environment - Verification Test"
echo ""

# Test 1: Check if running on macOS
log "INFO" "Testing platform compatibility..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    log "SUCCESS" "macOS detected - Platform compatible"
else
    log "WARNING" "Not running on macOS - Setup designed for macOS"
fi

# Test 2: Check for required tools
log "INFO" "Checking for required tools..."

tools_available=0
total_tools=0

check_tool() {
    local tool=$1
    local description=$2
    ((total_tools++))
    
    if command -v "$tool" &> /dev/null; then
        log "SUCCESS" "$description: Available"
        ((tools_available++))
    else
        log "WARNING" "$description: Not installed (will be installed by setup)"
    fi
}

check_tool "git" "Git version control"
check_tool "curl" "URL transfer tool"
check_tool "brew" "Homebrew package manager"
check_tool "code" "VS Code editor"
check_tool "node" "Node.js runtime"
check_tool "npm" "Node package manager"

# Test 3: Check repository structure
log "INFO" "Verifying repository structure..."

check_file() {
    local file=$1
    local description=$2
    
    if [ -f "$file" ]; then
        log "SUCCESS" "$description: Present"
    else
        log "ERROR" "$description: Missing"
    fi
}

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

check_file "$REPO_DIR/setup.sh" "Main setup script"
check_file "$REPO_DIR/README.md" "README documentation"
check_file "$REPO_DIR/configs/.zshrc" "Shell configuration"
check_file "$REPO_DIR/configs/vscode-settings.json" "VS Code settings"
check_file "$REPO_DIR/automation/blipee-toolpad/blipee" "Blipee automation system"

# Test 4: Verify setup script syntax
log "INFO" "Checking setup script syntax..."
if bash -n "$REPO_DIR/setup.sh"; then
    log "SUCCESS" "Setup script syntax is valid"
else
    log "ERROR" "Setup script has syntax errors"
fi

# Test 5: Check documentation
log "INFO" "Verifying documentation..."
doc_files=("README.md" "docs/SETUP.md" "docs/QUICK_REFERENCE.md")
for doc in "${doc_files[@]}"; do
    if [ -f "$REPO_DIR/$doc" ] && [ -s "$REPO_DIR/$doc" ]; then
        log "SUCCESS" "$doc: Complete"
    else
        log "WARNING" "$doc: Missing or empty"
    fi
done

# Test 6: Check automation system
log "INFO" "Verifying automation system..."
if [ -x "$REPO_DIR/automation/blipee-toolpad/blipee" ]; then
    log "SUCCESS" "Blipee automation system: Executable"
else
    log "WARNING" "Blipee automation system: Not executable"
fi

# Summary
echo ""
log "INFO" "=== VERIFICATION SUMMARY ==="
echo ""
log "INFO" "Tools available: $tools_available/$total_tools"

if [ -f "$REPO_DIR/setup.sh" ] && [ -x "$REPO_DIR/setup.sh" ]; then
    log "SUCCESS" "🎯 Repository is ready for deployment!"
    echo ""
    echo "🚀 Next steps:"
    echo "   1. Create GitHub repository at: https://github.com/pedro/pedro-dev-environment"
    echo "   2. Push this repository to GitHub"
    echo "   3. Test installation with:"
    echo "      curl -s https://raw.githubusercontent.com/pedro/pedro-dev-environment/main/setup.sh | bash"
    echo ""
else
    log "ERROR" "Repository has issues that need to be resolved"
fi

echo ""
log "INFO" "Verification complete!"