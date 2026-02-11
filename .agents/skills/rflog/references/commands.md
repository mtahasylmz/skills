# rflog Command Reference

## setup-indexes

Create Redis Search indexes (one-time setup).

```bash
rflog setup-indexes
```

Requires `UPSTASH_REDIS_REST_URL` and `UPSTASH_REDIS_REST_TOKEN` in environment or `.env`.

## bootstrap

Parse git history and generate function descriptions for a repository.

```bash
rflog bootstrap <repo-path> [options]
```

Options:
- `--max-commits <n>` — Limit commits to process (default: 500)
- `--branch <branch>` — Specific branch to scan
- `--history-only` — Only parse git history, skip description scanning
- `--descriptions-only` — Only scan descriptions, skip history
- `--use-llm` — Use OpenAI to generate descriptions and change reasons (requires `OPENAI_API_KEY`)

## log

Log a single function change. Reads the latest commit's diff automatically.

```bash
rflog log -f <function_name> [options]
```

Options:
- `-f, --function <name>` — Function name (required)
- `-r, --reason <reason>` — Reason for change (required unless `--use-llm`)
- `-d, --description <desc>` — Function description (required unless `--use-llm`)
- `-p, --repo-path <path>` — Repository path (default: `.`)
- `--use-llm` — Auto-generate reason and description from diff (requires `OPENAI_API_KEY`)

## review-diff

Get LLM commentary on a function's diff.

```bash
rflog review-diff -f <function_name> [options]
```

Options:
- `-f, --function <name>` — Function name (required)
- `--commit <hash>` — Specific commit hash (default: latest)
- `-p, --repo-path <path>` — Repository path (default: `.`)

Requires `OPENAI_API_KEY`.

## query

Search function change history or descriptions.

```bash
rflog query [options]
```

Options:
- `-f, --function <name>` — Filter by function name
- `-a, --author <author>` — Filter by author
- `--from <date>` — From date (ISO 8601)
- `--to <date>` — To date (ISO 8601)
- `-k, --keyword <keyword>` — Full-text search
- `-l, --limit <n>` — Max results (default: 20)
- `--asc` — Sort ascending
- `--descriptions` — Search function descriptions instead of changes
