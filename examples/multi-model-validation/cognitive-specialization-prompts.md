<!--
---
title: "Cognitive Specialization Prompts - Model-Specific Templates for Multi-Perspective Analysis"
description: "Copy-paste ready prompt templates that leverage each AI model's cognitive strengths for systematic project assessment"
owner: "VintageDon - https://github.com/vintagedon"
ai_contributor: "Claude Sonnet 4"
lastReviewed: "2025-01-22"
version: "2.0"
status: "Published"
tags:
- type: prompt-templates
- domain: ai-orchestration
- tech: gemini-gpt-claude
- audience: project-managers/engineers
related_documents:
- "[Multi-Model Validation Overview](README.md)"
- "[45-Minute Milestone Review](45-minute-milestone-review.md)"
- "[Multi-Model Codebase Analysis](multi-model-codebase-analysis.md)"
- "[Institutional Knowledge Accumulation](institutional-knowledge-accumulation.md)"
type: prompt-templates
---
-->

# 📄 **Cognitive Specialization Prompts**

Copy-paste ready prompt templates that leverage each AI model's unique cognitive strengths for systematic multi-perspective project assessment.

---

## 📖 **1. Introduction**

This document provides tested prompt templates that extract specialized cognitive perspectives from different AI models. Each prompt is designed to leverage specific model strengths while maintaining consistency in output format for cross-model analysis and synthesis.

### Purpose

To provide practitioners with proven prompt templates that enable systematic multi-model project assessment, ensuring each AI model operates within its cognitive strengths while producing comparable, actionable outputs.

### Scope

**What's Covered:**

- Strategic assessment prompts for market and vision analysis
- Technical assessment prompts for implementation and architecture review
- Cross-analysis prompts for model-to-model evaluation
- Output format specifications for consistent comparison

**What's Not Covered:**

- General prompt engineering principles
- Model-specific interface instructions
- Project-specific customization examples

### Target Audience

**Primary Users:** Project managers and engineering leads conducting systematic reviews  
**Secondary Users:** Development teams implementing structured assessment processes  
**Background Assumed:** Basic familiarity with AI model interfaces and project evaluation needs

### Overview

These prompts implement cognitive specialization by assigning specific analytical roles to each model, creating a multi-perspective assessment framework that produces superior decision-making intelligence compared to single-model approaches.

---

## 🔗 **2. Dependencies & Relationships**

This prompt framework integrates with multi-model review workflows and institutional knowledge management.

### Related Components

- [📁 Multi-Model Validation Overview](README.md) - Complete methodology context and framework
- [📄 45-Minute Milestone Review](45-minute-milestone-review.md) - Complete orchestration workflow
- [📄 Multi-Model Codebase Analysis](multi-model-codebase-analysis.md) - Repository access and preparation methods
- [📄 Institutional Knowledge Accumulation](institutional-knowledge-accumulation.md) - Context storage and retrieval patterns

### External Dependencies

- **AI Model Access** - Subscriptions to ChatGPT, Gemini Pro, and Claude interfaces
- **Repository Content** - Prepared codebase or project materials for analysis
- **Context Materials** - Previous review outputs for cross-analysis prompts
- **Output Processing** - Tools for managing and synthesizing multiple model responses

---

## 📂 **3. Strategic Assessment Prompts**

### Gemini Strategic Analysis Template

```markdown
Hello Gemini! We're experimenting with specialized multi-model reviews where different AI models focus on their unique cognitive strengths. You're handling the **strategic positioning and market analysis** role.

---

**PROJECT**: [Project Name]
**MILESTONE**: [Current Phase/Milestone]
**YOUR ROLE**: Strategic Research Director

**CONTEXT**: [Brief project description and current state]

**YOUR ASSESSMENT FOCUS** (ignore technical implementation details):
1. **Market Opportunity**: How significant is the problem being solved?
2. **Competitive Differentiation**: What makes this approach defensible vs. incumbents?
3. **Adoption Psychology**: Why would practitioners switch from current solutions?
4. **Strategic Positioning**: How does this fit into the broader ecosystem?
5. **Long-term Vision**: Is the evolution roadmap strategically coherent?

**DELIVERABLE FORMAT**:
- **Market Analysis**: Size and urgency of the problem being addressed
- **Competitive Moat Assessment**: Sustainability of the competitive advantage
- **User Adoption Thesis**: Psychological and practical drivers for switching
- **Ecosystem Positioning**: Integration with existing workflows and tools
- **Strategic Risks & Opportunities**: Threats and multiplicative growth vectors

**CONSTRAINT**: Assume all technical challenges can be solved with adequate engineering effort. Focus purely on strategic viability, market dynamics, and positioning.

**EXPERIMENT NOTE**: Another AI model will separately assess the implementation gaps - your job is the strategic perspective that complements tactical execution.

What's your strategic assessment of this project's market position and growth potential?
```

