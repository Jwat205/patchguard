.PHONY: help setup install dev test lint format type-check docker-up docker-down migrate clean

help:
	@echo "PatchGuard - Available commands:"
	@echo "  make setup       - Full local environment setup"
	@echo "  make install     - Install Python dependencies"
	@echo "  make dev         - Start dev server (hot reload)"
	@echo "  make test        - Run all tests"
	@echo "  make lint        - Run linters"
	@echo "  make format      - Auto-format code"
	@echo "  make type-check  - Run mypy"
	@echo "  make docker-up   - Start all Docker services"
	@echo "  make docker-down - Stop all Docker services"
	@echo "  make migrate     - Run DB migrations"
	@echo "  make clean       - Remove build/cache artifacts"

setup:
	bash scripts/setup.sh

install:
	pip install -r requirements-dev.txt

dev:
	uvicorn src.main:app --reload --host 0.0.0.0 --port 8000

test:
	pytest tests/ -v

test-unit:
	pytest tests/ -v -k "not integration"

test-integration:
	pytest tests/integration/ -v

lint:
	flake8 src/ tests/
	pylint src/

format:
	black src/ tests/
	isort src/ tests/

type-check:
	mypy src/

docker-up:
	docker-compose up -d
	@echo "Waiting for services..."
	@sleep 10
	@echo "API ready at http://localhost:8000"

docker-down:
	docker-compose down

docker-build:
	docker-compose build

docker-logs:
	docker-compose logs -f

migrate:
	alembic upgrade head

migrate-create:
	alembic revision --autogenerate -m "$(msg)"

migrate-down:
	alembic downgrade -1

clean:
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	rm -rf .coverage htmlcov/ .mypy_cache/ .pytest_cache/ dist/ build/
