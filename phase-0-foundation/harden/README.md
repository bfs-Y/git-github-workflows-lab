# Secret-scanning pre-commit hook

This is the actual, working hook developed and proven in phase-0 (see
../postmortem/ and ../test-log.md for the full history). It's committed
here as a real file because git hooks in `.git/hooks/` are NOT tracked by
git and do NOT travel with a clone — a real gap this repo's own phase-0
work uncovered.

## To install after cloning this repo

    cp phase-0-foundation/harden/pre-commit-secret-scan.sh .git/hooks/pre-commit
    chmod +x .git/hooks/pre-commit

## What it catches

Blocks any commit that adds a line matching `SECRET=`, `PASSWORD=`, or
`API_KEY=` (case-sensitive, added lines only — deletions are not flagged).

## Known limitation

This is a simple grep-based pattern match, not a real secret-detection
tool. It will false-positive on any file that legitimately discusses these
patterns as text (like this repo's own postmortems) and will miss any
secret that doesn't match one of these three exact variable-name patterns.
For real projects, a proper tool like `gitleaks` or `detect-secrets` would
catch far more — this hook is a teaching example, not production-grade
secret scanning.
