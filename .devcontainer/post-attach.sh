#!/bin/bash

echo "📎 Post-attach script - containers are running!"

# Show running containers
echo ""
echo "Running containers:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo ""
echo "💡 Useful commands:"
echo "   docker logs client    - View client logs"
echo "   docker logs server    - View server logs"
echo "   docker logs db        - View database logs"
echo "   docker compose down   - Stop all containers"
echo "   docker compose up -d  - Start all containers"