---
description: Review code for convention violations and issues
---

Please review the code for convention violations and issues.

## Step 1: Find and read repo instructions file

Look for the following files in the project repository root (in order of precedence):
- AGENTS.md
- CLAUDE.md
- GEMINI.md

Read the first file found to understand the repo's rules, conventions, do-s, and don't-s.

## Step 2: Get information about changes

- Get the current branch name and compare with main/develop branch
- Get the list of unstaged files (`git diff --name-only`)
- Get the list of staged files (`git diff --cached --name-only`)
- If `$ARGUMENTS` contains a number N, review only the last N commits. Otherwise, review all commits in the current branch since it diverged from main/develop.

## Step 3: Review the changes

Analyze the code for the following issues and classify by severity:

**P0 (Critical)**:
- Security vulnerabilities (exposed secrets, injection vulnerabilities, insecure deserialization)
- Race conditions in concurrent code
- Breaking changes to public APIs
- Data loss risks
- Critical time/space complexity issues (O(n²) where O(n) expected, infinite loops)

**P1 (High)**:
- Naming convention violations
- Folder structure violations
- Types, constants, classes, and functions all in one file
- Memory leaks
- Unhandled error cases
- Missing type hints in typed codebases
- Test coverage gaps for critical paths

**P2 (Medium)**:
- Code duplication
- Missing comments/documentation
- Inconsistent formatting
- Minor performance optimizations
- Unused imports/variables
- Complex nested conditions that could be simplified

## Step 4: Generate review report

Output the review in the following format:

```
# Code Review Report

## Summary
- Branch: [branch-name]
- Commits reviewed: [N or all]
- Files changed: [count]
- Lines added/removed: [count]

## P0 - Critical Issues
1. [File: path/to/file]
   - [Description of issue]
   - Suggested fix: [How to fix]

## P1 - High Priority Issues
1. [File: path/to/file]
   - [Description of issue]
   - Suggested fix: [How to fix]

## P2 - Medium Priority Issues
1. [File: path/to/file]
   - [Description of issue]
   - Suggested fix: [How to fix]

## Approved Files
[List files that follow all conventions]
```

If no issues are found, output: "✅ Code review passed. No convention violations found."

## Step 5: Investigate comments in the Merge Request in Gitlab

Investigate the merge request comments to identify any issues mentioned in the Merge request that was not covered in your code review report.
In order to do so, do the following:

Please use the `glab` CLI to access data from GitLab. The CLI has already been authenticated via the GITLAB_TOKEN environment variable. 

When asked to fetch, summarize, or read comments on a Merge Request, you will need the Project ID and the Merge Request IID. If they are not explicitly provided by the user, use your bash tool to extract them dynamically from the current repository context:

1. **Extract Project ID:** Run `glab repo view -F json | jq '.id'`
2. **Extract Merge Request IID:** Run `glab mr view -F json | jq '.iid'`

Once you have extracted both IDs, fetch the MR notes by executing the following API command via your bash tool:

`glab api projects/<PROJECT_ID>/merge_requests/<MR_IID>/notes > input.json`

Use `/home/asif/.config/opencode/instructions/extract_reviews.sh` to get a structured JSON of the comments.
Analyze the JSON response from the `extract_reviews.sh` script to read the comments, check which comments are unresolved and determine if any code changes are requested.

Lastly, once done, delete `input.json` using the `rm` command. YOU ARE ONLY AUTHORIZED TO USE THE `rm` COMMAND IN THIS SPECIFIC CASE.

## Step 6: Recommendations

Provide 2-3 actionable recommendations for improving code quality based on the patterns observed.
