from django.db import models


# Create your models here.
class User(models.Model):
    username = models.CharField(max_length=100)
    pass_hash = models.CharField(max_length=100)
    last_online = models.DateField()
    birthday = models.DateField()
    is_vip = models.BooleanField()
    registration_date = models.DateField()
    last_messages_update = models.DateField()


class Chat(models.Model):
    is_group_chat = models.BooleanField()
    chat_name = models.CharField(max_length=100)
    creation_date = models.DateField()
    last_messages_update = models.DateField()


class UserInChat(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    chat = models.ForeignKey(Chat, on_delete=models.CASCADE)
    join_date = models.DateField()


class Message(models.Model):
    author = models.ForeignKey(User, on_delete=models.CASCADE)
    target = models.ForeignKey(Chat, on_delete=models.CASCADE)
    is_group_message = models.BooleanField()
    message_text = models.CharField(max_length=255)
    timestamp = models.DateField()


class UserToken(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    token = models.CharField(max_length=100)
    expire_time = models.DateField()


class UserSettings(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    theme = models.CharField(max_length=100)
    font_size = models.IntegerField()
    background_color = models.CharField(max_length=100)


class Notification(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    message = models.ForeignKey(Message, on_delete=models.CASCADE)
    timestamp = models.DateField()
