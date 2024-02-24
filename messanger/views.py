import json
from django.shortcuts import render
from django.http import HttpResponse, JsonResponse

# Create your views here.
def hello(request):
    return HttpResponse("Hello, world. You're at the messanger index.")

def request(request):
    if request.method == 'POST':
        try:
            request_json = json.loads(request.body)
            name = employee['name']
            role = employee['role']
            salary = employee['salary']

            response_data = {'status': 'success'}
            return JsonResponse(response_data)
        except json.JSONDecodeError:
            return HttpResponseBadRequest('Invalid Json')
    else:
        return HttpResponseBadRequest('Unsupported Method')
