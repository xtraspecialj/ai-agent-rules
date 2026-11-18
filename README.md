# AI Agent Rules

Prompt files that give an AI coding agent persistent project memory, and keep it from sounding like a chatbot.

Two pieces:

- **Memory Bank** - a seven-file folder in each project that the agent reads and maintains, so it stops re-scanning the codebase every session.
- **Global tone** - rules for honesty, brevity, and human-sounding writing.

## Layout

| Path | Purpose | Install target |
|---|---|---|
| `copilot/copilot-instructions.md` | Memory Bank protocol, repo scope | `.github/copilot-instructions.md` |
| `copilot/instructions/memory-bank.instructions.md` | Rules for editing the bank files | `.github/instructions/` |
| `copilot/prompts/mb-prune.prompt.md` | `/mb-prune` cleanup pass | `.github/prompts/` |
| `cline/memory-bank.md` | Original Cline-format rules | `.clinerules/` or Cline global rules |
| `user/global-tone.md` | Personal voice rules | User-scope instructions |
| `template/` | Seven skeleton bank files | `memory-bank/` |
| `install/` | Install notes and bootstrap scripts | n/a |

## Quick start (Copilot in VS Code)

1. Copy `copilot/copilot-instructions.md` to `.github/copilot-instructions.md` in your repo.
2. Copy `template/` to `memory-bank/` at the repo root.
3. Open a new chat and ask something about the project. The agent should read `memory-bank/summary.md` before anything else.
4. Add `user/global-tone.md` at user scope if you want the voice rules in every repo.

Full instructions for Copilot, Cline, Cursor, and Claude Code are in `install/README.md`. There are bootstrap scripts per platform in the same folder.

## How it works

Tier 1 is `summary.md`, a short index read on every task. Tier 2 is six detail files, read only when the summary says you need them.

The agent bumps `tasks_since_prune` in `summary.md` once per task, and prunes when the folder passes its size caps or the counter reaches ten.

The point is cost. Re-reading a codebase every session is expensive and forgetful at the same time. A summary-first bank is cheap to read and survives across sessions, model switches, and machines.

## Provenance

Adapted from Cline's Memory Bank methodology, restructured as a two-tier summary-first design with size and task-count pruning.

## License

None. It's plain prompt text. Take it, change it, keep it in your own repo.
