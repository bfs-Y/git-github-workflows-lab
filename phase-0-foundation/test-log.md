# Test Log — phase-0-foundation

Actual test evidence for the pre-commit secret-scanning hook. Full
narrative and root-cause analysis lives in postmortem/; this file is the
condensed, transcript-style record of what was actually run and observed.

## 2026-07-31 — first test (false positive)

Hook wasn't actually testable — file hadn't saved due to a nano quirk.
`git status` showed no hook behavior at all when a fake secret was staged.
Caught, rewritten using `cat > file << EOF`, verified content with `cat`.

## 2026-07-31 — second test (genuine pass)

Staged `test-secret2.env` containing a fake secret pattern. `git status`
confirmed the file remained staged, not committed — hook blocked it
correctly.

## 2026-09-13 — regression found and fixed

Attempted to `git rm` the original `test-secret.env` file (unrelated
cleanup, months later). Hook blocked the deletion — a real bug, since it
was scanning removed lines in the diff, not just added ones. Narrowed the
grep pattern to `^\+.*(SECRET=|PASSWORD=|API_KEY=)` to only match additions.

## 2026-09-13 — syntax error introduced, then fixed

The fix above introduced a duplicated `if if` on one line, breaking the
script (`sh: line 29: syntax error: unexpected end of file`). Verified
with `sh -n .git/hooks/pre-commit`, fixed the duplicate, reverified clean.

## 2026-09-13 — final proof

Staged `test-secret-check.txt` containing `API_KEY=fake_test_12345`.
Commit attempt output: `+API_KEY=fake_test_12345` / `Error: possible
secret detected in staged changes. Commit blocked.` Hook confirmed working
against a fresh addition, post-fix. Test file removed after.
