#!/bin/bash
set -e

echo "Setting up PatchGuard..."

if [ ! -f .env ]; then
    cp .env.example .env
    echo ".env created — fill in GITHUB_TOKEN, GITHUB_WEBHOOK_SECRET, ANTHROPIC_API_KEY then re-run."
    exit 1
fi

pip install -r requirements-dev.txt
pre-commit install

docker-compose up -d
echo "Waiting for services to be healthy..."
sleep 15

docker-compose exec -T api alembic upgrade head

echo ""
echo "Setup complete!"
echo "  API:      http://localhost:8000"
echo "  API Docs: http://localhost:8000/docs"
