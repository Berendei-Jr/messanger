# Generated by Django 5.0.4 on 2024-04-24 00:35

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('messanger', '0017_alter_message_timestamp_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='userinchat',
            name='last_messages_update',
            field=models.DateTimeField(default=datetime.datetime(2024, 4, 24, 0, 35, 28, 689918)),
        ),
    ]
