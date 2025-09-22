<!--
---
title: "CLI Validation Tool - RAG-Optimized Documentation Local Development"
description: "Comprehensive specification for command-line interface validation tool supporting local development workflows"
owner: "VintageDon - https://github.com/vintagedon"
ai_contributor: "Claude Sonnet 4"
lastReviewed: "2025-01-21"
version: "1.0"
status: "Published"
tags:
- type: specification
- domain: local-development
- tech: command-line-interface
- audience: developers/maintainers
related_documents:
- "[Tools Overview](README.md)"
- "[GitHub Actions](github-actions.md)"
- "[Scripts Collection](scripts/README.md)"
type: specification
---
-->

# 🖥️ **CLI Validation Tool - Local Development**

Comprehensive specification for implementing command-line interface validation tools that provide immediate feedback and quality assurance during local documentation development workflows.

---

## 📖 **1. Introduction**

This specification defines a command-line interface tool that provides comprehensive validation capabilities for RAG-optimized documentation during local development. The CLI tool enables developers to validate framework compliance, check quality standards, and receive immediate feedback before committing changes.

### Purpose

The CLI validation tool addresses critical development needs by:

- Providing immediate feedback during documentation authoring and editing
- Enabling local validation without requiring CI/CD pipeline execution
- Supporting development workflow integration with pre-commit hooks and editor plugins
- Facilitating rapid iteration and quality improvement during content creation

### Scope

**What's Covered:**

- Complete CLI tool specification with command structure and option definitions
- Validation capabilities for framework compliance, quality standards, and content structure
- Integration patterns for development workflows, editors, and automation systems
- Output formats and reporting capabilities for various use cases and environments

**What's Not Covered:**

- Graphical user interface or web-based validation tools
- Content creation or automated documentation generation capabilities
- Integration with external proprietary platforms or specialized documentation systems

### Target Audience

**Primary Users:** Documentation authors, developers, and content creators  
**Secondary Users:** Repository maintainers and quality assurance teams  
**Background Assumed:** Command-line tool usage and basic documentation workflow knowledge

### Overview

The CLI tool provides comprehensive validation capabilities that integrate seamlessly with existing development workflows while supporting the quality and compliance requirements of RAG-optimized documentation frameworks.

---

## 🔗 **2. Dependencies & Prerequisites**

### System Requirements

**Runtime Environment:**

- Python 3.8+ with standard library and package management capabilities
- Operating system support for Windows, macOS, and Linux environments
- Command-line terminal access and shell environment integration
- File system read access for repository content and configuration files

### Python Dependencies

**Core Libraries:**

- `argparse` - Command-line argument parsing and interface definition
- `pathlib` - Cross-platform file system path manipulation
- `yaml` - YAML front matter parsing and validation
- `json` - JSON output formatting and configuration management
- `re` - Regular expression pattern matching for content validation

**Optional Dependencies:**

- `colorama` - Cross-platform colored terminal output
- `tabulate` - Formatted table output for reports and summaries
- `click` - Enhanced command-line interface development (alternative to argparse)

---

## 📋 **3. Command Structure & Interface**

### Primary Command Interface

**Base Command Structure:**

```bash
rag-docs [COMMAND] [OPTIONS] [PATH]

# Examples:
rag-docs validate .
rag-docs validate --format json --output report.json
rag-docs check --compliance-only --threshold 95
rag-docs analyze --detailed --export-metrics
```

### Core Commands

**validate** - Comprehensive Documentation Validation

```bash
rag-docs validate [PATH] [OPTIONS]

Options:
  --format FORMAT           Output format: text|json|markdown|github
  --output FILE             Output file (default: stdout)
  --compliance-only         Check framework compliance only
  --threshold PERCENT       Minimum compliance threshold (default: 90)
  --exclude PATTERN         Exclude files/directories matching pattern
  --include PATTERN         Include only files/directories matching pattern
  --exit-on-error          Exit with non-zero code on validation failures
  --quiet                  Suppress informational output
  --verbose                Detailed validation output
  --parallel               Enable parallel processing for large repositories
  --max-workers NUM        Maximum worker threads for parallel processing

Examples:
  rag-docs validate .                    # Validate current directory
  rag-docs validate --format json       # JSON output for automation
  rag-docs validate --compliance-only   # Framework compliance check only
  rag-docs validate --threshold 95      # Require 95% compliance score
```

**check** - Quick Quality Assessment

```bash
rag-docs check [PATH] [OPTIONS]

Options:
  --summary                Show summary statistics only
  --issues-only           Show only validation issues
  --warnings              Include warnings in output
  --count                 Show issue counts by category

Examples:
  rag-docs check .                      # Quick quality check
  rag-docs check --summary              # Summary statistics only
  rag-docs check --issues-only          # Show problems only
```

**analyze** - Detailed Repository Analysis

```bash
rag-docs analyze [PATH] [OPTIONS]

Options:
  --detailed              Include detailed analysis and recommendations
  --metrics               Generate quality metrics and statistics
  --export-metrics FILE   Export metrics to file (JSON format)
  --baseline FILE         Compare against baseline metrics
  --trend-analysis        Include trend analysis if baseline provided

Examples:
  rag-docs analyze .                           # Detailed analysis
  rag-docs analyze --metrics --export-metrics metrics.json
  rag-docs analyze --baseline baseline.json --trend-analysis
```

