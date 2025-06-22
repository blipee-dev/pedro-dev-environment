# 🛠️ Elite Development Tools - Quick Reference

## 🚀 Claude Code Integration

### Primary Commands
```bash
cc                  # Interactive Claude Code session
cide               # Claude Code IDE (browser interface)
claude --help      # Show all available commands
claude --version   # Check version
```

### VS Code Integration
- **Shift+Enter**: Send selected code to Claude terminal
- **Command Palette**: Search "Claude" for all available commands
- **Status Bar**: Shows Claude connection status

## 🎯 Modern Shell Aliases

### File Operations (Enhanced)
```bash
ll                 # eza -la --color --group-directories-first
ls                 # eza --color --group-directories-first  
tree               # eza --tree --color
cat filename       # bat --style=auto filename
grep pattern       # rg pattern (ripgrep)
find name          # Enhanced file finding
```

### Git Operations (Premium)
```bash
gs                 # git status -sb
ga                 # git add
gaa                # git add --all
gc                 # git commit -v
gcm "message"      # git commit -m "message"
gco branch         # git checkout branch
gcb new-branch     # git checkout -b new-branch
gp                 # git push
gl                 # git pull
gd                 # git diff (with delta pager)
gdc                # git diff --cached
glog               # git log --oneline --graph --decorate
grb                # git rebase
grbi               # git rebase -i
gsta               # git stash push
gstp               # git stash pop
lazygit            # Terminal Git UI
```

### Development Workflow
```bash
dev                # npm run dev
build              # npm run build
test               # npm test
lint               # npm run lint
format             # npm run format
preview            # npm run preview
```

### Package Management
```bash
ni                 # npm install
nid                # npm install --save-dev
nig                # npm install -g
nr script          # npm run script
pnpm              # Fast package manager
fnm list          # List Node.js versions
fnm use 18        # Switch to Node.js 18
```

### Navigation & Utilities
```bash
..                 # cd ..
...                # cd ../..
~                  # cd ~
projects           # cd ~/Documents
downloads          # cd ~/Downloads
desktop            # cd ~/Desktop
reload             # source ~/.zshrc
myip               # curl -s https://ipinfo.io/ip
weather            # curl wttr.in
```

## 🤖 Blipee Automation System

### Foundation Commands
```bash
blipee start       # Start complete development environment (with auto-tidy)
blipee stop        # Stop all development processes
blipee status      # Show comprehensive project status
blipee health      # Run complete system health check
```

### Intelligent Cleanup System (3 Levels)
```bash
blipee clean       # Auto mode: Level 1 + Level 2 guided cleanup
blipee clean --safe # Safe mode: Level 1 only (build artifacts, cache, logs)
blipee clean --deep # Deep mode: All 3 levels + unused dependency analysis
blipee clean --dry-run # Preview what would be cleaned (no changes)
blipee tidy        # Quick cleanup: Level 1 only (build artifacts, logs, cache)
```

#### Cleanup Levels Explained:
- **🟢 Level 1**: Safe auto-cleanup (dist/, build/, .next/, logs/, .DS_Store, cache)
- **🟡 Level 2**: Guided cleanup (backup files, duplicates, conflicts) - with confirmation
- **🔴 Level 3**: Deep analysis (unused dependencies, orphaned files) - manual review

### Git Workflow Automation
```bash
blipee commit "msg" # Smart commit with STRICT quality enforcement
blipee push        # Safe push with pre-push validation
blipee sync        # Sync with remote (pull + push)
blipee branch name # Create branch with naming conventions
```

### Quality Assurance Automation
```bash
blipee format      # Auto-format all code
blipee lint        # Run linting with auto-fix
blipee test        # Run comprehensive test suite
blipee check       # Run all quality checks
blipee watch       # Start file watcher for auto-quality + real-time cleanup
blipee watch-stop  # Stop file watcher
```

