#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
analyze_docs.py — KISS-fixed QA analyzer for RAG-optimized documentation.

Fixes included:
- Front matter regex accepts BOM/HTML comment wrappers and Windows newlines.
- Semantic numbering regex uses MULTILINE.
- Link check ignores http/https/mailto/tel and strips #fragments;
  tries dir/README.md and bare+.md candidates to reduce false "broken".
"""
import os, re, sys, time, argparse
from pathlib import Path

FRONT_MATTER_RE = re.compile(
    r'(?s)^\ufeff?\s*(?:<!--\s*)?---\s*\r?\n(.*?)\r?\n---\s*(?:-->\s*)?(?:\r?\n|$)'
)
LINK_RE = re.compile(r'\[.*?\]\((.*?)\)')
SEMANTIC_HEADING_RE = re.compile(r'^\s*##\s*\*\*(\d+)\.\s*(.*?)\*\*\s*$', re.MULTILINE)

REQUIRED_FRONT_MATTER_KEYS = ['status', 'type', 'owner', 'lastReviewed']
IGNORE_SCHEMES = ('http://', 'https://', 'mailto:', 'tel:')

def read_text(p: Path) -> str:
    try:
        return p.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        return p.read_text(encoding="utf-8", errors="ignore")

def has_front_matter(text: str):
    m = FRONT_MATTER_RE.search(text)
    if not m:
        return False, {}
    block = m.group(1)
    meta = {}
    for line in block.splitlines():
        if ':' in line:
            k, v = line.split(':', 1)
            meta[k.strip()] = v.strip().strip('"').strip("'")
    return True, meta

def check_semantic_numbering(text: str) -> bool:
    return bool(SEMANTIC_HEADING_RE.search(text))

def resolve_internal_targets(rel_file: Path, links):
    missing = []
    targets_checked = []
    base_dir = rel_file.parent
    for l in links:
        if not l or l.startswith(IGNORE_SCHEMES) or l.startswith('#'):
            continue
        base = l.split('#', 1)[0].rstrip('/')
        if not base:
            continue
        p0 = (base_dir / base).resolve()
        candidates = [p0]
        if not Path(base).suffix:
            candidates.append(Path(str(p0) + '.md'))
            candidates.append(p0 / 'README.md')
        found = False
        for c in candidates:
            targets_checked.append(str(c))
            if c.exists():
                found = True
                break
        if not found:
            missing.append(l)
    return targets_checked, missing

def analyze_repo(root: Path):
    issues = {
        "missing_front_matter": [],
        "front_matter_missing_keys": [],
        "semantic_numbering_fail": [],
        "broken_internal_links": []
    }
    all_files = sorted([p for p in root.rglob("*.md") if p.is_file()])
    for f in all_files:
        text = read_text(f)
        has_fm, meta = has_front_matter(text)
        if not has_fm:
            issues["missing_front_matter"].append(str(f.relative_to(root)))
        else:
            missing_keys = [k for k in REQUIRED_FRONT_MATTER_KEYS if k not in meta]
            if missing_keys:
                issues["front_matter_missing_keys"].append({
                    "file": str(f.relative_to(root)),
                    "missing": missing_keys
                })
        if not check_semantic_numbering(text):
            issues["semantic_numbering_fail"].append(str(f.relative_to(root)))
        links = LINK_RE.findall(text)
        internal = [l for l in links if not l.startswith(IGNORE_SCHEMES)]
        _, missing = resolve_internal_targets(f, internal)
        if missing:
            issues["broken_internal_links"].append({
                "file": str(f.relative_to(root)),
                "missing": sorted(set(missing))
            })
    return issues, len(all_files)

def write_report(issues, file_count, out_path: Path):
    ts = time.strftime("%Y%m%d-%H%M%SZ", time.gmtime())
    report = []
    report.append(f"# Documentation QA Report — {ts}")
    report.append("")
    report.append(f"- Files scanned: **{file_count}**")
    report.append(f"- Missing front matter: **{len(issues['missing_front_matter'])}**")
    report.append(f"- Front matter missing required keys: **{len(issues['front_matter_missing_keys'])}**")
    report.append(f"- Semantic numbering not detected: **{len(issues['semantic_numbering_fail'])}**")
    report.append(f"- Files with broken internal links: **{len(issues['broken_internal_links'])}**")
    report.append("")
    if issues["missing_front_matter"]:
        report.append("## Missing front matter")
        for f in issues["missing_front_matter"]:
            report.append(f"- {f}")
        report.append("")
    if issues["front_matter_missing_keys"]:
        report.append("## Front matter missing required keys")
        for item in issues["front_matter_missing_keys"]:
            report.append(f"- {item['file']}: {', '.join(item['missing'])}")
        report.append("")
    if issues["semantic_numbering_fail"]:
        report.append("## Files without semantic numbering (e.g., `## **1. Title**`)")
        for f in issues["semantic_numbering_fail"]:
            report.append(f"- {f}")
        report.append("")
    if issues["broken_internal_links"]:
        report.append("## Broken internal links (after tolerant resolution)")
        for item in issues["broken_internal_links"]:
            report.append(f"- {item['file']}")
            for l in item["missing"]:
                report.append(f"  - {l}")
        report.append("")
    out_file = out_path / f"issues-{ts}.md"
    out_file.write_text("\n".join(report), encoding="utf-8")
    return out_file

def main():
    ap = argparse.ArgumentParser(description="Analyze RAG-optimized docs (KISS-fixed).")
    ap.add_argument("path", help="Path to repo root")
    args = ap.parse_args()
    root = Path(args.path).resolve()
    if not root.exists():
        print(f"Error: path not found: {root}", file=sys.stderr)
        sys.exit(2)
    issues, n = analyze_repo(root)
    out_file = write_report(issues, n, Path.cwd())
    print(f"✅ Analysis complete. Report: {out_file}")

if __name__ == "__main__":
    main()
