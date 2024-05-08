import time
import json
from datetime import datetime

from django.contrib.auth.models import User
from django.shortcuts import get_object_or_404

from rest_framework import status
from rest_framework.authtoken.models import Token
from rest_framework.authentication import SessionAuthentication, TokenAuthentication
from rest_framework.decorators import api_view, authentication_classes, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from .models import Chat, UserInChat, Message
from .serializers import UserSerializer, MessageSerializer, ChatSerializer


@api_view(['POST'])
@authentication_classes([SessionAuthentication, TokenAuthentication])
@permission_classes([IsAuthenticated])
def send_message(request, format=None):
    processed_data = request.data
    try:
        processed_data['author'] = get_object_or_404(User, id=request.data['author_id']).id
        if processed_data['is_group_message']:
            processed_data['chat'] = get_object_or_404(Chat, id=processed_data['target_id'],
                                                       is_group_chat=True).id
        else:
            processed_data['chat'] = get_object_or_404(Chat, id=processed_data['target_id'], is_group_chat=False).id
        processed_data.update({'timestamp': datetime.now()})
    except KeyError:
        return Response({'detail': 'Invalid format'}, status=status.HTTP_400_BAD_REQUEST)
    serializer = MessageSerializer(data=processed_data)
    if serializer.is_valid():
        serializer.save()
        return Response({}, status=status.HTTP_202_ACCEPTED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def login(request, format=None):
    try:
        request.data['username']
        request.data['password']
    except KeyError:
        return Response({'detail': 'Invalid format'}, status=status.HTTP_400_BAD_REQUEST)
    user = get_object_or_404(User, username=request.data['username'])
    if user.check_password(request.data['password']):
        token, created = Token.objects.get_or_create(user=user)
        return Response({'id': user.id, 'token': token.key}, status=status.HTTP_202_ACCEPTED)
    return Response({'detail': 'Invalid password'}, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def register(request, format=None):
    serializer = UserSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        user = User.objects.get(username=request.data['username'])
        token = Token.objects.create(user=user)
        user.set_password(request.data['password'])
        user.save()
        return Response({'id': user.id, 'token': token.key}, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@authentication_classes([SessionAuthentication, TokenAuthentication])
@permission_classes([IsAuthenticated])
def get_messages(request, format=None):
    json_response = {}
    index = 0
    for user_in_chat in UserInChat.objects.filter(user=request.user):
        chat_target = user_in_chat.chat
        last_update_time = user_in_chat.last_messages_update

        new_messages_query = Message.objects.filter(chat=chat_target, timestamp__gt=last_update_time)

        if not new_messages_query.exists():
            continue

        new_messages = list(new_messages_query.values())
        for message in new_messages:
            if message['author_id'] != request.user.id:
                json_response[index] = message
                index += 1

    if not json_response:
        return Response({}, status=status.HTTP_204_NO_CONTENT)
    UserInChat.objects.filter(user=request.user).update(last_messages_update=datetime.now())
    return Response(json_response, status=status.HTTP_200_OK)


@api_view(['POST'])
@authentication_classes([SessionAuthentication, TokenAuthentication])
@permission_classes([IsAuthenticated])
def get_chats(request, format=None):
    chats_list = list(UserInChat.objects.filter(user=request.user).values())
    if not chats_list:
        return Response({}, status=status.HTTP_204_NO_CONTENT)

    json_response = {index: chat for index, chat in enumerate(chats_list)}
    return Response(json_response, status=status.HTTP_200_OK)


@api_view(['POST'])
@authentication_classes([SessionAuthentication, TokenAuthentication])
@permission_classes([IsAuthenticated])
def create_group_chat(request, format=None):
    if Chat.objects.filter(chat_name=request.data['chat_name'], is_group_chat=True).exists():
        return Response({'detail': 'Chat already exists'}, status=status.HTTP_400_BAD_REQUEST)
    serializer = ChatSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@authentication_classes([SessionAuthentication, TokenAuthentication])
@permission_classes([IsAuthenticated])
def request_user_info(request, format=None):
    user = get_object_or_404(User, id=request.data['id'])
    response = json.loads(json.dumps(UserSerializer(user).data))
    response.pop('password')
    return Response(response, status=status.HTTP_200_OK)


@api_view(['POST'])
@authentication_classes([SessionAuthentication, TokenAuthentication])
@permission_classes([IsAuthenticated])
def request_chat_info(request, format=None):
    try:
        chat = get_object_or_404(Chat, id=request.data['chat_id'], is_group_chat=request.data['is_group'])
        response = dict()
        response['chat_name'] = chat.chat_name
        response['users'] = []
        users = UserInChat.objects.filter(chat=chat).values()
        for user in users:
            response['users'].append({'user_id': user['user_id'], 'username': get_object_or_404(User, id=user['user_id']).username})
        return Response(response, status=status.HTTP_200_OK)
    except KeyError as e:
        return Response({'detail': f'Invalid format {e}'}, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@authentication_classes([SessionAuthentication, TokenAuthentication])
@permission_classes([IsAuthenticated])
def get_users_list(request, format=None):
    users = User.objects.values('id', 'username', 'last_login')
    return Response({index: user for index, user in enumerate(users)}, status=status.HTTP_200_OK)


@api_view(['POST'])
@authentication_classes([SessionAuthentication, TokenAuthentication])
@permission_classes([IsAuthenticated])
def create_chat(request, format=None):
    try:
        target_user_id = request.data['target_user_id']
        user_ids = [request.user.id, target_user_id]
        user_ids.sort()
        new_chat = Chat.objects.get_or_create(chat_name=f'Private messages {user_ids[0]} and {user_ids[1]}',
                                              is_group_chat=False)[0]
        UserInChat.objects.get_or_create(chat=new_chat, user=request.user)
        UserInChat.objects.get_or_create(chat=new_chat, user=get_object_or_404(User, id=target_user_id))

        return Response({'chat_id': new_chat.id}, status=status.HTTP_201_CREATED)
    except KeyError as e:
        return Response({'detail': f'Invalid format {e}'}, status=status.HTTP_400_BAD_REQUEST)
