# 🚀 Pedro's Elite Development Environment - Quick Reference

## 🤖 Blipee Automation Commands

### **Foundation Commands**
```bash
blipee start       # Start complete development environment (with auto-tidy)
blipee stop        # Stop all development processes
blipee status      # Show comprehensive project status
blipee health      # Run complete system health check
```

### **Intelligent Cleanup System**
```bash
blipee clean       # Auto mode: Level 1 + Level 2 guided cleanup
blipee clean --dry-run # Preview what would be cleaned
blipee clean --deep # Deep mode: All 3 levels + dependency analysis
blipee tidy        # Quick cleanup: build artifacts, logs, cache only
```

### **Quality Assurance**
```bash
blipee pre-dev     # Pre-development quality gate (doc-first + 95% coverage)
blipee coverage    # Check test coverage status
blipee commit "msg" # Smart commit with STRICT quality enforcement
blipee smart-commit # AI-generated commit messages with analysis
blipee watch       # Auto-format, lint, and real-time cleanup
```

## 🐚 Enhanced Shell Aliases

### **Navigation**
```bash
..                 # cd ..
...                # cd ../..
~                  # cd ~
projects           # cd ~/Documents/projects
reload             # source ~/.zshrc
```

### **Git Operations**
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
gd                 # git diff (with beautiful delta)
glog               # git log --oneline --graph
lazygit            # Beautiful terminal Git UI
```

### **File Operations**
```bash
ll                 # Beautiful directory listing
tree               # Directory tree view
cat filename       # Syntax-highlighted viewing
grep pattern       # Super-fast search with ripgrep
```

### **Development Workflow**
```bash
dev                # npm run dev
build              # npm run build
test               # npm test
lint               # npm run lint
format             # npm run format
```

### **Package Management**
```bash
ni                 # npm install
nid                # npm install --save-dev
nr script          # npm run script
pnpm               # Fast package manager
fnm list           # List Node.js versions
fnm use 18         # Switch to Node.js 18
```

## 🎨 VS Code Integration

### **Claude Code Commands**
```bash
cc                 # Interactive Claude Code session
cide               # Claude Code IDE (browser interface)
```

### **Key Shortcuts**
- `Shift+Enter`: Send selected code to Claude terminal
- `Cmd+Shift+P`: Command palette
- `Cmd+P`: Fuzzy file finder
- `Cmd+T`: Symbol search
- `Cmd+/`: Intelligent commenting

## 🔧 Homebrew Tools

### **Installed Premium Tools**
```bash
fnm               # Fast Node.js Manager
pnpm              # Fast Package Manager
git-delta         # Beautiful Git Diffs
bat               # Better cat with syntax highlighting
eza               # Modern ls with colors and icons
ripgrep (rg)      # Super fast search
fzf               # Fuzzy finder
jq                # JSON processor
gh                # GitHub CLI
lazygit           # Terminal Git UI
tree              # Directory tree viewer
fswatch           # File watcher
```

## 🚀 Daily Workflows

### **Morning Startup**
```bash
projects && cd my-project  # Navigate to project
blipee start              # Complete environment setup
```

### **Development Cycle**
```bash
blipee watch              # Enable real-time quality checks
# ... code normally ...
blipee smart-commit       # AI-assisted commit
blipee push              # Safe push with validation
```

### **Quality Assurance**
```bash
blipee pre-dev           # Check quality gates before development
blipee coverage          # Monitor test coverage
blipee clean --dry-run   # Preview cleanup
```

### **Weekly Maintenance**
```bash
blipee clean --deep      # Thorough cleanup and analysis
brew update && brew upgrade  # Update tools
```

## 🎯 Project Setup

### **New Project**
```bash
projects                 # Navigate to projects directory
mkdir my-new-project     # Create project
cd my-new-project        # Enter project
git init                 # Initialize Git
blipee start            # Setup development environment
```

### **Clone Existing Project**
```bash
projects                 # Navigate to projects
gh repo clone user/repo  # Clone with GitHub CLI
cd repo                  # Enter project
blipee start            # Setup environment
```

## 🛠️ Utilities

### **System Information**
```bash
blipee health           # Comprehensive system check
brew doctor            # Check Homebrew health
fnm list               # Available Node.js versions
```

### **File Management**
```bash
backup filename        # Create timestamped backup
extract archive.zip    # Extract various archive formats
findps processname     # Find running processes
killps processname     # Kill process by name
```

### **Network & Utilities**
```bash
myip                   # Get external IP address
weather                # Get weather forecast
h                      # History search
```

## 🧹 Cleanup Levels Explained

### **🟢 Level 1: Safe Auto-Cleanup**
- Build artifacts: `dist/`, `build/`, `.next/`, `coverage/`
- Cache directories: `node_modules/.cache`, `.npm/`, `.pnpm-store/`
- Log files: `*.log`, `npm-debug.log*`
- OS/Editor temps: `.DS_Store`, `*.swp`, `*.tmp`

### **🟡 Level 2: Guided Cleanup**
- Backup files: `*.backup`, `*.bak`, `*.old`
- Large files: Files >5MB not in build directories
- Package conflicts: Multiple lock files
- User confirmation required

### **🔴 Level 3: Deep Analysis**
- Unused dependencies: Not found in source code
- Orphaned files: Source files not imported
- Manual review recommended

## 🎨 Customization

### **Add Personal Aliases**
```bash
echo 'alias myalias="command"' >> ~/.zshrc
reload
```

### **Add VS Code Extensions**
```bash
code --install-extension publisher.extension-name
```

### **Update Git Configuration**
```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

---

**💡 Tip**: Bookmark this reference for quick access to all commands!