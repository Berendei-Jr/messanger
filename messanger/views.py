import time

from django.contrib.auth.models import User
from django.shortcuts import get_object_or_404

from rest_framework import status
from rest_framework.authtoken.models import Token
from rest_framework.authentication import SessionAuthentication, TokenAuthentication
from rest_framework.decorators import api_view, authentication_classes, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from .models import Chat, UserInChat, Message
from .serializers import UserSerializer, MessageSerializer


@api_view(['POST'])
@authentication_classes([SessionAuthentication, TokenAuthentication])
@permission_classes([IsAuthenticated])
def send_message(request, format=None):
    processed_data = request.data
    try:
        processed_data['author'] = get_object_or_404(User, username=processed_data['author']).id
        processed_data['target'] = get_object_or_404(Chat, chat_name=processed_data['target']).id
        processed_data.update({'timestamp': time.strftime("%H:%M:%S", time.localtime())})
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
        return Response({'token': token.key}, status=status.HTTP_202_ACCEPTED)
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
        return Response({'token': token.key}, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@authentication_classes([SessionAuthentication, TokenAuthentication])
@permission_classes([IsAuthenticated])
def get_messages(request, format=None):
    dummy_message_1 = {
        'username': 'test_username_1',
        'message': ['Hello World 1'],
        'timestamp': time.strftime("%H:%M:%S", time.localtime())
    }
    dummy_message_2 = {
        'username': 'test_username_2',
        'message': ['Hello World 2'],
        'timestamp': time.strftime("%H:%M:%S", time.localtime())
    }
    mes1 = {0: dummy_message_1}
    mes2 = {1: dummy_message_2}
    mes1.update(mes2)

    return Response(mes1)
