<INSTRUCTIONS>
## Skills
A skill is a local instruction set stored in a markdown file. The skills for this repo live in `.codex/prompts`.

### Available skills
- product-intake: Collect product context and prepare inputs for speckit.constitution. (file: /home/alex/projects/pkit/.codex/prompts/product-intake.md)
- speckit.analyze: Cross-artifact consistency and quality analysis across spec.md, plan.md, tasks.md. (file: /home/alex/projects/pkit/.codex/prompts/speckit.analyze.md)
- speckit.checklist: Generate a custom checklist for the current feature based on user requirements. (file: /home/alex/projects/pkit/.codex/prompts/speckit.checklist.md)
- speckit.clarify: Ask targeted questions and encode answers back into the spec. (file: /home/alex/projects/pkit/.codex/prompts/speckit.clarify.md)
- speckit.constitution: Create or update the project constitution and keep dependent templates in sync. (file: /home/alex/projects/pkit/.codex/prompts/speckit.constitution.md)
- speckit.implement: Execute the implementation plan by processing tasks.md. (file: /home/alex/projects/pkit/.codex/prompts/speckit.implement.md)
- speckit.plan: Generate implementation planning artifacts using the plan template. (file: /home/alex/projects/pkit/.codex/prompts/speckit.plan.md)
- speckit.specify: Create or update the feature specification from a natural language description. (file: /home/alex/projects/pkit/.codex/prompts/speckit.specify.md)
- speckit.tasks: Generate an actionable, dependency-ordered tasks.md. (file: /home/alex/projects/pkit/.codex/prompts/speckit.tasks.md)
- speckit.taskstoissues: Convert tasks into dependency-ordered GitHub issues. (file: /home/alex/projects/pkit/.codex/prompts/speckit.taskstoissues.md)

### How to use skills
- If the user names a skill (e.g. "product-intake" or "/speckit.plan") or the task clearly matches a skill description, open the listed file and follow its instructions.
- Use only the minimal set of skills that cover the request. If you skip an obvious skill, say why.
- Keep context small: only load additional files referenced by the skill when needed.
</INSTRUCTIONS>
