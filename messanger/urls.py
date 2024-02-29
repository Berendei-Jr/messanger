from django.urls import path
from . import views

urlpatterns = [
    path('message', views.send_message),
    path('login', views.login),
    path('register', views.register),
    path('get_messages', views.get_messages),
]

''''{
    "author": "aboba",
    "target": "chat1",
    "message_text": "Hello World",
    "is_group_message": false
}'''
