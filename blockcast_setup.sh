#!/bin/bash

# Exit on any error
set -e

REPO_URL="https://github.com/Blockcast/beacon-docker-compose.git"
REPO_DIR="beacon-docker-compose"

echo "[+] Cloning Blockcast repo..."
git clone "$REPO_URL" && cd "$REPO_DIR"

echo "[+] Starting Blockcast node using Docker Compose..."
docker compose up -d

echo "[+] Waiting 10 seconds for services to initialize..."
sleep 10

echo "[+] Generating node keys (Hardware ID & Challenge Key)..."
docker compose exec blockcastd blockcastd init

echo -e "\n[!] Copy the above Hardware ID and Challenge Key"
echo "    Then open the Register URL or login to Blockcast dashboard manually."
echo "    Dashboard: https://dashboard.blockcast.network/ (or use the Register URL above)"
echo

echo "[+] Detecting your node location (city, region, country, coordinates):"
curl -s https://ipinfo.io | jq '.city, .region, .country, .loc'
