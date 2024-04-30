import requests

# Set your GitHub Enterprise Cloud API endpoint
api_url = 'https://api.github.com'

# Set your personal access token (replace with your actual token)
access_token = 'YOUR_PERSONAL_ACCESS_TOKEN'

# IP address and description to add to the IP Allow list
ip_address = '192.168.1.0/24'
description = 'Office network IP range'

# Construct the API request
url = f'{api_url}/enterprise/settings/ip_allow_list'
headers = {
    'Authorization': f'Bearer {access_token}',
    'Content-Type': 'application/json'
}
data = {
    'ip': ip_address,
    'description': description
}

# Make the API call to add the IP address
response = requests.post(url, json=data, headers=headers)

# Check the response status
if response.status_code == 201:
    print(f'Successfully added IP address {ip_address} with description: {description}')
else:
    print(f'Error adding IP address: {response.status_code} - {response.text}')
