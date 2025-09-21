<#
.SYNOPSIS
  Repository content + front-matter stats (markdown & text).

.DESCRIPTION
  Computes words/lines/chars per file, top directories, largest files,
  and simple YAML front-matter stats (Status, Type). PS5/PS7-safe, ASCII-only output.

.NOTES
  AUTHOR: Donald Fountain (VintageDon)
  VERSION: 2.6 - Fix: no 'if' inside hashtable; PS5/PS7 safe; ASCII only.
  LICENSE: MIT
#>

[CmdletBinding()]
param(
  [Parameter(Mandatory=$false)]
  [string]$Path = ".",

  [Parameter(Mandatory=$false)]
  [string[]]$Include = @("*.md","*.txt"),

  [Parameter(Mandatory=$false)]
  [switch]$Detailed,

  [Parameter(Mandatory=$false)]
  [switch]$ExportCsv
)

function Parse-FrontMatter {
  param([string]$Content)
  $frontMatter = @{}

  if ($Content -match '(?sm)^---\s*\r?\n(.*?)\r?\n---\s*\r?\n') {
    $yamlContent = $Matches[1]

    if ($yamlContent -match '(?m)^\s*status\s*:\s*(.+?)\s*$') {
      $frontMatter['Status'] = ($Matches[1]).Trim()
    }

    if ($yamlContent -match '(?m)^\s*type\s*:\s*(.+?)\s*$') {
      $frontMatter['Type'] = (($Matches[1]).Trim()).TrimStart('[').TrimEnd(']')
    } elseif ($yamlContent -match '(?m)^\s*-\s*type\s*:\s*(.+?)\s*$') {
      $frontMatter['Type'] = (($Matches[1]).Trim()).TrimStart('[').TrimEnd(']')
    }
  }
  return $frontMatter
}

function Test-MatchesAnyPattern {
  param(
    [string]$Name,
    [string[]]$Patterns
  )
  foreach ($p in $Patterns) {
    if ([System.Management.Automation.WildcardPattern]::new($p, 'IgnoreCase').IsMatch($Name)) { return $true }
  }
  return $false
}

