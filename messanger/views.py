import json
import time

from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework.decorators import api_view, authentication_classes, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response


@api_view(['POST'])
#@authentication_classes([SessionAuthentication, BasicAuthentication])
#@permission_classes([IsAuthenticated])
def send_message(request, format=None):
    content = {
        'response': 'ok'
    }
    return Response(content)

@api_view(['POST'])
#@authentication_classes([SessionAuthentication, BasicAuthentication])
#@permission_classes([IsAuthenticated])
def login(request, format=None):
    content = {
        'response': 'ok'
    }
    return Response(content)

@api_view(['POST'])
#@authentication_classes([SessionAuthentication, BasicAuthentication])
#@permission_classes([IsAuthenticated])
def register(request, format=None):
    content = {
        'response': 'ok'
    }
    return Response(content)


@api_view(['POST'])
#@authentication_classes([SessionAuthentication, BasicAuthentication])
#@permission_classes([IsAuthenticated])
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
