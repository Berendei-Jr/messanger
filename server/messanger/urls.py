from django.urls import path
from . import views

urlpatterns = [
    path('message', views.send_message),
    path('login', views.login),
    path('register', views.register),
    path('get_messages', views.get_messages),
    path('get_chats', views.get_chats),
    path('request_user_info', views.request_user_info),
    path('request_chat_info', views.request_chat_info),
    path('get_users_list', views.get_users_list),
    path('create_chat', views.create_chat),
]
