from django.urls import path
from . import views

urlpatterns = [
    path('api/v1/request/message', views.send_message),
    path('api/v1/request/login', views.login),
    path('api/v1/request/register', views.register),
    path('api/v1/request/get_messages', views.get_messages),
]
