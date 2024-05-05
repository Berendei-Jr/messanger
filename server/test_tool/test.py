import requests

url = 'http://192.168.1.73:8000/api/v1/get_messages'
url_reg = 'http://192.168.1.73:8000/api/v1/get_users_list'

headers = {'Authorization': 'Token 2327c1ec5059acd3dece14e3b7e02c416211227b'}
payload = {
    "author": "andrey",
    "target": "hellcat",
    "message_text": "Hello World",
    "is_group_message": False
}

payload_reg = {
    "chat_id": 16,
    "is_group": False,
}

response = requests.post(url_reg, json={}, headers=headers)

print(response.text)
print(response.status_code)

#print(datetime.datetime.now())

