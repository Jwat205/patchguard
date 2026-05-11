#!/bin/bash
set -e
ACTION=${1:-upgrade}
REVISION=${2:-head}
case "$ACTION" in
    upgrade|downgrade) alembic "$ACTION" "$REVISION" ;;
    history|current)   alembic "$ACTION" ;;
    *) echo "Usage: $0 [upgrade|downgrade|history|current] [revision]"; exit 1 ;;
esac
