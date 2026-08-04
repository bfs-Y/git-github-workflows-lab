# git-github-workflows-lab

A self-directed, evidence-based training repo for Git and GitHub workflows —
branching strategy, commit hygiene, PR discipline, merge conflict resolution,
rollback/revert under pressure, git bisect, and a multi-fault capstone incident.

## Why this exists

Most Git tutorials teach syntax. This repo is built around a different
standard: every phase requires build, automate, break, pressure-test, fix,
harden, test/log, postmortem, run against a real repo, with real command
output as evidence, not recited definitions or copy-pasted fixes.

The goal is to be trustworthy with commit access and merge rights on a real
production system under real pressure, not to pass a quiz on Git flags.

## Repo structure

- phase-0-foundation/ - Repo hygiene, .gitignore, README, /lab-notes format, branch protection baseline
- phase-1-branching-strategy/ - Trunk-based vs GitFlow vs GitHub Flow, chosen and justified per scenario
- phase-2-commit-hygiene/ - Atomic commits, commit message quality, rebase -i, commit --amend
- phase-3-pr-discipline/ - PR descriptions a zero-context reviewer could act on, review etiquette, required checks
- phase-4-merge-conflict-resolution/ - Reading conflict markers, resolving with understanding of both sides intent
- phase-5-rollback-revert-under-pressure/ - Revert vs hard reset vs forward-fix, force-push consequences, timed
- phase-6-git-bisect/ - git bisect with a real automated test as the criterion, not manual inspection
- phase-7-capstone-incident/ - Multi-fault incident combining several phases at once, timed, no hints
- lab-notes/ - Dated, blameless postmortems, one per session, evidence-based, hand-off ready

## Lab cycle (applies to every phase, no exceptions)

1. Build it correctly first, manually.
2. Automate the safe version - a guardrail enforced by tooling (branch protection, CI check, pre-commit hook, PR template) rather than relying on discipline alone.
3. Break it - deliberately create the failure mode the phase is about.
4. Pressure-test - simulate the realistic time-pressured or adversarial version of the same failure.
5. Fix using evidence (git log, git reflog, git diff), not guesswork.
6. Harden - the guardrail that prevents this class of mistake, not just this one instance of it.
7. Test/Log - prove the guardrail actually holds by attempting the same mistake again and confirming it's caught.
8. Postmortem - written to /lab-notes: what happened, the actual root cause, the evidence, the guardrail now in place.

## Progression rule

A phase is not complete because its folder exists. It's complete when I can, unprompted:

- Explain the phase's core Git mechanism correctly, with evidence (git log / git reflog / actual command output), not recitation.
- Run the full lab cycle for that phase with only clarifying questions from a mentor.
- Produce a /lab-notes entry that could hand off to a teammate with zero additional context.
- Answer that phase's flashcard set cold, correctly, with reasoning, not the memorized command.

No credit for effort. Credit for evidence.

## Status

Currently in progress: Phase 0 - Foundation.
See /lab-notes for dated session-by-session progress and postmortems.
