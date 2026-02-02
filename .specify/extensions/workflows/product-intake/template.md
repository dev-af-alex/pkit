# Product Intake: [TITLE]

**Workflow ID**: product-intake-###
**Branch**: `product-intake/###-description`
**Status**: [ ] Intake | [ ] Synthesis | [ ] Validation | [ ] Complete

## Purpose
Describe why this product intake is needed and what decision it supports.

## Instruction: Call `speckit.constitution.md`
This document is the instruction set for invoking the skill located at `.specify/memory/constitution.md`.
When you are ready, run that skill using the inputs captured below.

### Inputs to provide to the skill
- Product name and one-line value proposition
- Target users / primary personas
- Problem statement and current pain points
- Core user journeys (top 3)
- Scope (in-scope vs. out-of-scope)
- Success metrics / KPIs
- Constraints (tech, legal, time, budget)
- Dependencies and integrations
- Existing artifacts (links to specs, docs, repos, designs)

## Phases

### Phase 1: Source Inventory
- List all available sources (docs, tickets, designs, stakeholders)
- Note freshness and ownership of each source
- Capture missing information and who can provide it

### Phase 2: Product Synthesis (for skill input)
- Draft a concise product summary using the inputs section
- Identify contradictions or open questions
- Prepare the exact payload to pass into `speckit.constitution.md`

### Phase 3: Validation
- Confirm summary with stakeholders or source of truth
- Verify constraints and success metrics are realistic
- Ensure all required inputs are present

## Output Expectations
- A complete, ready-to-run input set for `speckit.constitution.md`
- Clear notes on any gaps or assumptions

## Verification Checklist
- [ ] Sources listed with owners and dates
- [ ] Inputs section complete and unambiguous
- [ ] Contradictions resolved or documented
- [ ] Ready to invoke `speckit.constitution.md`

---
*Created using `/product-intake` workflow*
