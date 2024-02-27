# Generated by Django 5.0.2 on 2024-02-26 08:12

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Chat',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('is_group_chat', models.BooleanField()),
                ('chat_name', models.CharField(max_length=100)),
                ('creation_date', models.DateField()),
                ('last_messages_update', models.DateField()),
            ],
        ),
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('username', models.CharField(max_length=100)),
                ('pass_hash', models.CharField(max_length=100)),
                ('last_online', models.DateField()),
                ('birthday', models.DateField()),
                ('is_vip', models.BooleanField()),
                ('registration_date', models.DateField()),
                ('last_messages_update', models.DateField()),
            ],
        ),
        migrations.CreateModel(
            name='Message',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('is_group_message', models.BooleanField()),
                ('message_text', models.CharField(max_length=255)),
                ('timestamp', models.DateField()),
                ('target', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='messanger.chat')),
                ('author', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='messanger.user')),
            ],
        ),
        migrations.CreateModel(
            name='Notification',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('timestamp', models.DateField()),
                ('message', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='messanger.message')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='messanger.user')),
            ],
        ),
        migrations.CreateModel(
            name='UserInChat',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('join_date', models.DateField()),
                ('chat', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='messanger.chat')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='messanger.user')),
            ],
        ),
        migrations.CreateModel(
            name='UserSettings',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('theme', models.CharField(max_length=100)),
                ('font_size', models.IntegerField()),
                ('background_color', models.CharField(max_length=100)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='messanger.user')),
            ],
        ),
        migrations.CreateModel(
            name='UserToken',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('token', models.CharField(max_length=100)),
                ('expire_time', models.DateField()),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='messanger.user')),
            ],
        ),
    ]