### Strategic Cross-Analysis Template

```markdown
[Model Name], here's [Other Model]'s strategic assessment of the same project. Analyze it through your [perspective] lens:

**[OTHER MODEL]'S KEY FINDINGS**:
- [Summarize 3-5 key strategic points]

**YOUR CROSS-ANALYSIS TASK**:
1. **Strategic Impact**: How do the identified concerns affect market positioning?
2. **Investment Priority**: Which strategic initiatives have the highest leverage?
3. **Market Timing**: Do implementation realities affect competitive advantage?
4. **Adoption Implications**: How do practical barriers impact the strategic thesis?

Provide [your perspective] on whether the strategic vision aligns with implementation realities.
```

---

## 🚀 **4. Usage & Implementation**

Complete implementation guide for using cognitive specialization prompts effectively.

### Technical Assessment Prompts

**GPT Engineering Analysis Template:**

```markdown
ChatGPT! We're experimenting with specialized multi-model reviews where different AI models focus on their cognitive strengths. You're getting the **implementation and engineering assessment** role.

---

**PROJECT**: [Project Name]
**MILESTONE**: [Current Phase/Milestone]
**YOUR ROLE**: DevOps/Engineering Auditor

**CONTEXT**: [Brief technical description and current implementation state]

**YOUR ASSESSMENT FOCUS** (ignore strategic/philosophical aspects):
1. **Implementation Gaps**: What's missing that would prevent adoption?
2. **Tooling Deficiencies**: What automation/validation is needed?
3. **Maintainability Risks**: Where will this break under real-world use?
4. **Deployment Blockers**: What stops someone from using this today?

**DELIVERABLE FORMAT**:
- **Critical Issues**: 3-5 highest-priority problems with specific fixes
- **Missing Tooling**: List with effort estimates (hours/days)
- **Ready-to-Ship Assessment**: Binary yes/no with reasoning
- **Next Sprint Actions**: Concrete tasks with file paths where relevant

**CONSTRAINT**: Focus only on making this work reliably. A different model will handle strategic positioning and methodology questions.

What's your engineering assessment of where this project stands?
```

**Gemini Technical Analysis Template (Alternative):**

```markdown
Hello Gemini! We are conducting a multi-model review where different AIs focus on their unique cognitive strengths. You are assigned the role of a **Principal Engineer** performing a rigorous codebase and documentation review.

**PROJECT**: [Project Name]
**MILESTONE**: [Current Phase/Milestone]
**YOUR ROLE**: Principal Engineer / Staff Technical Writer

**CONTEXT**: [Technical project description and architecture overview]

**YOUR ASSESSMENT FOCUS** (ignore market viability and strategic positioning):
1. **Implementation Gaps**: What critical tooling, configurations, or scripts are missing?
2. **Maintainability Risks**: What aspects are most likely to degrade over time?
3. **Contributor Experience**: How easy is it for new contributors to create compliant work?
4. **Validation & Enforcement**: Are standards automated or convention-based?
5. **Production Readiness**: Is this shippable for a team to adopt today?

**DELIVERABLE FORMAT**:
- **Critical Issues**: Highest-priority technical gaps with file-scoped recommendations
- **Missing Tooling**: Specific tools/scripts needed with effort estimation
- **Maintainability Risks**: How the system would fail in multi-contributor environments
- **Deployment Blockers**: Why teams cannot adopt in current state
- **Ready-to-Ship Assessment**: Clear "Yes/No" with rationale
- **Next Sprint Actions**: Concrete, actionable to-do list with file specifications

What is your technical assessment of this project's current state and readiness for adoption?
```

### Cross-Model Analysis Framework

**Analysis Pairing Strategy:**

Strategic ↔ Technical Cross-Analysis:

- **Gemini Strategic** → **GPT Technical**: "Are strategic goals technically achievable?"
- **GPT Technical** → **Gemini Strategic**: "Do technical constraints affect market position?"

Technical ↔ Technical Cross-Analysis:

- **GPT Tactical** → **Gemini Architectural**: "Do immediate fixes address systemic issues?"
- **Gemini Architectural** → **GPT Tactical**: "Are architectural concerns implementable?"

**Output Integration Patterns:**

Convergence Identification:

- Where models agree → High confidence recommendations
- Where models disagree → Areas requiring human judgment
- Where models complement → Comprehensive solution space

Decision Synthesis Framework:

1. **Technical Feasibility** (from engineering assessments)
2. **Strategic Viability** (from market/vision assessments)
3. **Cross-Model Validation** (from analysis pairs)
4. **Human Integration** (synthesized decision framework)

### Output Format Specifications

**Standardized Response Structure:**

All Primary Assessments Should Include:

