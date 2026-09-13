# ROADMAP

Status legend: `not started` / `in progress` / `done`.
"Proven" means the guardrail or fix has actually been tested against a
fresh attempt at the mistake it's meant to catch — not just built and
assumed to work. See `lab-notes/` for the evidence behind any "done" status.

## phase-0-foundation

| Item | Status | Notes |
|---|---|---|
| `.gitignore` | done | Added 2026-09-13, covers common secret-shaped file patterns. |
| Pre-commit secret-scanning hook | done, proven | Existed since 2026-07-31 but was never tested — written 2 minutes *after* the incident it was meant to catch. Had two real bugs (blocked deletions, then a syntax error from the first fix) both found and fixed 2026-09-13. Proven working against a fresh test commit same day. Full writeup: `lab-notes/2026-09-13-secret-hook-failure-postmortem.md`. |
| Branch protection baseline | not started | README scope calls for this in phase-0; not yet configured on GitHub. |
| `/lab-notes` format established | in progress | Two entries exist (2026-07-31, 2026-09-13). Format is consistent but not yet written down as a template. |

## phase-1-branching-strategy

| Item | Status | Notes |
|---|---|---|
| Everything | not started | Folder exists, empty. |

## phase-2-commit-hygiene

| Item | Status | Notes |
|---|---|---|
| Everything | not started | Folder exists, empty. |

## phase-3-pr-discipline

| Item | Status | Notes |
|---|---|---|
| Everything | not started | Folder exists, empty. |

## phase-4-merge-conflict-resolution

| Item | Status | Notes |
|---|---|---|
| Everything | not started | Folder exists, empty. |

## phase-5-rollback-revert-under-pressure

| Item | Status | Notes |
|---|---|---|
| Everything | not started | Folder exists, empty. |

## phase-6-git-bisect

| Item | Status | Notes |
|---|---|---|
| Everything | not started | Folder exists, empty. |

## phase-7-capstone-incident

| Item | Status | Notes |
|---|---|---|
| Everything | not started | Build last — needs real material from phases 1-6 to combine into a genuine multi-fault incident. |

## Known gaps as of last review (2026-09-13)

- Branch protection baseline (part of phase-0's own stated scope) is not
  yet configured.
- Phases 1 through 6 are entirely unstarted — only phase-0 has real,
  evidence-backed work behind it.
- No `/lab-notes` entry template exists yet, despite two entries already
  following a consistent shape by hand. Worth formalizing before phase-1
  starts generating more.
