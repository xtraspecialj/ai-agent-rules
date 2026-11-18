# Memory Bank

You have no memory between sessions. This repository carries its context in `memory-bank/`. Follow this protocol on every task, not only when asked.

## Read order, every task

1. Read `memory-bank/summary.md` first. Before listing directories, before searching, before opening any other file.
2. If the summary answers the question, stop. Do not read Tier 2 files to be thorough.
3. If you need depth in one area, read that one Tier 2 file. Do not read all six.
4. If the task edits code or config in an area, read that area's Tier 2 file before writing anything. The summary orients you, it does not specify implementation.
5. If the summary is missing, stale, or does not cover the task, do one orientation scan, then update `summary.md` so the next task does not repeat it.

## Files

| File | Tier | Contents |
|---|---|---|
| `summary.md` | 1 | Index, key facts, current focus. Under 1,500 words. |
| `projectbrief.md` | 2 | Scope, goals, non-goals. |
| `productContext.md` | 2 | Why it exists, who uses it, expected behaviour. |
| `systemPatterns.md` | 2 | Architecture, conventions, decisions and why. |
| `techContext.md` | 2 | Stack, versions, setup, hosts, IPs, commands. |
| `activeContext.md` | 2 | Current work, recent changes, next step. |
| `progress.md` | 2 | What works, what is left, known issues. |

## Questions versus project work

- Question not about this workspace? Answer it directly. No file reads, no scans, no commands.
- Question about a file or this project? Summary first, then the one relevant Tier 2 file.

## Write protocol

1. Changed a Tier 2 file? Update `summary.md` in the same task. Never defer it.
2. End of every session: update `activeContext.md` and `progress.md`. Touch the other files only when their facts change.
3. Bump `tasks_since_prune` in `summary.md` by one at the end of every task.
4. One line per fact. No filler, no restating the plan.

## Token efficiency

- Read each file once per task.
- Search with a specific pattern instead of listing directories. Skip `node_modules/`, `dist/`, `build/`, and minified files.
- Combine searches. Pull every needed value in one pass rather than one search per pattern.
- Read configs with file reads, not shell commands. Run commands only when something has to execute.
- If a simple question needs more than five tool calls, stop and ask.

## Pruning

Check cheaply every task: one directory listing of `memory-bank/`, sizes only, no content reads. Under the caps, do nothing.

Prune when any of these hits first:

- one file over about 2,000 tokens (about 1,500 words)
- the folder over about 8,000 tokens (about 6,000 words)
- `tasks_since_prune` reaches 10

A prune pass: drop stale entries, merge duplicates keeping the newest, cut verbose entries to one line, update `summary.md` to match, reset `tasks_since_prune` to 0.

Stable facts stay indefinitely: scope, stack, architecture, hostnames, addresses. Volatile facts go if they are older than 30 days and no longer relevant: recent work, to-dos, open questions.

## First-time setup

If `memory-bank/` does not exist: one orientation scan of the project, create all seven files from `template/`, write a concise `summary.md`, then stop scanning. Do not create it for a question that is not about this workspace.

## Keeping this file honest

This file ships with every request, so it stays short. When the protocol changes, edit this file rather than adding a second instruction file that contradicts it.
