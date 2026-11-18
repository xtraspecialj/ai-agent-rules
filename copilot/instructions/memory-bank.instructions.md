---
applyTo: "memory-bank/**"
description: "Maintenance rules for Memory Bank files"
---

# Memory Bank file rules

- One line per fact. No paragraphs where a line will do.
- `summary.md` is an index plus a TL;DR. Keep it under 1,500 words and never let it become a copy of the Tier 2 files.
- Bump `tasks_since_prune` in `summary.md` at the end of each task.
- Dates in `YYYY-MM-DD`. Update `last updated` in `summary.md` whenever its content changes.
- Stable facts belong in the Tier 2 file that owns them, then get referenced from `summary.md` in one line.
- Volatile facts belong in `activeContext.md` and `progress.md` only.
- No secrets, tokens, passwords, or private keys. Record where they live instead.
- Deleting is normal. Stale beats complete.