### Specialized Commands

**fix** - Automated Issue Resolution

```bash
rag-docs fix [PATH] [OPTIONS]

Options:
  --dry-run               Show what would be fixed without making changes
  --backup                Create backup files before making changes
  --issues TYPES          Comma-separated list of issue types to fix
  --interactive           Prompt for confirmation before each fix

Available fix types:
  - frontmatter          Add missing YAML front matter
  - links                Fix broken internal links
  - structure            Correct semantic numbering issues
  - formatting           Fix markdown formatting issues

Examples:
  rag-docs fix . --dry-run                    # Preview fixes
  rag-docs fix . --issues frontmatter,links   # Fix specific issues
  rag-docs fix . --interactive                # Interactive fixing
```

**init** - Repository Initialization

```bash
rag-docs init [PATH] [OPTIONS]

Options:
  --template TYPE         Template type: basic|enterprise|community
  --force                 Overwrite existing configuration
  --interactive           Interactive setup wizard

Examples:
  rag-docs init .                        # Initialize with default template
  rag-docs init . --template enterprise  # Enterprise template
  rag-docs init . --interactive          # Interactive setup
```

---

## 📊 **4. Validation Capabilities**

### Framework Compliance Validation

**Semantic Numbering Validation:**

```python
def validate_semantic_numbering(content, file_path):
    """
    Validate semantic section numbering compliance
    
    Checks:
    - Proper numbered section headers (## **1. Section**, etc.)
    - Section 5 contains "Security & Compliance" keywords
    - Sequential numbering without gaps
    - Appropriate section depth and hierarchy
    """
    issues = []
    
    # Extract section headers and validate numbering
    sections = extract_numbered_sections(content)
    
    # Validate Section 5 compliance (RAG anchor requirement)
    section_5 = find_section_5(sections)
    if not section_5 or not contains_security_compliance(section_5):
        issues.append({
            'type': 'section_5_compliance',
            'severity': 'error',
            'message': 'Section 5 must contain "Security & Compliance"',
            'file': file_path
        })
    
    return issues
```

**YAML Front Matter Validation:**

```python
def validate_yaml_frontmatter(content, file_path):
    """
    Validate YAML front matter compliance
    
    Required fields:
    - title, description, author, date, version, status
    
    Optional fields:
    - ai_contributor, tags, related_documents
    """
    issues = []
    
    frontmatter = extract_yaml_frontmatter(content)
    if not frontmatter:
        issues.append({
            'type': 'missing_frontmatter',
            'severity': 'error',
            'message': 'Missing YAML front matter',
            'file': file_path
        })
        return issues
    
    # Validate required fields
    required_fields = ['title', 'description', 'author', 'date', 'version', 'status']
    for field in required_fields:
        if field not in frontmatter:
            issues.append({
                'type': 'missing_frontmatter_field',
                'severity': 'warning',
                'message': f'Missing required field: {field}',
                'file': file_path,
                'field': field
            })
    
    return issues
```

### Content Quality Validation

**Link Integrity Checking:**

```python
def validate_links(content, file_path, repository_root):
    """
    Validate internal and external link integrity
    
    Checks:
    - Internal links point to existing files
    - Anchor links reference valid headings
    - External links are accessible (optional)
    - Relative path correctness
    """
    issues = []
    
    links = extract_markdown_links(content)
    
    for link in links:
        if is_internal_link(link):
            target_path = resolve_relative_path(link, file_path, repository_root)
            if not target_path.exists():
                issues.append({
                    'type': 'broken_internal_link',
                    'severity': 'error',
                    'message': f'Broken internal link: {link}',
                    'file': file_path,
                    'link': link
                })
    
    return issues
```

### Template Compliance Validation

**Template Usage Verification:**

```python
def validate_template_compliance(content, file_path, template_type):
    """
    Validate proper template usage and customization
    
    Checks:
    - Template structure maintained
    - Placeholder content replaced with actual content
    - Required sections present
    - Navigation patterns correctly implemented
    """
    issues = []
    
    # Detect template type based on file location and content
    detected_template = detect_template_type(file_path, content)
    
    # Validate template-specific requirements
    if detected_template == 'interior_readme':
        issues.extend(validate_interior_readme_template(content, file_path))
    elif detected_template == 'primary_readme':
        issues.extend(validate_primary_readme_template(content, file_path))
    
    return issues
```

---

## 📋 **5. Output Formats & Reporting**

### Text Output Format

**Standard Validation Report:**