# Probe for GetRelativePath (PS7+) with fallback
$HaveGetRelativePath = $false
try {
  [void][System.IO.Path]::GetRelativePath("C:\","C:\x")
  $HaveGetRelativePath = $true
} catch { $HaveGetRelativePath = $false }

$sw = [System.Diagnostics.Stopwatch]::StartNew()

try {
  $root = (Resolve-Path -Path $Path).Path
} catch {
  Write-Error ("Invalid -Path '{0}'. {1}" -f $Path, $_)
  return
}

try {
  $allFiles = Get-ChildItem -Path $root -Recurse -File -ErrorAction Stop
} catch {
  Write-Error ("Could not enumerate files under '{0}'. {1}" -f $root, $_)
  return
}
$files = $allFiles | Where-Object { Test-MatchesAnyPattern -Name $_.Name -Patterns $Include }

Write-Host "RAG-Optimized Documentation Repository - Content Analysis" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host ("Analyzing {0} files in '{1}'..." -f $files.Count, $root)
Write-Host ""

if ($files.Count -eq 0) {
  Write-Host ("No files matched the include patterns: {0}" -f ($Include -join ', ')) -ForegroundColor Yellow
  return
}

$results = New-Object System.Collections.Generic.List[object]

foreach ($file in $files) {
  $content = Get-Content -LiteralPath $file.FullName -Raw -ErrorAction SilentlyContinue
  if ($null -eq $content -or $content.Length -eq 0) { continue }

  $lines = ($content -split '\r?\n')
  $wordCount = (($content -split '\s+') | Where-Object { $_ -ne '' }).Count
  $fm = Parse-FrontMatter -Content $content

  if ($HaveGetRelativePath) {
    $rel = [System.IO.Path]::GetRelativePath($root, $file.FullName)
  } else {
    if ($file.FullName.StartsWith($root, [System.StringComparison]::OrdinalIgnoreCase)) {
      $rel = $file.FullName.Substring($root.Length).TrimStart('\','/')
    } else {
      $rel = $file.FullName
    }
  }

  $obj = [PSCustomObject]@{
    File           = $rel
    Directory      = (Split-Path $rel -Parent)
    WordCount      = [int]$wordCount
    LineCount      = [int]$lines.Count
    CharacterCount = [int]$content.Length
    WordsPerLine   = if ($lines.Count -gt 0) { [math]::Round($wordCount / [double]$lines.Count, 2) } else { 0 }
    SizeKB         = [math]::Round($file.Length / 1KB, 2)
    Status         = $fm['Status']
    Type           = $fm['Type']
  }

  [void]$results.Add($obj)

  if ($Detailed) {
    Write-Host ("{0,-70} {1,8} words {2,6} lines" -f $rel, $obj.WordCount, $obj.LineCount)
  }
}

Write-Host ""
Write-Host "OVERALL SUMMARY STATISTICS" -ForegroundColor Yellow
Write-Host ("-" * 35) -ForegroundColor Yellow

$cnt  = [int]$results.Count

$sumW = ($results | Measure-Object -Property WordCount -Sum).Sum
if ($null -eq $sumW) { $sumW = 0 }

$sumL = ($results | Measure-Object -Property LineCount -Sum).Sum
if ($null -eq $sumL) { $sumL = 0 }

$avgW = ($results | Measure-Object -Property WordCount -Average).Average
if ($null -eq $avgW) { $avgW = 0 }

$avgL = ($results | Measure-Object -Property LineCount -Average).Average
if ($null -eq $avgL) { $avgL = 0 }

Write-Host ("Total Files Analyzed: {0}" -f $cnt) -ForegroundColor Green
Write-Host ("Total Word Count: {0:N0}" -f $sumW) -ForegroundColor Green
Write-Host ("Total Line Count: {0:N0}" -f $sumL) -ForegroundColor Green
Write-Host ("Average Words per File: {0:N0}" -f $avgW) -ForegroundColor Green
Write-Host ("Average Lines per File: {0:N0}" -f $avgL) -ForegroundColor Green

Write-Host ""
Write-Host "TOP DIRECTORIES BY WORD COUNT" -ForegroundColor Yellow
Write-Host ("-" * 35) -ForegroundColor Yellow

$dirStats =
  $results |
  Group-Object Directory |
  ForEach-Object {
    $tw = ($_.Group | Measure-Object -Property WordCount -Sum).Sum
    if ($null -eq $tw) { $tw = 0 }

    $aw = ($_.Group | Measure-Object -Property WordCount -Average).Average
    if ($null -eq $aw) { $aw = 0 }

    $dirName = if ([string]::IsNullOrEmpty($_.Name)) { "Root" } else { $_.Name }

    [PSCustomObject]@{
      Directory  = $dirName
      Files      = $_.Count
      TotalWords = [int]$tw
      AvgWords   = [int][math]::Round($aw, 0)
    }
  } |
  Sort-Object TotalWords -Descending |
  Select-Object -First 10

foreach ($row in $dirStats) {
  Write-Host ("{0,-45} {1,4} files {2,10:N0} words (avg: {3,5:N0})" -f $row.Directory, $row.Files, $row.TotalWords, $row.AvgWords)
}

Write-Host ""
Write-Host "LARGEST FILES BY WORD COUNT" -ForegroundColor Yellow
Write-Host ("-" * 35) -ForegroundColor Yellow

$results |
  Sort-Object WordCount -Descending |
  Select-Object -First 10 |
  ForEach-Object {
    Write-Host ("{0,-70} {1,8:N0} words" -f $_.File, $_.WordCount)
  }

Write-Host ""
Write-Host "FRONT MATTER METADATA ANALYSIS" -ForegroundColor Yellow
Write-Host ("-" * 35) -ForegroundColor Yellow

Write-Host "File Count by Status:" -ForegroundColor Magenta
$byStatus = $results | Where-Object { $_.Status } | Group-Object Status | Sort-Object Count -Descending
if ($byStatus -and $byStatus.Count -gt 0) {
  $byStatus | ForEach-Object {
    Write-Host ("  {0,-20} : {1}" -f $_.Name, $_.Count)
  }
} else {
  Write-Host "  (none)"
}

Write-Host ""
Write-Host "File Count by Type (from tags):" -ForegroundColor Magenta
$byType = $results | Where-Object { $_.Type } | Group-Object Type | Sort-Object Count -Descending
if ($byType -and $byType.Count -gt 0) {
  $byType | ForEach-Object {
    Write-Host ("  {0,-20} : {1}" -f $_.Name, $_.Count)
  }
} else {
  Write-Host "  (none)"
}

if ($ExportCsv) {
  $csvPath = Join-Path -Path $root -ChildPath ("repo-analysis-{0}.csv" -f (Get-Date -Format 'yyyyMMdd-HHmmss'))
  $results | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
  Write-Host ""
  Write-Host ("[OK] Detailed results exported to: {0}" -f $csvPath) -ForegroundColor Green
}

$sw.Stop()
Write-Host ""
Write-Host ("Analysis completed in {0} seconds." -f $sw.Elapsed.TotalSeconds.ToString('F2')) -ForegroundColor Gray
