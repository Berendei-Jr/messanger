import requests

url = 'http://192.168.1.73:8000/api/v1/get_messages'
url_reg = 'http://127.0.0.1:8000/api/v1/register'

headers = {'Authorization': 'Token 2d55778c072dff49782445f16dfa7ce548c0d4e7'}
payload = {
    "author": "andrey",
    "target": "hellcat",
    "message_text": "Hello World",
    "is_group_message": False
}

payload_reg = {
    "username": "aboba",
}

response = requests.post(url, json={}, headers=headers)

print(response.text)
print(response.status_code)