- **Executive Summary** (2-3 sentences)
- **Key Findings** (3-5 bullet points)
- **Critical Issues** (prioritized list with specifics)
- **Recommendations** (actionable next steps)
- **Assessment Verdict** (binary ready/not-ready with rationale)

All Cross-Analyses Should Include:

- **Alignment Assessment** (areas of agreement)
- **Tension Identification** (areas of disagreement)
- **Integration Recommendations** (how to resolve conflicts)
- **Confidence Levels** (high/medium/low for each finding)

**Quality Metrics:**

Assessment Quality Indicators:

- **Specificity**: File paths, exact recommendations, effort estimates
- **Evidence**: Citations from actual project materials
- **Actionability**: Clear next steps with definition-of-done
- **Scope Adherence**: Staying within assigned cognitive role

---

## 🔒 **5. Security & Compliance**

Security considerations and compliance requirements for prompt template usage.

### Prompt Security Considerations

**Content Exposure Management:**

- Prompts may be logged by AI model providers
- Avoid including sensitive project details in prompt templates
- Use placeholder patterns for confidential information
- Consider prompt sanitization for regulated industries

### Model-Specific Privacy Controls

**ChatGPT Considerations:**

- Review OpenAI data usage policies for uploaded content
- Consider using ChatGPT Enterprise for enhanced privacy controls
- Be aware of conversation history retention policies

**Gemini Considerations:**

- Understand Google's AI data handling policies
- Consider workspace vs. personal account usage implications
- Review data retention and analysis policies

### Intellectual Property Protection

**Prompt Template Licensing:**

- These templates are provided under project licensing terms
- Modifications and redistribution follow project license
- Cite source when adapting templates for other projects
- Consider IP implications when using with proprietary codebases

---

## 🛠️ **6. Maintenance & Support**

Guidelines for maintaining and supporting cognitive specialization prompt implementation.

### Template Maintenance

**Regular Updates:**

- Periodic review and refinement of templates based on usage experience
- Integration of community feedback and improvement suggestions
- Alignment with evolving AI model capabilities and interface changes
- Coordination with organizational process and tool changes

### Quality Assurance

**Template Validation:**

- Validation of template effectiveness through user feedback
- Regular audit of prompt outcomes and assessment quality
- Continuous improvement of template clarity and actionability
- Support for adapting templates to different project types and contexts

### Implementation Support

**Training and Development:**

- Clear guidance for new practitioners using cognitive specialization prompts
- Examples and case studies demonstrating effective template usage
- Integration with organizational training and development programs
- Mentorship and support for complex prompt customization scenarios

### Template Evolution

**Continuous Improvement:**

- Regular analysis of template effectiveness through outcome tracking
- Integration of lessons learned into template refinement
- Development of specialized templates for different domains and contexts
- Community contribution and feedback integration

---

## 📚 **7. References & Related Resources**

### Internal References

- [📁 Multi-Model Validation Overview](README.md) - Complete methodology context and framework
- [📄 45-Minute Milestone Review](45-minute-milestone-review.md) - Complete orchestration workflow
- [📄 Multi-Model Codebase Analysis](multi-model-codebase-analysis.md) - Repository access and preparation methods
- [📄 Institutional Knowledge Accumulation](institutional-knowledge-accumulation.md) - Context management and storage

### External Resources

- **Prompt Engineering Guide** - General prompt engineering principles
- **OpenAI Best Practices** - ChatGPT-specific optimization techniques
- **Google AI Responsible Practices** - Guidelines for Gemini usage

### Community Resources

- **AI Prompt Sharing Communities** - Open source prompt collections
- **Multi-Agent AI Research** - Academic research on multi-model coordination

---

## 📋 **8. Documentation Metadata**

### Change Log

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 2.0 | 2025-01-22 | Rewritten for semantic numbering compliance and framework standards | VintageDon |
| 1.0 | 2025-01-21 | Initial prompt template documentation with tested examples | VintageDon |

### Authorship & Collaboration

**Primary Author:** VintageDon ([GitHub Profile](https://github.com/vintagedon))  
**ORCID:** [0009-0008-7695-4093](https://orcid.org/0009-0008-7695-4093)  
**AI Assistance:** Claude Sonnet 4  
**Methodology:** RAVGVR (Request-Analyze-Verify-Generate-Validate-Reflect)  
**Quality Assurance:** Validated through real project assessment implementation

### Technical Notes

- **Template Validation:** Tested with RAG-Optimized Documentation Framework project
- **Model Compatibility:** Verified with GPT-4, Gemini Pro, and Claude Sonnet 4
- **Update Frequency:** Prompts refined based on multi-model review outcomes
- **Customization Guidelines:** Templates designed for project-specific adaptation

*Document Version: 2.0 | Last Updated: 2025-01-22 | Status: Published*
