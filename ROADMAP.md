# ROADMAP

Status legend: `not started` / `in progress` / `done`.
"Proven" means the guardrail or fix has actually been tested against a
fresh attempt at the mistake it's meant to catch — not just built and
assumed to work. See `lab-notes/` for the evidence behind any "done" status.

## phase-0-foundation

| Item | Status | Notes |
|---|---|---|
| `.gitignore` | done | Added 2026-09-13, covers common secret-shaped file patterns. |
| Pre-commit secret-scanning hook | done, proven | **Corrected timeline (2026-09-13):** proven working on 2026-07-31, the same night it was written — a false-positive first test (`ff0cbae`, hook script hadn't actually saved due to a nano quirk) was caught and fixed same-session, then the rewritten hook correctly blocked `test-secret2.env`. Two additional real bugs (blocked deletions, then a syntax error from that fix) were found and fixed on 2026-09-13 while revisiting this six weeks later. Full history across `lab-notes/2026-07-31-phase0.md` and `lab-notes/2026-09-13-secret-hook-failure-postmortem.md` (see correction notice at top of that file). |
| Branch protection baseline | not started | README scope calls for this in phase-0; not yet configured on GitHub. |
| `/lab-notes` format established | in progress | Two entries exist (2026-07-31, 2026-09-13), consistent shape, not yet written down as a template. |
| Whether `.git/hooks/pre-commit` travels with a clone | resolved (2026-09-13) | It does not — hooks are never tracked by git. This was an open question in `lab-notes/2026-07-31-phase0.md`, never explicitly answered until now. Implication: anyone cloning this repo does NOT get the secret-scanning hook automatically; it would need to be distributed separately (e.g. a setup script, or a tool like `pre-commit` framework) if this guardrail is meant to protect more than just this one local checkout. | `test-secret2.env` disposition | resolved (2026-09-13) | Confirmed gone — not staged, not on disk, working tree clean as of tonight. Whatever happened between 2026-07-31 and now, it's already resolved; no further action needed. |

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
- Phases 1 through 7 now have the full break/fix/harden/postmortem/test-log
  scaffold, but no content — only phase-0 has real, evidence-backed work
  behind it.
- No `/lab-notes` entry template exists yet, despite entries following a
  consistent shape by hand.
- `test-secret2.env`'s disposition from 2026-07-31 was never resolved —
  confirm current `git status` and decide.
- Which auth mechanism authenticated pushes on 2026-07-31 was never
  answered.
- This ROADMAP's own phase-0 history was wrong as of the first version
  written earlier tonight (2026-09-13) — corrected after actually reading
  `lab-notes/2026-07-31-phase0.md`, which had existed the whole time. See
  the correction notice in `lab-notes/2026-09-13-secret-hook-failure-postmortem.md`
  for the full account of getting this wrong three times before checking
  the source.
