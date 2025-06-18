#!/bin/bash

# Pedro's Elite Development Environment Setup
# One-command setup for world-class development environment
# Usage: curl -s https://raw.githubusercontent.com/pedro/pedro-dev-environment/main/setup.sh | bash

set -e

# Colors for beautiful output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Icons
SUCCESS="✅"
ERROR="❌"
WARNING="⚠️"
INFO="ℹ️"
ROCKET="🚀"
GEAR="⚙️"
SPARKLES="✨"

# Logging function
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
        "ROCKET") echo -e "${PURPLE}${ROCKET} [$timestamp] $message${NC}" ;;
        "GEAR") echo -e "${BLUE}${GEAR} [$timestamp] $message${NC}" ;;
        "SPARKLES") echo -e "${YELLOW}${SPARKLES} [$timestamp] $message${NC}" ;;
    esac
}

# Check if running on macOS
check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        log "ERROR" "This setup script is currently designed for macOS only"
        echo "For other platforms, please adapt the scripts manually"
        exit 1
    fi
}

# Check for required tools
check_requirements() {
    log "GEAR" "Checking system requirements..."
    
    # Check for git
    if ! command -v git &> /dev/null; then
        log "ERROR" "Git is required but not installed. Please install Xcode Command Line Tools:"
        echo "xcode-select --install"
        exit 1
    fi
    
    # Check for curl
    if ! command -v curl &> /dev/null; then
        log "ERROR" "curl is required but not installed"
        exit 1
    fi
    
    log "SUCCESS" "System requirements met"
}

# Clone or update the dev environment repository
setup_repository() {
    local env_dir="$HOME/dev-environment"
    
    log "GEAR" "Setting up development environment repository..."
    
    if [ -d "$env_dir" ]; then
        log "INFO" "Development environment directory exists, updating..."
        cd "$env_dir"
        git pull origin main
    else
        log "GEAR" "Cloning development environment repository..."
        git clone https://github.com/pedro/pedro-dev-environment.git "$env_dir"
        cd "$env_dir"
    fi
    
    log "SUCCESS" "Repository setup complete"
}

# Install Homebrew and essential tools
install_homebrew() {
    log "GEAR" "Installing Homebrew and essential tools..."
    
    if ! command -v brew &> /dev/null; then
        log "GEAR" "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for current session
        eval "$(/opt/homebrew/bin/brew shellenv)"
        
        log "SUCCESS" "Homebrew installed"
    else
        log "INFO" "Homebrew already installed, updating..."
        brew update
    fi
    
    # Install essential tools
    log "GEAR" "Installing essential development tools..."
    
    local tools=(
        "fnm"              # Fast Node.js Manager
        "pnpm"             # Fast Package Manager
        "git-delta"        # Beautiful Git Diffs
        "bat"              # Better cat with syntax highlighting
        "eza"              # Modern ls with colors and icons
        "ripgrep"          # Super fast search
        "fzf"              # Fuzzy finder
        "jq"               # JSON processor
        "gh"               # GitHub CLI
        "lazygit"          # Terminal Git UI
        "tree"             # Directory tree viewer
        "fswatch"          # File watcher
        "zsh-syntax-highlighting"
        "zsh-autosuggestions"
    )
    
    for tool in "${tools[@]}"; do
        if ! brew list "$tool" &> /dev/null; then
            log "GEAR" "Installing $tool..."
            brew install "$tool"
        else
            log "INFO" "$tool already installed"
        fi
    done
    
    log "SUCCESS" "Essential tools installed"
}

# Setup shell configuration
setup_shell() {
    log "GEAR" "Setting up enhanced shell configuration..."
    
    # Backup existing shell config
    if [ -f "$HOME/.zshrc" ]; then
        log "GEAR" "Backing up existing .zshrc..."
        cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d-%H%M%S)"
    fi
    
    # Copy new shell configuration
    cp configs/.zshrc "$HOME/.zshrc"
    
    # Setup Homebrew environment for current session
    eval "$(/opt/homebrew/bin/brew shellenv)"
    
    log "SUCCESS" "Shell configuration updated"
}

# Setup Git configuration
setup_git() {
    log "GEAR" "Setting up Git configuration..."
    
    # Check if Git is already configured
    if git config --global user.name &> /dev/null && git config --global user.email &> /dev/null; then
        log "INFO" "Git already configured:"
        echo "  Name: $(git config --global user.name)"
        echo "  Email: $(git config --global user.email)"
        echo ""
        echo -n "Update Git configuration? (y/N): "
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            log "INFO" "Keeping existing Git configuration"
            return
        fi
    fi
    
    # Get user information
    echo ""
    echo -n "Enter your full name for Git: "
    read -r git_name
    echo -n "Enter your email for Git: "
    read -r git_email
    
    # Configure Git
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    
    # Copy Git configuration
    cp configs/.gitconfig "$HOME/.gitconfig.pedro-additions"
    
    # Add enhanced Git configuration
    cat configs/.gitconfig >> "$HOME/.gitconfig"
    
    log "SUCCESS" "Git configuration complete"
}

