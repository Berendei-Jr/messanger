# Generated by Django 5.0.2 on 2024-03-01 11:12

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('messanger', '0006_alter_userinchat_last_messages_update'),
    ]

    operations = [
        migrations.AlterField(
            model_name='userinchat',
            name='last_messages_update',
            field=models.DateTimeField(default=datetime.datetime.now),
        ),
    ]
