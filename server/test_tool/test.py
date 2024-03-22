import requests

url = 'http://127.0.0.1:8000/api/v1/message'
url_reg = 'http://127.0.0.1:8000/api/v1/register'

headers = {'Authorization': 'Token fe23efe82be7a554d6ff4be55f3bfc5be414fcba'}
payload = {
    "target": "aboba2",
    "message_text": "Hello World",
    "is_group_message": False
}

payload_reg = {
    "username": "aboba",
}

response = requests.post(url, json=payload, headers=headers)

print(response.text)
print(response.status_code)
