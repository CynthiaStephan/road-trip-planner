#!/bin/bash
set -e

echo "🔄 Post-start script started..."

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Wait for database to be ready
echo -e "${YELLOW}Waiting for database to be ready...${NC}"
sleep 5

# Run database migrations if needed
if [ -f "/workspace/server/alembic/env.py" ]; then
    echo -e "${YELLOW}Running database migrations...${NC}"
    cd /workspace/server
    alembic upgrade head || echo "No migrations found"
fi

echo -e "${GREEN}✅ Post-start complete!${NC}"
echo ""
echo "📦 Services available:"
echo "   Frontend:  http://localhost:5173"
echo "   Backend:   http://localhost:8000"
echo "   API Docs:  http://localhost:8000/docs"
echo "   Database:  localhost:5432"
echo "   Debugger:  localhost:5678"
echo ""