---
description: Collect product context and prepare inputs for speckit.constitution.md
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

The text the user typed after `/product-intake` in the triggering message **is** the description. Assume you always have it available even if `$ARGUMENTS` appears literally below.

**🧭 PRODUCT INTAKE - COLLECT PRODUCT CONTEXT**

Given that description, do this:

1. Run the script `.specify/scripts/bash/create-product-intake.sh --json "$ARGUMENTS"` from repo root and parse its JSON output for WORKFLOW_ID, BRANCH_NAME, TEMPLATE_FILE, TASKS_FILE, and WORKFLOW_NUM. All file paths must be absolute.
   **IMPORTANT** You must only ever run this script once. The JSON is provided in the terminal as output - always refer to it to get the actual content you're looking for.

2. Load `.specify/extensions/workflows/product-intake/template.md` to understand required sections.

3. Write the workflow documentation to TEMPLATE_FILE using the template structure. Ensure the file remains an instruction set for invoking `.specify/memory/constitution.md` (the `speckit.constitution.md` skill) and includes a complete input payload.

4. Review the tasks.md file and ensure it aligns with the documentation and the required inputs for the skill.

5. Report completion with:
   - **STATUS**: Workflow initialized
   - Workflow ID
   - Branch name
   - Template file path
   - Tasks file path
   - **NEXT STEPS**: Collect sources and run `.specify/memory/constitution.md`
   - **REMINDER**: This workflow's template is the instruction file for the skill invocation

Note: If any required product inputs are missing, list them explicitly and mark them as open questions in the template.
