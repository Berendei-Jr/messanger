import json


a = {
    'username': 'test_username_1',
    'message': ['Hello World 1']
}

b = {
    'username': 'test_username_2',
    'message': ['Hello World 2']
}
mes1 = {0: a}
mes2 = {1: b}
mes1.update(mes2)

asString = json.dumps(mes1)
print(asString)
