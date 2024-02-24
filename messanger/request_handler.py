import json


class RequestHandler:
    @staticmethod
    def register(request: json):
        username = request['username']
        password_hash = request['password_hash']
        print(username, password_hash)
        return True

    @staticmethod
    def login(request: json):
        username = request['username']
        password_hash = request['password_hash']
        print(username, password_hash)
        return True

    @staticmethod
    def message(request: json):
        username = request['username']
        destination_username = request['destination_username']
        print(username, destination_username)
        return True

    @staticmethod
    def get_messages(request: json):
        username = request['username']
        print(username)
        return json.dumps({'username': username, 'messages': ['Hello', 'World']})
