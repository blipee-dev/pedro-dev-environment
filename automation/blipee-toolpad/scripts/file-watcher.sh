#!/bin/bash

# Blipee Toolpad - File Watcher for Automated Code Quality
# Watches for file changes and automatically runs quality checks

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"
AUTOMATION_DIR="$(dirname "$SCRIPT_DIR")"
LOGS_DIR="$AUTOMATION_DIR/logs"

# Ensure logs directory exists
mkdir -p "$LOGS_DIR"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Icons
SUCCESS="✅"
GEAR="⚙️"
SPARKLES="✨"

log() {
    local level=$1
    shift
    local message="$*"
    local timestamp=$(date '+%H:%M:%S')
    
    case $level in
        "SUCCESS") echo -e "${GREEN}${SUCCESS} [$timestamp] $message${NC}" ;;
        "GEAR") echo -e "${BLUE}${GEAR} [$timestamp] $message${NC}" ;;
        "SPARKLES") echo -e "${YELLOW}${SPARKLES} [$timestamp] $message${NC}" ;;
    esac
    
    echo "[$timestamp] [$level] $message" >> "$LOGS_DIR/file-watcher.log"
}

# Check if fswatch is available (install via: brew install fswatch)
if ! command -v fswatch &> /dev/null; then
    echo "❌ fswatch not found. Installing via Homebrew..."
    if command -v brew &> /dev/null; then
        brew install fswatch
    else
        echo "❌ Homebrew not found. Please install fswatch manually:"
        echo "   brew install fswatch"
        exit 1
    fi
fi

# File extensions to watch
WATCH_EXTENSIONS="js|jsx|ts|tsx|css|scss|sass|less|json|md|yml|yaml"

# Directories to watch (relative to project root)
WATCH_DIRS=("src" "pages" "components" "lib" "utils" "styles" ".")

# Directories to exclude
EXCLUDE_DIRS="node_modules|dist|build|.next|.git|coverage|automation/logs"

# Debounce delay (seconds) to avoid rapid-fire triggers
DEBOUNCE_DELAY=2

cd "$PROJECT_ROOT" || exit 1

log "SPARKLES" "Starting file watcher for automated code quality..."
log "GEAR" "Watching: ${WATCH_DIRS[*]}"
log "GEAR" "Extensions: $WATCH_EXTENSIONS"

# Build exclude patterns for fswatch
EXCLUDE_PATTERNS=""
IFS='|' read -ra EXCLUDES <<< "$EXCLUDE_DIRS"
for exclude in "${EXCLUDES[@]}"; do
    EXCLUDE_PATTERNS="$EXCLUDE_PATTERNS --exclude=$exclude"
done

# Track last execution time for debouncing
last_execution=0

# Quality check function
run_quality_checks() {
    local file="$1"
    local current_time=$(date +%s)
    
    # Debounce: only run if enough time has passed
    if [ $((current_time - last_execution)) -lt $DEBOUNCE_DELAY ]; then
        return 0
    fi
    
    last_execution=$current_time
    
    log "GEAR" "File changed: $file"
    log "GEAR" "Running automated quality checks..."
    
    # Check if it's a code file that needs formatting
    if [[ "$file" =~ \.(js|jsx|ts|tsx|css|scss|sass|less|json)$ ]]; then
        
        # Auto-format if prettier is available
        if command -v prettier &> /dev/null && [ -f ".prettierrc" -o -f ".prettierrc.json" -o -f ".prettierrc.js" ]; then
            log "GEAR" "Auto-formatting with Prettier..."
            prettier --write "$file" 2>/dev/null && log "SUCCESS" "Formatted: $file"
        fi
        
        # Auto-fix ESLint issues if it's a JS/TS file
        if [[ "$file" =~ \.(js|jsx|ts|tsx)$ ]] && command -v eslint &> /dev/null; then
            log "GEAR" "Auto-fixing ESLint issues..."
            eslint --fix "$file" 2>/dev/null && log "SUCCESS" "ESLint auto-fixed: $file"
        fi
        
        # Run TypeScript check if it's a TS file and tsconfig exists
        if [[ "$file" =~ \.(ts|tsx)$ ]] && [ -f "tsconfig.json" ] && command -v tsc &> /dev/null; then
            log "GEAR" "Checking TypeScript..."
            tsc --noEmit --skipLibCheck 2>/dev/null && log "SUCCESS" "TypeScript check passed"
        fi
    fi
    
    # If package.json changed, check for new dependencies
    if [[ "$file" == "package.json" ]]; then
        log "GEAR" "package.json changed - checking dependencies..."
        
        if [ ! -d "node_modules" ]; then
            log "GEAR" "Installing dependencies..."
            if command -v pnpm &> /dev/null; then
                pnpm install > "$LOGS_DIR/install.log" 2>&1 && log "SUCCESS" "Dependencies installed"
            else
                npm install > "$LOGS_DIR/install.log" 2>&1 && log "SUCCESS" "Dependencies installed"
            fi
        fi
    fi
    
    # If configuration files changed, reload relevant tools
    if [[ "$file" =~ \.(eslintrc|prettierrc|tsconfig).*$ ]]; then
        log "GEAR" "Configuration file changed: $file"
        log "SUCCESS" "Configuration updated (restart editor to apply changes)"
    fi
    
    # Real-time cleanup: Remove common temporary files
    if [[ "$file" =~ \.(log|tmp|swp|swo)$ ]] && [ -f "$file" ]; then
        # Only clean if file is older than 1 minute (to avoid deleting active files)
        if [ $(( $(date +%s) - $(stat -f %m "$file" 2>/dev/null || echo 0) )) -gt 60 ]; then
            rm -f "$file" 2>/dev/null && log "SUCCESS" "Auto-cleaned: $(basename "$file")"
        fi
    fi
    
    # Clean .DS_Store files immediately
    if [[ "$(basename "$file")" == ".DS_Store" ]]; then
        rm -f "$file" 2>/dev/null && log "SUCCESS" "Auto-cleaned: .DS_Store"
    fi
}

# Start watching files
log "SPARKLES" "File watcher active! Press Ctrl+C to stop."

# Use fswatch to monitor file changes
fswatch -o \
    --event Created \
    --event Updated \
    --event Renamed \
    --recursive \
    $EXCLUDE_PATTERNS \
    "${WATCH_DIRS[@]}" | while read events; do
    
    # Get the list of changed files
    changed_files=$(fswatch -1 \
        --event Created \
        --event Updated \
        --event Renamed \
        $EXCLUDE_PATTERNS \
        "${WATCH_DIRS[@]}" 2>/dev/null)
    
    # Process each changed file
    while IFS= read -r file; do
        if [[ -f "$file" && "$file" =~ \.($WATCH_EXTENSIONS)$ ]]; then
            run_quality_checks "$file"
        fi
    done <<< "$changed_files"
done

# Cleanup on exit
trap 'log "GEAR" "File watcher stopped"; exit 0' INT TERM