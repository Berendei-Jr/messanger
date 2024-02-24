import requests

# api-endpoint
URL = "http://127.0.0.1:8000/messanger/hello"

# sending get request and saving the response as response object
r = requests.get(url = URL)
 
# extracting data in json format
#data = r.json()

print(r.content)
