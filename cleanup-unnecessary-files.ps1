# cleanup-unnecessary-files.ps1
# Script to remove unnecessary files from Passport Issuing project

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Passport Issuing - Cleanup Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Get the script directory (project root)
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

Write-Host "Current directory: $scriptPath" -ForegroundColor Yellow
Write-Host ""

# Function to safely remove files/directories
function Remove-Safe {
    param(
        [string]$Path,
        [string]$Description
    )
    
    if (Test-Path $Path) {
        Write-Host "Removing: $Description" -ForegroundColor Red
        try {
            Remove-Item -Path $Path -Recurse -Force -ErrorAction Stop
            Write-Host "  ✓ Removed successfully" -ForegroundColor Green
            return $true
        }
        catch {
            Write-Host "  ✗ Error: $_" -ForegroundColor Red
            return $false
        }
    }
    else {
        Write-Host "Skipping: $Description (not found)" -ForegroundColor Gray
        return $false
    }
}

# Count items to be removed
$removedCount = 0

Write-Host "=== STEP 1: Removing Duplicate 'Passport Issuing' Directory ===" -ForegroundColor Cyan
$removedCount += if (Remove-Safe -Path "Passport Issuing" -Description "Duplicate 'Passport Issuing' directory") { 1 } else { 0 }

Write-Host ""
Write-Host "=== STEP 2: Removing Build Artifacts ===" -ForegroundColor Cyan
$removedCount += if (Remove-Safe -Path "target" -Description "Maven target directory") { 1 } else { 0 }
$removedCount += if (Remove-Safe -Path "out" -Description "IDE output directory") { 1 } else { 0 }

Write-Host ""
Write-Host "=== STEP 3: Removing IDE Configuration Files ===" -ForegroundColor Cyan
$removedCount += if (Remove-Safe -Path "Passport_Issuing.iml" -Description "IntelliJ module file") { 1 } else { 0 }

Write-Host ""
Write-Host "=== STEP 4: Removing Temporary Documentation Files ===" -ForegroundColor Cyan
$tempDocs = @(
    "DO_THIS_NOW.txt",
    "CHECK_TOMCAT_LOGS.txt",
    "PAYMENT_FIXED_SUMMARY.txt",
    "DEPLOY_NOW.md",
    "FIX_COMPLETE.md",
    "PAYMENT_ERROR_FIXED.md",
    "PAYMENT_FIX_APPLIED.md",
    "PAYMENT_FIX_GUIDE.md",
    "PAYMENT_SAME_PAGE_COMPLETE.md",
    "PAYMENT_SYSTEM_COMPLETE.md",
    "ENHANCED_PAYMENT_COMPLETE.md",
    "PAYMENT_APPROVAL_REBUILT.md",
    "PAYMENT_APPROVAL_SYSTEM_COMPLETE.md",
    "PAYMENT_APPROVAL_TEST_GUIDE.md",
    "PAYMENT_APPROVAL_TROUBLESHOOTING.md",
    "HELPDESK_FIX_COMPLETE.md",
    "HELPDESK_FIX_FINAL.md",
    "HELPDESK_QUESTION_SUBMISSION_WORKING.md",
    "HELPDESK_SOLUTION_COMPLETE.md",
    "STAFF_HELPDESK_REPLY_SYSTEM_COMPLETE.md",
    "IMPLEMENTATION_COMPLETE.md",
    "IMPLEMENTATION_SUMMARY.md",
    "REBUILD_SUMMARY.md",
    "DATA_FILTER_FIXED.md",
    "QUICK_FIX_INSTRUCTIONS.md",
    "UPDATED_MIGRATION_GUIDE.md"
)

foreach ($doc in $tempDocs) {
    $removedCount += if (Remove-Safe -Path $doc -Description "Temporary doc: $doc") { 1 } else { 0 }
}

Write-Host ""
Write-Host "=== STEP 5: Removing Temporary SQL Scripts ===" -ForegroundColor Cyan
$tempSql = @(
    "CHECK_DATABASE.sql",
    "DIAGNOSE_ISSUE.sql",
    "FIX_NOW.sql",
    "FIX_NOW_APPS.sql",
    "create_questions_table.sql",
    "manual_setup_questions.sql",
    "SETUP_APPS_WITH_FILES.sql",
    "SETUP_DATABASE_COMPATIBLE.sql",
    "SIMPLE_DATABASE_SETUP.sql"
)

foreach ($sql in $tempSql) {
    $removedCount += if (Remove-Safe -Path $sql -Description "Temporary SQL: $sql") { 1 } else { 0 }
}

# Remove temporary SQL files from resources directory
$resourceSql = @(
    "migrate_questions_table.sql",
    "migrate_to_separate_review_table.sql",
    "quick_fix_questions.sql",
    "simple_migrate_questions.sql",
    "test_questions_table.sql",
    "verify_questions_table.sql"
)

foreach ($sql in $resourceSql) {
    $sqlPath = "src\main\resources\$sql"
    $removedCount += if (Remove-Safe -Path $sqlPath -Description "Temporary SQL: $sqlPath") { 1 } else { 0 }
}

Write-Host ""
Write-Host "=== STEP 6: Removing Temporary Batch Files ===" -ForegroundColor Cyan
$removedCount += if (Remove-Safe -Path "run_this.bat" -Description "Temporary batch file") { 1 } else { 0 }
$removedCount += if (Remove-Safe -Path "setup_apps.bat" -Description "Temporary batch file") { 1 } else { 0 }

Write-Host ""
Write-Host "=== STEP 7: Removing Sample/Test Files ===" -ForegroundColor Cyan
$removedCount += if (Remove-Safe -Path "sample_passport.pdf" -Description "Sample test file") { 1 } else { 0 }

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Cleanup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Total items removed: $removedCount" -ForegroundColor Green
Write-Host ""
Write-Host "Remaining essential files:" -ForegroundColor Yellow
Write-Host "  - Source code in src/" -ForegroundColor White
Write-Host "  - Configuration files (pom.xml, etc.)" -ForegroundColor White
Write-Host "  - Essential documentation (START_HERE.md, etc.)" -ForegroundColor White
Write-Host "  - Essential SQL scripts (init.sql, CREATE_*.sql)" -ForegroundColor White
Write-Host ""
Write-Host "You can rebuild the project with: mvn clean install" -ForegroundColor Cyan

