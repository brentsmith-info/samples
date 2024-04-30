#!/bin/bash

# Set your GitHub Enterprise Cloud API endpoint
API_URL="https://api.github.com"

# Set your personal access token (replace with your actual token)
ACCESS_TOKEN="YOUR_PERSONAL_ACCESS_TOKEN"

# IP address and description to add to the IP Allow list
IP_ADDRESS="192.168.1.0/24"
DESCRIPTION="Office network IP range"

# Construct the API request
URL="$API_URL/enterprise/settings/ip_allow_list"
HEADERS=(
  "-H" "Authorization: Bearer $ACCESS_TOKEN"
  "-H" "Content-Type: application/json"
)
DATA="{ \"ip\": \"$IP_ADDRESS\", \"description\": \"$DESCRIPTION\" }"

# Make the API call to add the IP address
curl -X POST "$URL" "${HEADERS[@]}" -d "$DATA"
