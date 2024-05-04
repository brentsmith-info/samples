#!/bin/bash

# GHEC API Endpoint
API_URL="https://api.github.com"
# Path to the file containing IP addresses (one IP per line)
IP_FILE="ip_addresses.txt"

# Check if the GITHUB_TOKEN environment variable is set
if [ -z "$GITHUB_TOKEN" ]; then
  echo "Error: GITHUB_TOKEN environment variable is not set."
  exit 1
fi

# Check if the IP address file exists and is readable
if [ ! -f "$IP_FILE" ] || [ ! -r "$IP_FILE" ]; then
  echo "Error: IP address file '$IP_FILE' does not exist or cannot be read."
  exit 1
fi

# Read IP addresses from the file and add them to the IP Allow list
while read -r ip_address; do
  # Check if the IP address already exists
  existing_entry=$(curl -s -X GET "$API_URL/enterprise/settings/ip_allow_list" \
    -H "Authorization: Bearer $GITHUB_TOKEN" | grep -F "\"ip\": \"$ip_address\"")

  if [ -z "$existing_entry" ]; then
    # IP address does not exist, add it
    URL="$API_URL/enterprise/settings/ip_allow_list"
    HEADERS=(
      "-H" "Authorization: Bearer $GITHUB_TOKEN"
      "-H" "Content-Type: application/json"
    )
    DATA="{ \"ip\": \"$ip_address\", \"description\": \"Office network IP range\" }"

    # Make the API call to add the IP address
    curl -X POST "$URL" "${HEADERS[@]}" -d "$DATA"
    echo "Added IP address: $ip_address"
  else
    echo "IP address already exists: $ip_address"
  fi
done < "$IP_FILE"
