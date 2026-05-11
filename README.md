# PatchGuard

An automated code review system that uses AI agents to analyze GitHub pull requests for security vulnerabilities, dependency issues, and code quality.

## How it works

PatchGuard listens for GitHub webhook events when a PR is opened or updated. It runs the diff through a set of specialized AI agents powered by Claude, then posts a structured review back to the PR.

**Agents:**
- **Security** — scans for OWASP Top 10 issues, exposed secrets, and injection risks
- **Dependency** — flags outdated or vulnerable packages
- **Quality** — reviews code style, structure, and maintainability

**Stack:**
- FastAPI — REST API and webhook receiver
- Kafka — event queue for PR events and review results
- PostgreSQL — structured review data
- MongoDB — raw event and diff storage
- Redis — caching
- Anthropic Claude — AI agent backbone

## Prerequisites

- Docker & Docker Compose
- Python 3.10+
- A GitHub account with a repo you can add webhooks to
- An [Anthropic API key](https://console.anthropic.com)

## Setup

1. Clone the repo and create your env file:
   ```bash
   git clone https://github.com/Jwat205/patchguard.git
   cd patchguard
   cp .env.example .env
   ```

2. Fill in your credentials in `.env`:
   ```
   GITHUB_TOKEN=...
   GITHUB_WEBHOOK_SECRET=...
   ANTHROPIC_API_KEY=...
   ```

3. Start all services:
   ```bash
   make docker-up
   ```

   The API will be available at `http://localhost:8000`.

4. Point your GitHub webhook at `http://<your-host>:8000/webhooks/github` with content type `application/json`.

## Development

```bash
# Install dependencies
make install

# Run dev server (hot reload)
make dev

# Run tests
make test

# Lint
make lint

# Type check
make type-check
```

## Environment Variables

| Variable | Description |
|---|---|
| `GITHUB_TOKEN` | GitHub personal access token |
| `GITHUB_WEBHOOK_SECRET` | Secret used to verify webhook payloads |
| `ANTHROPIC_API_KEY` | Claude API key |
| `DATABASE_URL` | PostgreSQL connection string |
| `MONGODB_URL` | MongoDB connection string |
| `REDIS_URL` | Redis connection string |
| `KAFKA_BROKERS` | Kafka broker address |

See `.env.example` for the full list.

## License

MIT
