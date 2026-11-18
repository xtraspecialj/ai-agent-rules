# Cline Memory Bank - Two-Tier Rules

Install to `.clinerules/memory-bank.md` in the project root, or paste into Cline Settings > Rules > Global Rules. See `install/README.md`.

The Copilot-format version of this protocol is in `copilot/copilot-instructions.md`. The rules are the same, phrased for each client's file locations and tools.

## 1. Purpose

Cline has no memory between tasks. The Memory Bank is a set of Markdown files in the project that gives it persistent context without re-scanning the whole codebase every task.

This is a two-tier system:
- Tier 1: One small summary file, read every task. Cheap.
- Tier 2: Six detailed files, read only when the summary says you need depth. Expensive, but only on demand.

## 2. Files

```
memory-bank/
├── summary.md          # Tier 1 — READ THIS FIRST, every task
├── projectbrief.md     # Tier 2 — scope, goals, non-goals
├── productContext.md   # Tier 2 — why it exists, users, behavior
├── systemPatterns.md   # Tier 2 — architecture, conventions, decisions
├── techContext.md      # Tier 2 — stack, versions, setup, IPs, commands
├── activeContext.md    # Tier 2 — current work, recent changes, next step
└── progress.md         # Tier 2 — what works, what's left, known issues
```

If `memory-bank/` does not exist, create it on first work in the workspace by scanning the project once, then writing all seven files. Do not create it for a simple Q&A that is not about this workspace.

`summary.md` template:

```markdown
# Memory Bank Summary — last updated: YYYY-MM-DD
tasks_since_prune: 0

## Where to find what
- projectbrief.md — [one line]
- productContext.md — [one line]
- systemPatterns.md — [one line]
- techContext.md — [one line]
- activeContext.md — [one line]
- progress.md — [one line]

## Key facts for most tasks
- [3-5 facts you need constantly, e.g. Server A 192.168.4.10, Proxmox 9.2.10]

## Current focus
- [what is in flight, next step]
```

Keep `summary.md` under ~1,500 words. It is an index + TL;DR, not a copy of the other files.

Example `summary.md`:

```markdown
# Memory Bank Summary - last updated 2026-11-15
tasks_since_prune: 0

## Where to find what
- projectbrief.md - Proxmox home lab, goal is X, non-goals Y
- techContext.md - Server A 192.168.4.10, Proxmox 9.2.10, Ollama on gaming PC
- activeContext.md - Currently working on Cline + DeepSeek setup, next step is SSH key
- progress.md - Done: Ollama Q3 model tested, DeepSeek key created. To-do: SSH key, test Cline on Proxmox

## Key facts you need most tasks
- Server A IP, Ollama model, DeepSeek model

## Current focus
- Cline + DeepSeek setup, next step is SSH key for Proxmox
```

## 3. Read Protocol — Always Follow

1. **Read `memory-bank/summary.md` first, every task.** Do not list directories or read other files before you have read the summary.
2. **If the summary answers the question, stop.** Do not read Tier 2 files just to be thorough.
3. **If you need depth on one area, read only that one Tier 2 file.** Example: task is about auth code → read `systemPatterns.md` only. Do not read all six.
4. **If the task involves editing code or changing config in an area, read the detailed file for that area.** The summary is for orientation, not for implementation. Do not implement from the summary alone.
5. **If the summary is missing, stale, or does not cover what you need, fall back to a real scan.** Do one orientation scan, then update the summary so the next task does not have to scan again.

### Q&A vs Project Work

- **Question is NOT about this workspace** (e.g. "how does Cline Plan/Act work?"): Answer directly. Do not read files, list directories, or run commands.
- **Question IS about a specific file or the current project in this workspace:** Read the summary first, then the relevant Tier 2 file(s) only.

## 4. Write / Update Protocol

1. When you change anything in a Tier 2 file, you **must** update `summary.md` in the same task. No "update summary later." If you update `progress.md`, update the Current Focus section of the summary in the same turn.
2. Update `activeContext.md` and `progress.md` at the end of every meaningful work session. Update the other files only when their facts change.
3. Increment `tasks_since_prune` in `summary.md` by 1 at the end of every task.
4. Keep entries short. One line per fact. No filler, no restating the plan unless asked.

## 5. Token Efficiency

- Answer questions directly when the question is not specific to this workspace.
- Read each file once per task. Do not re-read a file you already read unless it changed in this task.
- Use search with a specific pattern, not broad directory listings. Never grep minified / built files (`build/`, `dist/`, `*.min.js`, `workbench.*.js`, `node_modules/`).
- Combine searches into one pass. Extract all needed values in one command, not one grep per pattern.
- Prefer `read_files` over `run_commands` for reading configs. Use `run_commands` only when you must execute something.
- Keep output concise. No filler, no re-stating the plan unless asked.
- If a simple question needs more than 5 tool calls, stop and ask before continuing.
- For a new question, start a new task (`/newtask`). Use `/smol` to compact when context gets large.

## 6. Pruning / Cleanup — Cheap Check Only

Do NOT re-read every file at the end of every task to check if pruning is needed. That defeats the purpose.

**Cheap check (every task, no content reads):**
- Check file sizes via a single directory listing of `memory-bank/`. Do not read file contents for this check.
- If total size is under the cap, do nothing.

**Prune triggers — whichever hits first:**
- Any single file exceeds ~2,000 tokens (~1,500 words), OR
- Total `memory-bank/` exceeds ~8,000 tokens (~6,000 words), OR
- `tasks_since_prune` in `summary.md` reaches 10

**When triggered, do a full prune pass, then reset `tasks_since_prune` to 0:**
- Remove stale / no-longer-relevant items. Mark anything older than 30 days with no relevance as stale and remove it, unless it is a stable fact (e.g. Server IP, Proxmox version, tech stack).
- Merge duplicate facts. Keep the newest version only.
- Shorten verbose entries to one line.
- Update `summary.md` to reflect the pruned files in the same pass.

**Age rule:**
- Stable facts (scope, stack, IPs, architecture): keep indefinitely.
- Volatile facts (recent work, to-dos, open questions): prune if older than 30 days and no longer relevant.

## 7. First-Time Setup

When you first work in a new workspace:
1. Do one orientation scan, like you normally would.
2. Create `memory-bank/` with all seven files.
3. Write a concise `summary.md` from what you found.
4. Do not re-scan the full tree on later tasks — read the summary first.

---

*Based on Cline's Memory Bank methodology, adapted to a two-tier summary-first design with size + task-count pruning.*
