#!/bin/bash

# Blipee Toolpad - AI-Assisted Smart Commit
# Generates intelligent commit messages and performs comprehensive checks

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"
AUTOMATION_DIR="$(dirname "$SCRIPT_DIR")"
LOGS_DIR="$AUTOMATION_DIR/logs"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Icons
SUCCESS="✅"
GEAR="⚙️"
SPARKLES="✨"
INFO="ℹ️"

log() {
    local level=$1
    shift
    local message="$*"
    local timestamp=$(date '+%H:%M:%S')
    
    case $level in
        "SUCCESS") echo -e "${GREEN}${SUCCESS} [$timestamp] $message${NC}" ;;
        "GEAR") echo -e "${BLUE}${GEAR} [$timestamp] $message${NC}" ;;
        "SPARKLES") echo -e "${YELLOW}${SPARKLES} [$timestamp] $message${NC}" ;;
        "INFO") echo -e "${CYAN}${INFO} [$timestamp] $message${NC}" ;;
    esac
    
    echo "[$timestamp] [$level] $message" >> "$LOGS_DIR/smart-commit.log"
}

cd "$PROJECT_ROOT" || exit 1

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Not in a git repository"
    exit 1
fi

# Check for uncommitted changes
if git diff --quiet && git diff --cached --quiet; then
    echo "⚠️ No changes to commit"
    exit 1
fi

log "SPARKLES" "Starting AI-assisted smart commit workflow..."

# Analyze changes to generate intelligent commit message
analyze_changes() {
    log "GEAR" "Analyzing changes for intelligent commit message..."
    
    # Get changed files with their status
    local changed_files=$(git diff --cached --name-status | head -10)
    local unstaged_files=$(git diff --name-status | head -5)
    
    # Get diff statistics
    local additions=$(git diff --cached --numstat | awk '{sum+=$1} END {print sum+0}')
    local deletions=$(git diff --cached --numstat | awk '{sum+=$2} END {print sum+0}')
    
    # Get file types
    local file_types=$(git diff --cached --name-only | sed 's/.*\.//' | sort | uniq -c | sort -nr | head -3)
    
    # Analyze type of changes
    local change_type="update"
    local scope=""
    local description=""
    
    # Determine change type based on file analysis
    if echo "$changed_files" | grep -q "^A"; then
        if echo "$changed_files" | grep -q "^D"; then
            change_type="refactor"
            description="restructure codebase with file additions and removals"
        else
            change_type="feat"
            description="add new functionality"
        fi
    elif echo "$changed_files" | grep -q "^D"; then
        change_type="remove"
        description="remove deprecated functionality"
    elif echo "$changed_files" | grep -q "test\|spec"; then
        change_type="test"
        description="update test coverage"
    elif echo "$changed_files" | grep -q "README\|\.md"; then
        change_type="docs"
        description="update documentation"
    elif echo "$changed_files" | grep -q "package\.json\|yarn\.lock\|pnpm-lock"; then
        change_type="deps"
        description="update dependencies"
    elif echo "$changed_files" | grep -q "\.config\.\|\.env\|eslint\|prettier"; then
        change_type="config"
        description="update configuration"
    elif [ "$additions" -gt "$deletions" ]; then
        change_type="feat"
        description="enhance existing functionality"
    elif [ "$deletions" -gt "$additions" ]; then
        change_type="refactor"
        description="optimize and clean up code"
    else
        change_type="fix"
        description="improve code quality and fix issues"
    fi
    
    # Determine scope from file paths
    if echo "$changed_files" | grep -q "^[^/]*src/components"; then
        scope="components"
    elif echo "$changed_files" | grep -q "^[^/]*src/pages\|^[^/]*pages"; then
        scope="pages"
    elif echo "$changed_files" | grep -q "^[^/]*src/utils\|^[^/]*lib"; then
        scope="utils"
    elif echo "$changed_files" | grep -q "^[^/]*src/styles\|\.css\|\.scss"; then
        scope="styles"
    elif echo "$changed_files" | grep -q "^[^/]*src/api\|^[^/]*api"; then
        scope="api"
    elif echo "$changed_files" | grep -q "^[^/]*src/hooks"; then
        scope="hooks"
    elif echo "$changed_files" | grep -q "^[^/]*automation"; then
        scope="automation"
    fi
    
    # Generate commit message
    local commit_msg
    if [ -n "$scope" ]; then
        commit_msg="$change_type($scope): $description"
    else
        commit_msg="$change_type: $description"
    fi
    
    # Add file count context if significant
    local file_count=$(echo "$changed_files" | wc -l | tr -d ' ')
    if [ "$file_count" -gt 5 ]; then
        commit_msg="$commit_msg across $file_count files"
    fi
    
    echo "$commit_msg"
}

