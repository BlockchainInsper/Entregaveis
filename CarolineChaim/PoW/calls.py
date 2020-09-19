import requests
import json
#from block import Block
import asyncio

def get_difficulty():
    url = "http://entregapow.blockchainsper.com:8880/blocks/difficulty"

    payload = {}
    headers = {}

    response = requests.request("GET", url, headers=headers, data = payload)
    response = json.loads(response.text)
    return response["data"]["zeros"]


def post_block(payloadd):
    url = "http://entregapow.blockchainsper.com:8880/blocks/mine"

    payload = payloadd
    headers = {
    'Content-Type': 'application/json'
    }
    return requests.request("POST", url, headers=headers, data = payload)