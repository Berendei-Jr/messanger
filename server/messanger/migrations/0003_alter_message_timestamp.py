# Generated by Django 5.0.2 on 2024-02-29 18:47

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('messanger', '0002_alter_message_author_alter_usertoken_user_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='message',
            name='timestamp',
            field=models.DateTimeField(auto_now=True),
        ),
    ]
