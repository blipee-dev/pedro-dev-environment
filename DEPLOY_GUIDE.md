# 🚀 Quick Deployment Guide

## Option 1: Use the Interactive Script (Recommended)
```bash
cd ~/Documents/pedro-dev-environment
./scripts/deploy-to-github.sh
```

## Option 2: Manual Steps

### Step 1: Create GitHub Repository
1. Go to [github.com/new](https://github.com/new)
2. Repository name: `pedro-dev-environment`
3. Description: `🚀 One-command setup for elite development environment`
4. Make it **Public**
5. **Don't check any initialization options**
6. Click "Create repository"

### Step 2: Push to GitHub
```bash
cd ~/Documents/pedro-dev-environment

# Replace 'yourusername' with your actual GitHub username
git remote add origin https://github.com/yourusername/pedro-dev-environment.git
git branch -M main
git push -u origin main
```

### Step 3: Test Installation
```bash
# Replace 'yourusername' with your GitHub username
curl -s https://raw.githubusercontent.com/yourusername/pedro-dev-environment/main/setup.sh | bash
```

## That's it! 🎉

Your elite development environment is now available on any workstation with one command!