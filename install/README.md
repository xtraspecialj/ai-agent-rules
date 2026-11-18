# Install

Pick your client. The protocol is the same everywhere, only the file location changes.

## Copilot in VS Code

Repo scope, applies to every chat request in that repository:

1. `copilot/copilot-instructions.md` goes to `.github/copilot-instructions.md`
2. `copilot/instructions/memory-bank.instructions.md` goes to `.github/instructions/`
3. `copilot/prompts/mb-prune.prompt.md` goes to `.github/prompts/`, then type `/mb-prune` in chat
4. `template/` goes to `memory-bank/`

User scope, so the voice rules follow you into every repo:

1. Command Palette, `Chat: Configure Instructions`, or the Customizations editor under Instructions, then `+` next to User
2. Add `user/global-tone.md`

Do not ship both `AGENTS.md` and `.github/copilot-instructions.md` with the same text. Both are always-on, so you pay for the rules twice on every request. Pick one. `AGENTS.md` at the repo root is the better choice if the same repo is also opened in Cursor, Codex, or Claude Code.

## Cline

- Global: `Documents\Cline\Rules\` on Windows, `~/.cline/rules/` for the Cline CLI
- Per project: `.clinerules/memory-bank.md`

Use `cline/memory-bank.md` as is. It is the Cline-format version, with the protocol phrased for Cline's tools and its Rules directory.

## Cursor

- `.cursor/rules/memory-bank.mdc` with `alwaysApply: true` in the front matter
- Or `AGENTS.md` at the repo root

## Claude Code

- `~/.claude/CLAUDE.md` for global scope, `CLAUDE.md` at the repo root for project scope
- Recent versions also read `AGENTS.md`

## Verify it worked

1. Start a new chat.
2. Ask something the summary should answer.
3. Confirm the agent read `memory-bank/summary.md` before anything else. In Copilot, the References section lists which files were included, which tells you about inclusion but not compliance.
4. If it went straight to searching the codebase, the instruction file is not being picked up. Check the file name and location first, then the front matter.

## Notes

- `applyTo: "memory-bank/**"` loads the file rules only when the agent touches bank files, which keeps them out of unrelated requests.
- Agents follow imperative steps better than descriptions. When a rule gets ignored, rewrite it as a numbered action before adding more rules.
- Instruction files are not a security boundary. Keep secrets out of the repo and reference where they live instead.
