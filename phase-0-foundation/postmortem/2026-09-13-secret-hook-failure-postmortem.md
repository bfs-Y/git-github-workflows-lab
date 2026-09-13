# Postmortem: I wrote the hook after the mistake it was supposed to catch

> **CORRECTION (2026-09-13, later same day):** everything below this
> notice is wrong about the timeline, and I'm leaving it in place rather
> than deleting it because being wrong three times in a row before finding
> the actual record is itself the lesson. `lab-notes/2026-07-31-phase0.md`
> — a file that existed the entire time and was never checked while
> writing this — shows the hook was tested and genuinely worked that same
> night, against a file called `test-secret2.env`, hours after `ff0cbae`.
> The `ff0cbae` "test if hook blocks secret" commit wasn't a hook that
> hadn't been written yet — it was a **false-positive test**: the hook
> script existed but hadn't actually saved due to a nano quirk, so nothing
> was really being tested. That was caught the same night, the hook was
> rewritten using `cat > file << EOF` instead of nano, and re-verified
> working against `test-secret2.env`. So the hook was proven six weeks
> *before* tonight, not six weeks of sitting untested as this file claims
> below. See the corrected timeline in `ROADMAP.md`.

---

## What happened

On 2026-07-31, I committed a small env file containing a fake credential
in `ff0cbae` at 16:31:47, labeled "test if hook blocks secret." I wrote
the actual pre-commit hook two minutes later, at 16:33:42. The hook never
had a chance to catch anything — by the time it existed, the thing it was
meant to catch was already sitting in history.

## Why it actually happened

I think I built the hook backwards from how testing is supposed to work.
Instead of writing the guardrail first and then trying to break past it, I
committed the secret, then wrote the hook afterward, as if writing the
hook after the fact would somehow prove anything. It doesn't. A guardrail
only means something if it's in place *before* the thing it's guarding
against happens, and I never went back to actually test the hook against
a fresh attempt — not until today.

## The evidence

- `git log -1 --format="%H %ai" ff0cbae` shows the secret commit at
  16:31:47.
- The hook file's filesystem timestamp shows 16:33:42 — two minutes later.
- The hook was real and had been sitting there the whole time, checking
  staged diffs for a few obvious secret-shaped patterns. It had just never
  been tested against an actual new attempt to commit a secret, only
  assumed to work because it existed.

## The bugs I found while finally testing it

Fixing this properly surfaced two separate, real bugs in the hook, not
just the missing test:

1. **It scanned the whole diff, including removed lines.** The original
   version blocked me from *deleting* the old fake-secret file, because
   `git diff --cached` shows removed lines too and the pattern matched
   regardless of direction. I narrowed the check to only match added lines
   (`^\+.*(SECRET=|PASSWORD=|API_KEY=)`).

2. **My first fix for bug #1 broke the script entirely.** I introduced a
   duplicated `if if` on the same line while editing, which meant the
   hook failed with a shell syntax error instead of running at all. For
   a short window, the guardrail wasn't too broad — it wasn't running,
   period. Caught it with `sh -n .git/hooks/pre-commit`, fixed the typo,
   reverified clean syntax before trusting it again.

## What I fixed today

- Added a `.gitignore` covering common secret-shaped file patterns —
  something that didn't exist at all until now.
- Fixed the hook to only flag added lines, not removed ones.
- Fixed the syntax error my own first fix introduced.
- Removed the leftover fake-secret file from the working tree. Left it in
  git history on purpose — the timestamps on that commit are the actual
  evidence for this whole postmortem, and erasing it would erase the proof
  along with the mistake.

## What I proved today

I staged a new file containing a fake `API_KEY=` line and tried to commit
it. The hook blocked it, correctly, with the same error message it was
always supposed to produce — the first time this hook has actually caught
anything since it was written, roughly six weeks after it was created.
This is the guardrail finally proven, not just assumed.

## The actual lesson

A hook that exists isn't the same as a hook that's been proven to work. A
hook written two minutes after the incident it was meant to prevent
doesn't prove anything at all — and neither does a hook nobody's tried to
break past since. If I want to trust a guardrail, I have to watch it catch
something first, on purpose, before I ever rely on it for real. That's
literally step 7 of this repo's own lab cycle, and I skipped it for six
weeks without noticing.