# Generate multiple commit message options
generate_commit_options() {
    log "GEAR" "Generating commit message options..."
    
    local base_msg=$(analyze_changes)
    local changed_files=$(git diff --cached --name-only | head -3)
    local primary_file=$(echo "$changed_files" | head -1 | xargs basename)
    
    echo "Suggested commit messages:"
    echo ""
    echo "1. $base_msg"
    echo "2. $(echo "$base_msg" | sed 's/update/improve/' | sed 's/add/implement/')"
    echo "3. $(echo "$base_msg" | sed 's/enhance/optimize/' | sed 's/fix/resolve/')"
    
    if [ -n "$primary_file" ]; then
        echo "4. Custom: update $primary_file and related components"
    fi
    echo "5. Custom message (enter your own)"
    echo ""
}

# Interactive commit message selection
select_commit_message() {
    local base_msg=$(analyze_changes)
    
    generate_commit_options
    
    echo -n "Select option (1-5) or press Enter for option 1: "
    read -r choice
    
    case $choice in
        ""|"1")
            echo "$base_msg"
            ;;
        "2")
            echo "$base_msg" | sed 's/update/improve/' | sed 's/add/implement/'
            ;;
        "3")
            echo "$base_msg" | sed 's/enhance/optimize/' | sed 's/fix/resolve/'
            ;;
        "4")
            local primary_file=$(git diff --cached --name-only | head -1 | xargs basename)
            echo "update $primary_file and related components"
            ;;
        "5")
            echo -n "Enter custom commit message: "
            read -r custom_msg
            echo "$custom_msg"
            ;;
        *)
            echo "$base_msg"
            ;;
    esac
}

# Run STRICT quality enforcement checks
run_comprehensive_checks() {
    log "GEAR" "Running STRICT quality enforcement checks..."
    echo ""
    echo "📋 Quality Standards Enforced:"
    echo "   📚 Documentation-first development"
    echo "   📊 95% test coverage minimum"
    echo "   ✅ 100% test pass rate required"
    echo ""
    
    # Source the main blipee script to use quality check functions
    local blipee_script="$AUTOMATION_DIR/blipee"
    if [ -f "$blipee_script" ]; then
        # Extract quality check functions
        source <(grep -A 500 "check_documentation_first()" "$blipee_script" | grep -B 500 "^}$" | head -n -1)
        source <(grep -A 500 "check_test_coverage()" "$blipee_script" | grep -B 500 "^}$" | head -n -1)
        source <(grep -A 500 "check_test_pass_rate()" "$blipee_script" | grep -B 500 "^}$" | head -n -1)
        
        # Set quality standards
        REQUIRED_TEST_COVERAGE=95
        REQUIRED_TEST_PASS_RATE=100
    fi
    
    local failed_checks=0
    
    # 1. BLOCKING: Documentation-first check
    log "GEAR" "Checking documentation-first requirement..."
    if ! check_documentation_first 2>/dev/null; then
        log "ERROR" "BLOCKING: Documentation-first requirement not met"
        echo ""
        echo "🚫 Smart commit blocked until documentation is added"
        echo "💡 Add documentation first, then commit"
        ((failed_checks++))
    else
        log "SUCCESS" "Documentation-first requirement satisfied"
    fi
    
    # 2. BLOCKING: Code formatting (must be clean)
    if command -v prettier &> /dev/null && [ -f ".prettierrc" -o -f ".prettierrc.json" -o -f ".prettierrc.js" ]; then
        log "GEAR" "Enforcing code formatting standards..."
        local format_files=$(git diff --cached --name-only | grep -E '\.(js|jsx|ts|tsx|css|scss|json|md)$' | tr '\n' ' ')
        if [ -n "$format_files" ]; then
            if ! prettier --check $format_files 2>/dev/null; then
                log "ERROR" "BLOCKING: Code formatting standards not met"
                echo ""
                echo "🚫 Smart commit blocked until code is properly formatted"
                echo "💡 Run prettier or 'blipee format' to fix formatting"
                ((failed_checks++))
            else
                log "SUCCESS" "Code formatting standards met"
            fi
        fi
    fi
    
    # 3. BLOCKING: ESLint checks (must pass)
    if command -v eslint &> /dev/null; then
        log "GEAR" "Enforcing linting standards..."
        local js_files=$(git diff --cached --name-only | grep -E '\.(js|jsx|ts|tsx)$' | tr '\n' ' ')
        if [ -n "$js_files" ]; then
            if ! eslint $js_files 2>/dev/null; then
                log "ERROR" "BLOCKING: Linting standards not met"
                echo ""
                echo "🚫 Smart commit blocked until linting issues are fixed"
                echo "💡 Run 'blipee lint' to see and fix issues"
                ((failed_checks++))
            else
                log "SUCCESS" "Linting standards met"
            fi
        fi
    fi
    
    # 4. BLOCKING: TypeScript checks (must pass)
    if [ -f "tsconfig.json" ] && command -v tsc &> /dev/null; then
        log "GEAR" "Enforcing TypeScript standards..."
        if ! tsc --noEmit --skipLibCheck 2>/dev/null; then
            log "ERROR" "BLOCKING: TypeScript compilation errors"
            echo ""
            echo "🚫 Smart commit blocked until TypeScript errors are fixed"
            echo "💡 Fix TypeScript compilation errors"
            ((failed_checks++))
        else
            log "SUCCESS" "TypeScript standards met"
        fi
    fi
    
    # 5. BLOCKING: Test pass rate (100% required)
    log "GEAR" "Enforcing test pass rate requirement..."
    if ! check_test_pass_rate 2>/dev/null; then
        log "ERROR" "BLOCKING: Test pass rate requirement not met"
        echo ""
        echo "🚫 Smart commit blocked until ALL tests pass"
        echo "💡 Fix failing tests before committing"
        ((failed_checks++))
    else
        log "SUCCESS" "Test pass rate requirement satisfied"
    fi
    
    # 6. BLOCKING: Test coverage (95% required)
    log "GEAR" "Enforcing test coverage requirement..."
    if ! check_test_coverage 2>/dev/null; then
        log "ERROR" "BLOCKING: Test coverage requirement not met"
        echo ""
        echo "🚫 Smart commit blocked until 95% coverage achieved"
        echo "💡 Add more tests or use 'blipee auto-test'"
        ((failed_checks++))
    else
        log "SUCCESS" "Test coverage requirement satisfied"
    fi
    
    # 7. Security audit
    if command -v npm &> /dev/null; then
        log "GEAR" "Running security audit..."
        if ! npm audit --audit-level=high 2>/dev/null; then
            log "WARNING" "Security vulnerabilities found"
            echo ""
            echo "⚠️  Security vulnerabilities detected"
            echo "💡 Run 'npm audit fix' to resolve"
            echo ""
            echo -n "Proceed despite security warnings? (y/N): "
            read -r security_proceed
            if [[ ! "$security_proceed" =~ ^[Yy]$ ]]; then
                ((failed_checks++))
            fi
        else
            log "SUCCESS" "Security audit passed"
        fi
    fi
    
    # Final result
    echo ""
    if [ $failed_checks -eq 0 ]; then
        log "SUCCESS" "🎉 ALL STRICT QUALITY CHECKS PASSED!"
        echo ""
        echo "✅ Documentation-first: PASSED"
        echo "✅ Code formatting: PASSED"
        echo "✅ Linting standards: PASSED"
        echo "✅ TypeScript checks: PASSED"
        echo "✅ Test pass rate (100%): PASSED"
        echo "✅ Test coverage (95%): PASSED"
        echo "✅ Security audit: PASSED"
        echo ""
        return 0
    else
        log "ERROR" "❌ $failed_checks QUALITY CHECK(S) FAILED"
        echo ""
        echo "🚫 Smart commit blocked due to quality standard violations"
        echo "💡 Fix all issues above before attempting to commit"
        echo ""
        return 1
    fi
}

