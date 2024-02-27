from django.urls import path
from . import views

urlpatterns = [
    path('', views.example_view),
    path('api/v1/request', views.hello),
]
