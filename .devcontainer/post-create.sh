#!/usr/bin/env bash
set -e

echo "🔧 Setting up SSH..."
chmod 700 ~/.ssh || true
chmod 600 ~/.ssh/id_rsa 2>/dev/null || true

echo "📦 Installing frontend deps..."
if [ -d "/workspace/client" ]; then
  cd /workspace/client
  npm install
fi

echo "🐍 Setting up Python env..."
if [ -d "/workspace/server" ]; then
  cd /workspace/server

  python -m venv .venv
  source .venv/bin/activate

  pip install --upgrade pip
  pip install -r requirements.txt
fi

echo "✅ Devcontainer ready"