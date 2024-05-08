from django.contrib import admin
from .models import Chat, UserInChat, Message, UserToken, UserSetting, Notification, UserDevice

admin.site.register(Chat)
admin.site.register(UserInChat)
admin.site.register(Message)
admin.site.register(UserToken)
admin.site.register(UserSetting)
admin.site.register(Notification)
admin.site.register(UserDevice)