```
RAG-Optimized Documentation Validation Report
==============================================

Repository: /path/to/repository
Validation Time: 2025-01-21 14:30:00 UTC
CLI Version: 1.0.0

Validation Summary
------------------
✅ Files Processed: 47
✅ Compliance Score: 94%
⚠️  Issues Found: 8 (3 errors, 5 warnings)
✅ Template Compliance: 96%

Issues by Category
------------------
[ERROR] Semantic Numbering (2 issues)
  docs/api/README.md:1 - Missing Section 5 (Security & Compliance)
  examples/basic/README.md:15 - Invalid section numbering sequence

[ERROR] YAML Front Matter (1 issue)
  tools/scripts/README.md:1 - Missing YAML front matter

[WARNING] Link Integrity (5 issues)
  docs/getting-started.md:45 - Broken internal link: ../examples/missing.md
  community/showcase.md:23 - External link timeout: https://example.com/dead-link

Recommendations
---------------
1. Fix 3 critical errors before merge
2. Consider adding missing YAML front matter for consistency
3. Review and update broken links
4. Overall compliance is good (94% - above 90% threshold)

For detailed fixing guidance, run: rag-docs fix --dry-run
```

### JSON Output Format

**Machine-Readable Validation Results:**

```json
{
  "validation_summary": {
    "repository_path": "/path/to/repository",
    "validation_time": "2025-01-21T14:30:00Z",
    "cli_version": "1.0.0",
    "files_processed": 47,
    "compliance_score": 94.2,
    "issues_total": 8,
    "issues_by_severity": {
      "error": 3,
      "warning": 5,
      "info": 0
    },
    "template_compliance": 96.1
  },
  "issues": [
    {
      "type": "missing_section_5",
      "severity": "error",
      "category": "semantic_numbering",
      "file": "docs/api/README.md",
      "line": 1,
      "message": "Missing Section 5 (Security & Compliance)",
      "fix_suggestion": "Add ## **5. Security & Compliance** section"
    },
    {
      "type": "broken_internal_link",
      "severity": "warning",
      "category": "link_integrity",
      "file": "docs/getting-started.md",
      "line": 45,
      "message": "Broken internal link: ../examples/missing.md",
      "link_target": "../examples/missing.md",
      "fix_suggestion": "Update link target or create missing file"
    }
  ],
  "quality_metrics": {
    "documentation_coverage": 92.3,
    "frontmatter_completeness": 89.4,
    "link_health": 95.7,
    "template_adherence": 96.1,
    "semantic_numbering_compliance": 94.7
  },
  "recommendations": [
    "Fix 3 critical errors before merge",
    "Consider adding missing YAML front matter for consistency",
    "Review and update broken links"
  ]
}
```

### GitHub Actions Integration Format

**CI/CD Optimized Output:**

```
::group::📋 Documentation Validation Summary
✅ Compliance Score: 94% (Target: 90%)
⚠️ Issues Found: 8 (3 errors, 5 warnings)
::endgroup::

::group::❌ Critical Issues Requiring Attention
::error file=docs/api/README.md,line=1::Missing Section 5 (Security & Compliance)
::error file=examples/basic/README.md,line=15::Invalid section numbering sequence
::error file=tools/scripts/README.md,line=1::Missing YAML front matter
::endgroup::

::group::⚠️ Warnings
::warning file=docs/getting-started.md,line=45::Broken internal link: ../examples/missing.md
::warning file=community/showcase.md,line=23::External link timeout: https://example.com/dead-link
::endgroup::

::set-output name=compliance_score::94
::set-output name=issues_total::8
::set-output name=critical_issues::3
```

---

## 🔒 **6. Security & Integration**

### Tool Security

**Safe Operation Principles:**

- Read-only access to repository files by default
- Explicit confirmation required for any file modifications
- No network access unless explicitly enabled for external link checking
- Sandboxed execution environment with limited system permissions

**Configuration Security:**

```yaml
# .rag-docs-config.yml - Secure configuration management
validation:
  external_links:
    enabled: false          # Disable by default for security
    timeout: 5             # Conservative timeout
    user_agent: "rag-docs-validator/1.0"
  
  file_access:
    read_only: true        # Enforce read-only by default
    backup_before_fix: true # Always backup before modifications
  
  reporting:
    include_sensitive: false # Exclude sensitive paths from reports
    sanitize_output: true   # Sanitize file paths in output
```

### Development Workflow Integration

**Pre-commit Hook Integration:**

```bash
#!/bin/sh
# .git/hooks/pre-commit

echo "🔍 Running RAG documentation validation..."

# Run validation on staged files
rag-docs validate --format github --exit-on-error --quiet

if [ $? -ne 0 ]; then
    echo "❌ Documentation validation failed"
    echo "Run 'rag-docs validate .' for detailed results"
    echo "Run 'rag-docs fix --dry-run' to see available fixes"
    exit 1
fi

echo "✅ Documentation validation passed"
exit 0
```

**Editor Integration Examples:**

```json
// VS Code settings.json
{
  "emeraldwalk.runonsave": {
    "commands": [
      {
        "match": "\\.md$",
        "cmd": "rag-docs check ${file} --summary"
      }
    ]
  }
}
```

**Continuous Integration Integration:**

```yaml
# GitHub Actions workflow step
- name: Validate Documentation
  run: |
    rag-docs validate . \
      --format github \
      --threshold 90 \
      --exit-on-error
```

---

*CLI Validation Tool Specification Version: 1.0 | Last Updated: 2025-01-21 | Status: Published*
