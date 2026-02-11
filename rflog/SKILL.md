---
name: rflog
description: "Track function-level code changes across git repositories using Redis Search indexes with LLM-powered descriptions. Use when: (1) bootstrapping a repo to index its function change history, (2) logging a function change after committing code, (3) querying function change history or descriptions, (4) reviewing a diff with LLM commentary, (5) updating a function's description. Triggers on requests like 'log this change', 'what changed in this function', 'bootstrap this repo', 'review this diff', 'describe this function'."
---

# rflog — Function Change Tracker

Track function-level code changes across git repositories using Upstash Redis Search indexes, with optional OpenAI-powered descriptions and diff reviews.

## Setup

Before first use, run the install script to ensure `rflog` is available:

```bash
scripts/ensure_installed.sh
```

Required environment variables (in `.env` or exported):
- `UPSTASH_REDIS_REST_URL` — Upstash Redis REST URL
- `UPSTASH_REDIS_REST_TOKEN` — Upstash Redis REST token
- `OPENAI_API_KEY` (optional) — Required only for `--use-llm` and `review-diff`

One-time index setup:

```bash
rflog setup-indexes
```

## Workflows

### Bootstrap a Repository

Index a repo's git history and function descriptions into Redis.

```bash
rflog bootstrap /path/to/repo --max-commits 50
```

With LLM-generated descriptions and change reasons:

```bash
rflog bootstrap /path/to/repo --max-commits 50 --use-llm
```

Partial bootstrap:

```bash
rflog bootstrap /path/to/repo --history-only
rflog bootstrap /path/to/repo --descriptions-only --use-llm
```

### Log a Function Change

After committing code, log which functions changed and why.

With LLM (auto-generates reason and description from the diff):

```bash
rflog log -f "functionName" --use-llm
```

Manual:

```bash
rflog log -f "functionName" -r "Added input validation" -d "Validates and sanitizes user input before processing"
```

### Query Change History

Search what changed, when, and why:

```bash
rflog query -f "functionName"
rflog query -k "authentication" -a "John Doe"
rflog query --from "2025-01-01" --to "2025-06-01"
rflog query --descriptions -k "parsing"
```

### Review a Diff

Get LLM commentary on a function's changes:

```bash
rflog review-diff -f "functionName"
rflog review-diff -f "functionName" --commit abc1234
```

### Update a Function Description

Overwrite a function's stored description:

```bash
rflog log -f "functionName" -d "New description" -r "Description update"
rflog log -f "functionName" --use-llm
```

## Command Reference

For full option details, see [references/commands.md](references/commands.md).
