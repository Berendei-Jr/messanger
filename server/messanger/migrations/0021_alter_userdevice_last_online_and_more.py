# Generated by Django 5.0.4 on 2024-05-02 00:27

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('messanger', '0020_alter_userinchat_last_messages_update_userdevice'),
    ]

    operations = [
        migrations.AlterField(
            model_name='userdevice',
            name='last_online',
            field=models.DateTimeField(verbose_name=datetime.datetime(2024, 5, 2, 0, 27, 29, 374655)),
        ),
        migrations.AlterField(
            model_name='userinchat',
            name='last_messages_update',
            field=models.DateTimeField(verbose_name=datetime.datetime(2024, 5, 2, 0, 27, 29, 373531)),
        ),
    ]
