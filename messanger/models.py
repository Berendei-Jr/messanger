from datetime import datetime

from django.db import models
from django.contrib.auth.models import User


class Chat(models.Model):
    is_group_chat = models.BooleanField()
    chat_name = models.CharField(max_length=100)
    creation_date = models.DateField()

    def __str__(self):
        return self.chat_name


class UserInChat(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    chat = models.ForeignKey(Chat, on_delete=models.CASCADE)
    last_messages_update = models.DateTimeField(default=datetime.now)
    join_date = models.DateTimeField()

    def __str__(self):
        return self.user.username + ' in ' + self.chat.chat_name


class Message(models.Model):
    author = models.ForeignKey(User, on_delete=models.CASCADE)
    target = models.ForeignKey(Chat, on_delete=models.CASCADE)
    is_group_message = models.BooleanField()
    message_text = models.CharField(max_length=255)
    timestamp = models.DateTimeField(default=datetime.now)

    def __str__(self):
        return self.author.username + ' at ' + str(self.timestamp.astimezone().strftime("%d.%m.%Y %H:%M:%S"))


class UserToken(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    token = models.CharField(max_length=100)
    expire_time = models.DateTimeField()

    def __str__(self):
        return self.user.username


class UserSetting(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    setting_name = models.CharField(max_length=100)
    setting_value = models.CharField(max_length=100)

    def __str__(self):
        return self.user.username + ' ' + self.setting_name


class Notification(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    message = models.ForeignKey(Message, on_delete=models.CASCADE)
    timestamp = models.DateTimeField()

    def __str__(self):
        return self.user.username + ' at ' + str(self.timestamp)
