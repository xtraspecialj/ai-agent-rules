---
mode: 'agent'
description: 'Run the Memory Bank prune pass'
---

Prune `memory-bank/`.

1. List `memory-bank/` with file sizes. Do not read contents yet.
2. If every file is under about 2,000 tokens, the folder is under about 8,000, and `tasks_since_prune` is below 10, say so and stop.
3. Otherwise read the files that exceed a cap, plus `summary.md`.
4. Remove stale entries. Merge duplicates keeping the newest. Cut verbose entries to one line.
5. Keep stable facts: scope, stack, architecture, hosts, addresses. Drop volatile facts older than 30 days that no longer matter.
6. Update `summary.md` to match the pruned files. Set `tasks_since_prune` to 0. Update `last updated`.
7. Report what changed as a short list.