### AI-Assisted Development
```bash
blipee smart-commit # AI-generated commit messages with analysis
blipee auto-test   # Generate and run tests for new files
blipee refactor    # AI-guided refactoring analysis
blipee docs        # Generate comprehensive documentation
blipee pre-dev     # Pre-development documentation + quality check
blipee coverage    # Check test coverage status (95% minimum enforced)
```

### Utility Commands
```bash
blipee logs        # View automation logs
blipee version     # Show version information
blipee help        # Show comprehensive help
```

## 🔧 Homebrew Tools

### Installed Premium Tools
```bash
fnm               # Fast Node.js Manager
pnpm              # Fast Package Manager (2x faster than npm)
git-delta         # Beautiful Git Diffs
bat               # Better cat with syntax highlighting
eza               # Modern ls with colors and icons
ripgrep (rg)      # Super fast search (10x faster than grep)
fzf               # Fuzzy finder
jq                # JSON processor
gh                # GitHub CLI
lazygit           # Terminal Git UI
tree              # Directory tree viewer
zsh-syntax-highlighting  # Command syntax highlighting
zsh-autosuggestions     # Smart command suggestions
```

### Usage Examples
```bash
# File viewing with syntax highlighting
bat src/main.js

# Super fast search
rg "useState" --type js

# Interactive file finder
fzf

# JSON processing
cat data.json | jq '.users[] | .name'

# GitHub operations
gh repo list
gh pr create
gh issue list

# Beautiful directory tree
tree -L 3

# Git operations with beautiful UI
lazygit
```

## 🎨 VS Code Extensions Quick Reference

### AI & Intelligence
- **Claude Code**: Primary AI assistant (Shift+Enter to send code)
- **GitHub Copilot**: Inline AI completions
- **GitHub Copilot Chat**: AI chat interface

### Code Quality
- **Error Lens**: Inline error/warning display
- **ESLint**: Auto-fix on save
- **Prettier**: Format on save/paste/type
- **Import Cost**: Bundle size analysis (shows in editor)

### Git & Version Control
- **GitLens**: Hover for blame info, click for history
- **Git Graph**: Visual commit history

### Productivity
- **Auto Rename Tag**: Sync HTML/JSX tag editing
- **Path Intellisense**: Auto-complete file paths
- **TODO Highlight**: Highlights TODO/FIXME comments
- **Better Comments**: Color-coded comment styles

### Styling & UI
- **Tailwind CSS**: IntelliSense for utility classes
- **Color Highlight**: Visual color indicators
- **CSS Peek**: Navigate to CSS definitions

### Development Tools
- **Thunder Client**: API testing (built-in Postman alternative)
- **Live Server**: Local development server
- **Project Manager**: Quick project switching

## ⌨️ Enhanced Keyboard Shortcuts

### VS Code Optimized
```
Shift+Enter        # Send to Claude Code terminal
Cmd+Shift+P        # Command palette (enhanced)
Cmd+P              # Fuzzy file finder
Cmd+T              # Symbol search across project
Cmd+/              # Intelligent commenting
Cmd+D              # Multi-cursor selection
Cmd+Shift+L        # Select all occurrences
Cmd+F2             # Rename symbol
F12                # Go to definition
Shift+F12          # Find all references
```

### Terminal Shortcuts
```
Ctrl+R             # Search command history
Ctrl+A             # Beginning of line
Ctrl+E             # End of line
Ctrl+K             # Delete to end of line
Ctrl+U             # Delete to beginning of line
```

## 🚀 AI-Powered Development Workflow

### 1. Planning Phase
```bash
cc
# "I need to implement user authentication. Help me plan the architecture."
# "What's the best approach for state management in this React app?"
# "How should I structure the API endpoints for user management?"
```

### 2. Implementation Phase
- **Claude Code**: Architecture, complex logic, problem-solving
- **GitHub Copilot**: Code completions, boilerplate, patterns
- **Error Lens**: Real-time error detection and suggestions

### 3. Quality Assurance
```bash
# Real-time quality checks
lint              # ESLint with auto-fix
test              # Run test suite
build             # Verify production build

# AI-powered code review
cc
# "Please review this code for potential issues and optimizations"
```