# Install VS Code and extensions
setup_vscode() {
    log "GEAR" "Setting up VS Code and extensions..."
    
    # Check if VS Code is installed
    if ! command -v code &> /dev/null; then
        log "WARNING" "VS Code not found. Please install VS Code manually:"
        echo "https://code.visualstudio.com/download"
        echo ""
        echo -n "Continue setup without VS Code? (y/N): "
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            log "ERROR" "Setup cancelled - VS Code required"
            exit 1
        fi
        return
    fi
    
    # Install extensions
    log "GEAR" "Installing VS Code extensions..."
    
    while IFS= read -r extension; do
        if [ -n "$extension" ] && [[ ! "$extension" =~ ^# ]]; then
            log "GEAR" "Installing extension: $extension"
            code --install-extension "$extension" --force
        fi
    done < configs/vscode-extensions.list
    
    # Copy VS Code settings
    local vscode_dir="$HOME/Library/Application Support/Code/User"
    mkdir -p "$vscode_dir"
    cp configs/vscode-settings.json "$vscode_dir/settings.json"
    
    log "SUCCESS" "VS Code setup complete"
}

# Setup automation system
setup_automation() {
    log "GEAR" "Setting up Blipee automation system..."
    
    # Copy automation system
    local automation_dir="$HOME/.blipee-automation"
    mkdir -p "$automation_dir"
    cp -r automation/blipee-toolpad/* "$automation_dir/"
    
    # Make blipee executable
    chmod +x "$automation_dir/blipee"
    
    # Add blipee to PATH (already in .zshrc)
    log "SUCCESS" "Blipee automation system installed"
}

# Setup Node.js environment
setup_nodejs() {
    log "GEAR" "Setting up Node.js environment..."
    
    # Setup fnm
    eval "$(fnm env --use-on-cd)"
    
    # Install latest LTS Node.js
    fnm install --lts
    fnm use lts-latest
    fnm default lts-latest
    
    # Setup npm global directory
    mkdir -p "$HOME/.npm-global"
    npm config set prefix "$HOME/.npm-global"
    
    # Install global packages
    log "GEAR" "Installing global npm packages..."
    local global_packages=(
        "@anthropic-ai/claude-code"
        "typescript"
        "prettier"
        "eslint"
        "nodemon"
        "serve"
    )
    
    for package in "${global_packages[@]}"; do
        npm install -g "$package"
    done
    
    log "SUCCESS" "Node.js environment setup complete"
}

# Final setup and verification
final_setup() {
    log "GEAR" "Finalizing setup..."
    
    # Create projects directory
    mkdir -p "$HOME/Documents/projects"
    
    # Set up aliases for quick navigation
    echo "alias projects='cd ~/Documents/projects'" >> "$HOME/.zshrc"
    
    # Reload shell configuration
    source "$HOME/.zshrc" 2>/dev/null || true
    
    log "SUCCESS" "Final setup complete"
}

# Verify installation
verify_installation() {
    log "GEAR" "Verifying installation..."
    
    local tools_to_check=(
        "brew" "git" "node" "npm" "pnpm" "fnm"
        "bat" "eza" "rg" "fzf" "jq" "gh" "lazygit"
        "code"
    )
    
    local missing_tools=()
    
    for tool in "${tools_to_check[@]}"; do
        if command -v "$tool" &> /dev/null; then
            log "SUCCESS" "$tool: $(command -v $tool)"
        else
            missing_tools+=("$tool")
            log "WARNING" "$tool: Not found"
        fi
    done
    
    if [ ${#missing_tools[@]} -eq 0 ]; then
        log "SUCCESS" "All tools verified successfully!"
    else
        log "WARNING" "Some tools are missing: ${missing_tools[*]}"
        log "INFO" "You may need to restart your terminal or run 'source ~/.zshrc'"
    fi
}

# Main setup function
main() {
    echo ""
    log "ROCKET" "Pedro's Elite Development Environment Setup v1.0"
    echo ""
    echo "🎯 This will install:"
    echo "   • Homebrew + 15+ premium development tools"
    echo "   • Enhanced shell with 60+ aliases"
    echo "   • VS Code + 20+ professional extensions"
    echo "   • Blipee automation system"
    echo "   • Git configuration with delta diffs"
    echo "   • Node.js LTS with fnm"
    echo ""
    echo -n "Continue with installation? (Y/n): "
    read -r response
    
    if [[ "$response" =~ ^[Nn]$ ]]; then
        log "INFO" "Setup cancelled by user"
        exit 0
    fi
    
    echo ""
    log "ROCKET" "Starting elite development environment setup..."
    echo ""
    
    # Run setup steps
    check_macos
    check_requirements
    setup_repository
    install_homebrew
    setup_shell
    setup_git
    setup_vscode
    setup_automation
    setup_nodejs
    final_setup
    verify_installation
    
    echo ""
    log "SPARKLES" "🎉 Elite development environment setup complete!"
    echo ""
    echo "🚀 Next steps:"
    echo "   1. Restart your terminal or run 'source ~/.zshrc'"
    echo "   2. Open VS Code and verify extensions are loaded"
    echo "   3. Test the automation: 'blipee help'"
    echo "   4. Navigate to projects: 'projects'"
    echo ""
    echo "📚 Documentation available at:"
    echo "   • Setup guide: ~/dev-environment/docs/SETUP.md"
    echo "   • Quick reference: ~/dev-environment/docs/QUICK_REFERENCE.md"
    echo ""
    log "SPARKLES" "Welcome to your elite development environment!"
}

# Run main function
main "$@"