# Word Count Analysis Script for RAG-Optimized Documentation Repository
# Run from repository root: .\src\Get-WordCount.ps1

[CmdletBinding()]
param(
    [switch]$Detailed,
    [switch]$ExportCsv
)

# Initialize counters
$totalWords = 0
$totalFiles = 0
$results = @()

# File extensions to analyze
$docExtensions = @('.md', '.txt')

Write-Host "RAG-Optimized Documentation Repository - Word Count Analysis" -ForegroundColor Cyan
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host ""

# Get all documentation files
$files = Get-ChildItem -Recurse -File | Where-Object { $_.Extension -in $docExtensions }

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -ErrorAction SilentlyContinue
    
    if ($content) {
        # Count words (split on whitespace and filter empty)
        $words = ($content -split '\s+' | Where-Object { $_ -ne '' }).Count
        
        # Create relative path for cleaner output
        $relativePath = $file.FullName.Replace((Get-Location).Path, '').TrimStart('\')
        
        $result = [PSCustomObject]@{
            File = $relativePath
            Directory = Split-Path $relativePath -Parent
            WordCount = $words
            SizeKB = [math]::Round($file.Length / 1KB, 2)
        }
        
        $results += $result
        $totalWords += $words
        $totalFiles++
        
        if ($Detailed) {
            Write-Host ("{0,-50} {1,8} words" -f $relativePath, $words) -ForegroundColor White
        }
    }
}

Write-Host ""
Write-Host "SUMMARY STATISTICS" -ForegroundColor Yellow
Write-Host "=" * 30 -ForegroundColor Yellow
Write-Host ("Total Files Analyzed: {0}" -f $totalFiles) -ForegroundColor Green
Write-Host ("Total Word Count: {0:N0}" -f $totalWords) -ForegroundColor Green
Write-Host ("Average Words per File: {0:N0}" -f ($totalWords / $totalFiles)) -ForegroundColor Green

# Top directories by word count
Write-Host ""
Write-Host "TOP DIRECTORIES BY WORD COUNT" -ForegroundColor Yellow
Write-Host "=" * 35 -ForegroundColor Yellow

$directoryStats = $results | Group-Object Directory | ForEach-Object {
    [PSCustomObject]@{
        Directory = if ($_.Name) { $_.Name } else { "Root" }
        Files = $_.Count
        TotalWords = ($_.Group | Measure-Object WordCount -Sum).Sum
        AvgWords = [math]::Round(($_.Group | Measure-Object WordCount -Average).Average, 0)
    }
} | Sort-Object TotalWords -Descending

$directoryStats | ForEach-Object {
    Write-Host ("{0,-25} {1,6} files {2,8} words (avg: {3,5})" -f $_.Directory, $_.Files, $_.TotalWords, $_.AvgWords) -ForegroundColor White
}

# Largest files
Write-Host ""
Write-Host "LARGEST DOCUMENTATION FILES" -ForegroundColor Yellow
Write-Host "=" * 30 -ForegroundColor Yellow

$results | Sort-Object WordCount -Descending | Select-Object -First 10 | ForEach-Object {
    Write-Host ("{0,-50} {1,8} words" -f $_.File, $_.WordCount) -ForegroundColor White
}

# Development efficiency calculation
Write-Host ""
Write-Host "DEVELOPMENT EFFICIENCY METRICS" -ForegroundColor Magenta
Write-Host "=" * 35 -ForegroundColor Magenta
$developmentHours = 2
$wordsPerHour = $totalWords / $developmentHours
Write-Host ("Development Time: {0} hours" -f $developmentHours) -ForegroundColor Cyan
Write-Host ("Words per Hour: {0:N0}" -f $wordsPerHour) -ForegroundColor Cyan
Write-Host ("Files per Hour: {0:N1}" -f ($totalFiles / $developmentHours)) -ForegroundColor Cyan

# Export to CSV if requested
if ($ExportCsv) {
    $csvPath = "word-count-analysis-$(Get-Date -Format 'yyyy-MM-dd-HHmm').csv"
    $results | Export-Csv $csvPath -NoTypeInformation
    Write-Host ""
    Write-Host "Detailed results exported to: $csvPath" -ForegroundColor Green
}

Write-Host ""
Write-Host "Analysis completed at $(Get-Date)" -ForegroundColor Gray