### 4. Git Workflow
```bash
gs                # Check status with beautiful formatting
gd                # View diff with syntax highlighting
lazygit           # Visual Git operations for complex tasks
gcm "feat: add user authentication"
gp                # Push with enhanced feedback
```

## 🔍 Advanced Search & Navigation

### Project-wide Search
```bash
# Find in files (super fast)
rg "pattern" --type js
rg "useState" -A 3 -B 3    # Show context lines
rg "api" --files-with-matches

# Interactive search
fzf               # Fuzzy find files
fzf --preview 'bat {}'    # With file preview
```

### File Operations
```bash
# Beautiful file listing
ll                # Detailed list with colors and icons
tree -L 3         # Directory tree (3 levels deep)
bat file.js       # View file with syntax highlighting
bat -n file.js    # With line numbers
```

## 📦 Package Management Best Practices

### Modern Package Management
```bash
# Use pnpm for speed (2x faster than npm)
pnpm install
pnpm add react-query
pnpm add -D typescript

# Node.js version management
fnm list          # Available versions
fnm use 18        # Switch to Node 18
fnm install latest # Install latest Node.js
```

### Dependency Analysis
- **Import Cost**: Real-time bundle size impact in VS Code
- **Security**: Regular `pnpm audit` for vulnerabilities
- **Updates**: Check with `pnpm outdated`

## 🎯 Performance Optimization Tools

### Real-time Monitoring
- **Error Lens**: Performance warnings inline
- **Import Cost**: Bundle size impact visualization
- **TypeScript**: Strict mode for better optimization

### Build Analysis
```bash
build             # Optimized production build
preview           # Preview production build locally
pnpm analyze      # Bundle analysis (if configured)
```

## 🛡️ Security & Best Practices

### Code Security
- **ESLint Security Rules**: Automatic vulnerability detection
- **Git Hooks**: Pre-commit security checks
- **Environment Variables**: Secure handling with global gitignore

### Development Security
```bash
# Check for vulnerabilities
pnpm audit
pnpm audit --fix

# Secure Git operations
gh auth status    # Check GitHub authentication
```

## 🎨 Theming & UI Customization

### Fonts
- **JetBrains Mono**: Primary coding font with ligatures
- **Fira Code**: Alternative with programming ligatures

### VS Code Themes
- **Night Owl**: Dark theme optimized for long coding sessions
- **Material Icon Theme**: Professional file type icons

### Terminal Enhancements
- **Syntax Highlighting**: Real-time command coloring
- **Auto-suggestions**: Smart command completions based on history
- **Custom Prompt**: Clean, informative display with git status

## 🚀 Quick Start Commands

### Daily Startup
```bash
projects && cd blipee/blipee-toolpad  # Navigate to project
cide &                                # Start Claude IDE
gs                                    # Check Git status
ll                                    # View project files
dev                                   # Start development server
```

### Feature Development
```bash
gcb feature/new-feature              # Create feature branch
cc                                   # Plan with Claude Code
# Implement with VS Code + AI assistance
lint && test && build                # Quality checks
lazygit                              # Visual Git operations
```

### Troubleshooting
```bash
rg "error" --type js                 # Find errors in JS files
bat error.log                        # View logs with highlighting
gh issue list                        # Check GitHub issues
cc                                   # Get AI assistance for debugging
```

---

## 📚 Additional Resources

### Documentation
- **Claude Code Docs**: https://docs.anthropic.com/en/docs/claude-code
- **VS Code Tips**: Use `Cmd+Shift+P` and search for specific features
- **Git Delta**: Enhanced diff viewing with syntax highlighting
- **Homebrew**: Package manager for additional tools

### Pro Tips
1. **Use `reload`** after making shell configuration changes
2. **Combine tools**: `rg pattern | fzf` for interactive search
3. **Leverage AI**: Ask Claude Code for architecture decisions
4. **Visual Git**: Use `lazygit` for complex merge operations
5. **Real-time feedback**: Trust Error Lens for immediate issue detection

*This elite development environment is optimized for maximum productivity and code quality.* 🚀