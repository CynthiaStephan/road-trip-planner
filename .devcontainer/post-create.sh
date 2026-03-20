#!/bin/bash
set -e

echo "🚀 Post-create script started..."

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Create .env file if it doesn't exist
if [ ! -f "/workspace/.env" ]; then
    echo -e "${YELLOW}Creating .env file from template...${NC}"
    cat > /workspace/.env << EOF
# Database
DATABASE_USER=postgres
DATABASE_PASSWORD=postgres
DATABASE_NAME=roadtrip
DATABASE_PORT=5432

# Environment
ENVIRONMENT=development
EOF
    echo -e "${GREEN}✓ .env file created${NC}"
fi

# Install dependencies for client
echo -e "${YELLOW}Installing client dependencies...${NC}"
cd /workspace/client
npm install
echo -e "${GREEN}✓ Client dependencies installed${NC}"

# Install dependencies for server
echo -e "${YELLOW}Installing server dependencies...${NC}"
cd /workspace/server
pip install --no-cache-dir -r requirements.txt
echo -e "${GREEN}✓ Server dependencies installed${NC}"

echo -e "${GREEN}✅ Post-create setup complete!${NC}"