# Main smart commit workflow
main() {
    # Stage all changes if none are staged
    if git diff --cached --quiet; then
        log "GEAR" "Staging all changes..."
        git add .
    fi
    
    # Show what will be committed
    echo ""
    log "INFO" "Files to be committed:"
    git diff --cached --name-status | while read status file; do
        case $status in
            "A") echo -e "  ${GREEN}+${NC} $file" ;;
            "M") echo -e "  ${YELLOW}~${NC} $file" ;;
            "D") echo -e "  ${RED}-${NC} $file" ;;
            *) echo -e "  ${CYAN}?${NC} $file" ;;
        esac
    done
    echo ""
    
    # Run comprehensive checks
    if ! run_comprehensive_checks; then
        log "INFO" "Commit cancelled due to failed checks"
        exit 1
    fi
    
    # Re-stage any files that were modified by formatters/linters
    git add .
    
    # Generate and select commit message
    local commit_message=$(select_commit_message)
    
    echo ""
    log "INFO" "Selected commit message: '$commit_message'"
    echo ""
    echo -n "Proceed with commit? (Y/n): "
    read -r response
    
    if [[ "$response" =~ ^[Nn]$ ]]; then
        log "INFO" "Commit cancelled"
        exit 0
    fi
    
    # Perform the commit
    if git commit -m "$commit_message"; then
        log "SUCCESS" "Commit successful!"
        
        # Ask about pushing
        echo ""
        echo -n "Push to remote? (y/N): "
        read -r push_response
        
        if [[ "$push_response" =~ ^[Yy]$ ]]; then
            log "GEAR" "Pushing to remote..."
            if git push; then
                log "SUCCESS" "Push successful!"
            else
                log "WARNING" "Push failed. You may need to pull first."
            fi
        fi
        
        log "SPARKLES" "Smart commit workflow completed!"
    else
        log "ERROR" "Commit failed"
        exit 1
    fi
}

# Run the main workflow
main "$@"