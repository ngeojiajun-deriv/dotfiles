---
name: gh-pr-review
description: Reviews a GitHub pull request by URL — fetches PR metadata, comments, reviews, and diff via gh CLI, then produces structured findings.
---

# GitHub PR Code Review

## Trigger

User provides a GitHub PR URL (e.g. `https://github.com/org/repo/pull/123`) and asks for a review.

## Workflow

1. **Extract repo and PR number** from the URL.
2. **Fetch PR metadata** (title, body, author, state, files, comments, reviews):
   ```
   gh pr view <number> --repo <owner/repo> --json title,body,state,author,baseRefName,headRefName,files,comments,reviews,additions,deletions,changedFiles
   ```
3. **Fetch the diff** — dump to a temp file to avoid terminal overflow:
   ```
   gh pr diff <number> --repo <owner/repo> > /tmp/pr<number>.diff
   ```
4. **Read the diff** in chunks (500 lines at a time) to stay within context limits.
5. **Load relevant language skills** (e.g. `python-dev`, `nodejs-dev`, `common-dev`) based on the file types in the PR. Apply those conventions during review.
6. **Review existing comments and reviews** on the PR — incorporate and avoid duplicating points already raised.
7. **Produce findings** organized by severity.

## Output Format

Findings grouped under these severity headings (skip empty groups):

- **Critical** — merge-blockers: runtime crashes, data loss, broken contracts
- **Security** — auth gaps, injection, secret exposure, unsafe defaults
- **Skill/Convention Violations** — violations of loaded language/common-dev skills
- **Code Quality** — leaks, dead code, poor patterns, missing error handling
- **Test Gaps** — untested files or uncovered critical paths
- **Existing Review Comments** — unresolved feedback from other reviewers

Each finding should:
- Reference the specific file and describe the issue concisely
- Explain *why* it matters (crash, security, maintainability)
- Suggest a fix direction when non-obvious

End with a short summary of which items are merge-blockers.

## Rules

- Do NOT comment on or interact with the PR — read-only review only
- Do NOT duplicate points already raised in existing PR comments/reviews; instead reference them
- Focus on substantive issues, not style nitpicks (unless they violate a loaded skill)
- When the diff is large, prioritize source code over tests and config files
