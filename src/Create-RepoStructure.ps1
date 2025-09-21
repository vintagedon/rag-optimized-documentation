<#
.SYNOPSIS
    Creates the complete directory structure and placeholder files for the rag-optimized-documentation repository

.DESCRIPTION
    This script generates the full repository structure for the rag-optimized-documentation framework,
    including all directories, README files, and placeholder files with -pending.md suffixes.
    Creates a self-demonstrating repository that embodies the dual-audience documentation principles.

.PARAMETER DryRun
    Preview operations without creating files and directories

.PARAMETER DetailedOutput
    Enable detailed operational output

.EXAMPLE
    .\Create-RepoStructure.ps1 -DryRun -DetailedOutput

.NOTES
    SCRIPT: Create-RepoStructure.ps1
    AUTHOR: Donald Fountain (VintageDon)
    GITHUB: https://github.com/vintagedon
    ORCID: 0009-0008-7695-4093
    REPOSITORY: https://github.com/vintagedon/rag-optimized-documentation
    PROJECT: RAG-Optimized Documentation Framework
    
    CREATED: 2025-01-11
    MODIFIED: 2025-01-11
    VERSION: 1.0
    LICENSE: MIT
    
    DEPENDENCIES:
    - PowerShell 5.1 or later
    - Write permissions in current directory
    
    OPERATIONAL NOTES:
    - Run from repository root directory
    - Creates complete folder structure with placeholder files
    - All pending files contain single-line placeholder text
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [switch]$DryRun,
    
    [Parameter(Mandatory=$false)]
    [switch]$DetailedOutput
)

# Script metadata
$scriptVersion = "1.0"
$scriptAuthor = "Donald Fountain (VintageDon)"

# Repository structure definition
$repoStructure = @{
    "docs" = @{
        "README.md" = "# Documentation Hub - Navigation and overview for comprehensive project documentation"
        "getting-started-pending.md" = "# Getting Started Guide - Quick start guide for new users implementing the framework"
        "standards-specification-pending.md" = "# Standards Specification - Complete architectural specification for rag-optimized documentation"
        "semantic-numbering-guide-pending.md" = "# Semantic Numbering Guide - Deep dive into the section numbering system for dual-audience optimization"
        "migration-guide-pending.md" = "# Migration Guide - Converting existing documentation to rag-optimized standards"
        "best-practices-pending.md" = "# Best Practices - Advanced implementation patterns and optimization techniques"
    }
    "templates" = @{
        "README.md" = "# Template Collection - Usage guide and selection criteria for documentation templates"
        "primary-readme-template-pending.md" = "# Primary README Template - Repository root documentation template for project overview"
        "interior-readme-template-pending.md" = "# Interior README Template - Directory-level documentation template for component organization"
        "contributing-template-pending.md" = "# Contributing Template - Community guidelines template for project participation"
        "general-page-template-pending.md" = "# General Page Template - Standard documentation page template with semantic structure"
    }
    "examples" = @{
        "README.md" = "# Implementation Examples - Showcase of rag-optimized documentation in practice"
        "trace-methodology" = @{
            "README.md" = "# TRACE Methodology Example - Demonstration of framework application to methodology development"
            "worklog-template-pending.md" = "# Worklog Template - Raw configuration capture template for phase documentation"
            "exit-interview-template-pending.md" = "# Exit Interview Template - Phase completion assessment and knowledge extraction"
        }
        "small-project" = @{
            "README.md" = "# Small Project Example - Lightweight implementation demonstration for simple repositories"
            "structure-example-pending.md" = "# Structure Example - Minimal viable structure for small-scale documentation"
        }
        "enterprise-project" = @{
            "README.md" = "# Enterprise Project Example - Complex enterprise-scale implementation demonstration"
            "governance-integration-pending.md" = "# Governance Integration - Compliance and audit integration patterns for enterprise environments"
        }
    }
    "tools" = @{
        "README.md" = "# Automation Tools - Tooling overview and development roadmap for framework support"
        "validation-cli-pending.md" = "# Validation CLI - Structure validation tool specification and implementation guide"
        "github-actions-pending.md" = "# GitHub Actions - CI/CD integration patterns for automated documentation quality"
        "scripts" = @{
            "README.md" = "# Utility Scripts - Automation script documentation and maintenance tools"
            "link-checker-pending.md" = "# Link Checker - Automated link validation script for documentation integrity"
        }
    }
    "research" = @{
        "README.md" = "# Research Foundation - Academic and theoretical foundation for the framework"
        "dual-audience-analysis-pending.md" = "# Dual-Audience Analysis - Human-AI documentation theory and cognitive requirements"
        "competitive-analysis-pending.md" = "# Competitive Analysis - Market positioning research and differentiation strategy"
        "rag-performance-metrics-pending.md" = "# RAG Performance Metrics - Quantified benefits analysis and measurement frameworks"
    }
    "community" = @{
        "README.md" = "# Community Hub - Community engagement, growth, and participation guidelines"
        "showcase-pending.md" = "# Community Showcase - Highlighted community projects and implementations"
        "adoption-stories-pending.md" = "# Adoption Stories - Success stories and case studies from framework users"
        "roadmap-pending.md" = "# Development Roadmap - Future development plans and community vision"
    }
    "phase-0-ideation-and-setup" = @{
        "README.md" = "# Phase 0: Ideation and Setup - Current development phase overview and objectives"
        "work-log-pending.md" = "# Work Log - Raw configuration documentation of repository creation and setup process"
        "methodology-assessment-pending.md" = "# Methodology Assessment - TRACE methodology evaluation and effectiveness analysis"
        "business-outcomes-pending.md" = "# Business Outcomes - Value proposition validation and impact assessment"
        "ai-exit-interview-pending.md" = "# AI Exit Interview - Phase completion assessment and knowledge extraction"
    }
    ".github" = @{
        "README.md" = "# GitHub Configuration - Repository configuration and automation documentation"
        "workflows" = @{
            "documentation-validation-pending.md" = "# Documentation Validation - CI/CD workflow for automated documentation quality assurance"
        }
        "ISSUE_TEMPLATE" = @{
            "bug-report-pending.md" = "# Bug Report Template - Standardized template for reporting framework issues"
            "feature-request-pending.md" = "# Feature Request Template - Template for proposing framework enhancements"
            "documentation-improvement-pending.md" = "# Documentation Improvement Template - Template for suggesting documentation improvements"
        }
        "PULL_REQUEST_TEMPLATE" = @{
            "standard-pr-pending.md" = "# Pull Request Template - Standard template for framework contributions"
        }
    }
}

