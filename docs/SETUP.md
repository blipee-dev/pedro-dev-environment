# 🚀 Pedro's Elite Development Environment - Setup Guide

## Overview
This repository contains Pedro's world-class development environment configuration, designed for maximum productivity across multiple workstations.

## 🎯 What This Installs

### **🛠️ Core Tools**
- **Homebrew**: macOS package manager
- **fnm**: Fast Node.js version manager
- **pnpm**: Lightning-fast package manager
- **Git Delta**: Beautiful diff viewer
- **Modern CLI Tools**: bat, eza, ripgrep, fzf, jq, gh, lazygit

### **🎨 Development Environment**
- **VS Code**: 20+ professional extensions
- **Enhanced Shell**: 60+ aliases and functions
- **Git Configuration**: Professional Git setup with delta diffs
- **Node.js LTS**: Latest stable Node.js with global packages

### **🤖 Automation System**
- **Blipee Toolpad**: Complete development automation
- **3-Level Cleanup**: Intelligent workspace management
- **Quality Enforcement**: 95% test coverage, 100% test pass rate
- **AI-Assisted Workflows**: Smart commits and documentation

## 🚀 Quick Installation

### **One-Command Setup (Recommended)**
```bash
curl -s https://raw.githubusercontent.com/pedro/pedro-dev-environment/main/setup.sh | bash
```

### **Manual Installation**
```bash
# Clone repository
git clone https://github.com/pedro/pedro-dev-environment.git ~/dev-environment
cd ~/dev-environment

# Run setup
./setup.sh
```

## 📋 Installation Steps

The setup script will:

1. **✅ System Check**: Verify macOS and requirements
2. **📥 Repository Setup**: Clone/update environment repository
3. **🍺 Homebrew Installation**: Install package manager and tools
4. **🐚 Shell Configuration**: Setup enhanced .zshrc with aliases
5. **🔧 Git Configuration**: Professional Git setup
6. **💻 VS Code Setup**: Install extensions and settings
7. **🤖 Automation Setup**: Install Blipee system
8. **📦 Node.js Setup**: Install LTS with global packages
9. **✨ Final Configuration**: Create directories and verify installation

## 🎯 Post-Installation

### **Essential Commands to Try**
```bash
# Test automation system
blipee help

# Navigate to projects
projects

# Beautiful file listing
ll

# Git with beautiful diffs
glog

# Modern search
rg "pattern"

# Start Claude Code
cc
```

### **Create Your First Project**
```bash
# Navigate to projects directory
projects

# Create new project
mkdir my-awesome-project
cd my-awesome-project

# Initialize with automation
git init
blipee start
```

## 🔧 Customization

### **Add Personal Git Configuration**
The setup will prompt for your name and email, but you can update anytime:
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### **Customize Aliases**
Edit `~/.zshrc` to add personal aliases:
```bash
# Add custom aliases
echo 'alias myproject="cd ~/Documents/projects/my-project"' >> ~/.zshrc
source ~/.zshrc
```

### **VS Code Extensions**
Add more extensions by editing `configs/vscode-extensions.list`

## 🌐 Multi-Workstation Sync

### **Setup on New Workstation**
1. Run the one-command setup
2. Clone your projects
3. Start developing immediately

### **Keep Environment Updated**
```bash
cd ~/dev-environment
git pull origin main
./setup.sh  # Re-run to update
```

### **Sync Personal Configurations**
```bash
# Backup current configs
cp ~/.zshrc ~/dev-environment/configs/.zshrc
cp ~/.gitconfig ~/dev-environment/configs/.gitconfig

# Commit changes
cd ~/dev-environment
git add configs/
git commit -m "Update personal configurations"
git push
```

## 🛡️ Safety Features

- **Backup Protection**: Existing configs are backed up before replacement
- **Non-Destructive**: Only adds/updates, never removes existing setup
- **Verification**: Post-install verification ensures everything works
- **Rollback**: Easy to restore from backups if needed

## 🚨 Troubleshooting

### **Command Not Found**
```bash
# Reload shell configuration
source ~/.zshrc

# Check PATH
echo $PATH
```

### **VS Code Extensions Not Working**
```bash
# Manually install extensions
while read extension; do
  code --install-extension "$extension"
done < ~/dev-environment/configs/vscode-extensions.list
```

### **Homebrew Issues**
```bash
# Reinstall Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### **Node.js Issues**
```bash
# Reinstall Node.js with fnm
fnm install --lts
fnm use lts-latest
fnm default lts-latest
```

## 📚 Documentation Links

- **[Quick Reference](./QUICK_REFERENCE.md)**: Daily commands and workflows
- **[Automation Guide](../automation/blipee-toolpad/AUTOMATION.md)**: Blipee system documentation
- **[Project Workflow](../automation/blipee-toolpad/PROJECT_WORKFLOW.md)**: Development best practices

## 🤝 Contributing

### **Update Environment**
1. Make changes to configuration files
2. Test on clean system
3. Update documentation
4. Submit pull request

### **Add New Tools**
1. Add to `setup.sh` installation section
2. Update documentation
3. Test cross-platform compatibility

## 📞 Support

- **Issues**: Report bugs or feature requests
- **Discussions**: Share improvements and tips
- **Wiki**: Extended documentation and tutorials

---

**🎯 Ready to experience elite-level development productivity!**