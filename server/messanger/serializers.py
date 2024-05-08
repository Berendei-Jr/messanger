import datetime

from django.contrib.auth.models import User
from rest_framework import serializers
from .models import Message, Chat


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['username', 'password', 'is_superuser']


class MessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Message
        fields = ['author', 'chat', 'is_group_message', 'message_text']


class ChatSerializer(serializers.ModelSerializer):
    class Meta:
        model = Chat
        fields = ['chat_name', 'creation_date']