# Root-level files
$rootFiles = @{
    "LICENSE" = "MIT License - Copyright (c) 2025 Donald Fountain (VintageDon)"
    "CONTRIBUTING.md" = "# Contributing Guidelines - Community contribution guidelines and development workflow"
    "CODE_OF_CONDUCT.md" = "# Code of Conduct - Community standards and behavioral expectations"
    "SECURITY.md" = "# Security Policy - Security vulnerability reporting and handling procedures"
    "CHANGELOG.md" = "# Changelog - Version history and release notes for framework evolution"
}

function Write-Status {
    param(
        [string]$Message,
        [string]$Type = "Info"
    )
    
    $timestamp = Get-Date -Format "HH:mm:ss"
    $color = switch ($Type) {
        "Success" { "Green" }
        "Warning" { "Yellow" }
        "Error" { "Red" }
        default { "Cyan" }
    }
    
    Write-Host "[$timestamp] " -NoNewline -ForegroundColor Gray
    Write-Host $Message -ForegroundColor $color
}

function Create-DirectoryStructure {
    param(
        [hashtable]$Structure,
        [string]$BasePath = "."
    )
    
    foreach ($item in $Structure.GetEnumerator()) {
        $itemPath = Join-Path $BasePath $item.Key
        
        if ($item.Value -is [hashtable]) {
            # It's a directory
            if ($DetailedOutput) { Write-Status "Creating directory: $itemPath" }
            
            if (-not $DryRun) {
                if (-not (Test-Path $itemPath)) {
                    New-Item -ItemType Directory -Path $itemPath -Force | Out-Null
                }
            }
            
            # Recursively create subdirectories and files
            Create-DirectoryStructure -Structure $item.Value -BasePath $itemPath
        } else {
            # It's a file
            if ($DetailedOutput) { Write-Status "Creating file: $itemPath" }
            
            if (-not $DryRun) {
                $item.Value | Out-File -FilePath $itemPath -Encoding UTF8 -Force
            }
        }
    }
}

function Create-RootFiles {
    foreach ($file in $rootFiles.GetEnumerator()) {
        $filePath = Join-Path "." $file.Key
        
        if ($DetailedOutput) { Write-Status "Creating root file: $filePath" }
        
        if (-not $DryRun) {
            $file.Value | Out-File -FilePath $filePath -Encoding UTF8 -Force
        }
    }
}

# Main execution
Write-Status "Starting RAG-Optimized Documentation repository structure creation" "Success"
Write-Status "Script Version: $scriptVersion | Author: $scriptAuthor"

if ($DryRun) {
    Write-Status "DRY RUN MODE - No files will be created" "Warning"
}

try {
    # Create root-level files
    Write-Status "Creating root-level files..."
    Create-RootFiles
    
    # Create directory structure and files
    Write-Status "Creating directory structure and placeholder files..."
    Create-DirectoryStructure -Structure $repoStructure
    
    $fileCount = ($repoStructure | ConvertTo-Json -Depth 10 | Select-String '\.md').Count + $rootFiles.Count
    
    if ($DryRun) {
        Write-Status "DRY RUN COMPLETE - Would have created $fileCount files and directories" "Success"
    } else {
        Write-Status "Repository structure creation completed successfully!" "Success"
        Write-Status "Created $fileCount files and directories" "Success"
        Write-Status "Next steps: Run 'git init' and begin documenting with the framework" "Info"
    }
    
} catch {
    Write-Status "Error creating repository structure: $($_.Exception.Message)" "Error"
    exit 1
}