# PatchGuard

An automated code review system that uses AI agents to analyze GitHub pull requests for security vulnerabilities, dependency issues, and code quality — powered by a locally running Gemma 4 model for its exceptional context window and token capacity, with no data leaving your machine.

## How it works

PatchGuard listens for GitHub webhook events when a PR is opened or updated. It runs the diff through a set of specialized AI agents powered by a local Gemma 4 instance (via Ollama), then posts a structured review back to the PR.

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
- Gemma 4 (local via Ollama) — AI agent backbone, runs fully on-device

## Prerequisites

- Docker & Docker Compose
- Python 3.10+
- A GitHub account with a repo you can add webhooks to
- [Ollama](https://ollama.com) installed and running with the Gemma 4 model pulled

## Setup

1. Clone the repo and create your env file:
   ```bash
   git clone https://github.com/Jwat205/patchguard.git
   cd patchguard
   cp .env.example .env
   ```

2. Pull the Gemma 4 model via Ollama:
   ```bash
   ollama pull gemma4
   ```

3. Fill in your credentials in `.env`:
   ```
   GITHUB_TOKEN=...
   GITHUB_WEBHOOK_SECRET=...
   OLLAMA_BASE_URL=http://localhost:11434
   ```

4. Start all services:
   ```bash
   make docker-up
   ```

   The API will be available at `http://localhost:8000`.

5. Point your GitHub webhook at `http://<your-host>:8000/webhooks/github` with content type `application/json`.

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
| `OLLAMA_BASE_URL` | Ollama server URL (default: `http://localhost:11434`) |
| `DATABASE_URL` | PostgreSQL connection string |
| `MONGODB_URL` | MongoDB connection string |
| `REDIS_URL` | Redis connection string |
| `KAFKA_BROKERS` | Kafka broker address |

See `.env.example` for the full list.

## License

MIT
