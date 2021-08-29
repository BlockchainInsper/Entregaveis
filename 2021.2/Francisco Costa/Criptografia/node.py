from typing import List
import rsa
from rsa.pkcs1 import decrypt, encrypt


class Node:
    def __init__(self, name: str):
        self.name = name
        self.connections = []
        self.messages = []
        self.public_key , self.private_key = rsa.newkeys(512)

    def create_connection(self, node: 'Node') -> None:
        self.connections.append(node)
    
    def create_channel(self, node: 'Node') -> None:
        self.create_connection(node)
        node.create_connection(self)

    def store_message(self, message: str) -> None:
        self.messages.append(message)
    
    def encrypt(self, message: str, node: 'Node') -> str:
        return rsa.encrypt(message.encode(), node.public_key)

    def decrypt(self, encrypted_message: str) -> str:
        return rsa.decrypt(encrypted_message, self.private_key).decode()

    def decrypt_all_messages(self) -> List[str]:
        all_decrypted_messages = []
        for message in self.messages:
            all_decrypted_messages.append(self.decrypt(message))

        return all_decrypted_messages
    
    def pass_message(self, message: str, node: 'Node') -> None:
        encMessage = self.encrypt(message, node)
        self.store_message(encMessage)
        
        if node in self.connections:
            node.store_message(encMessage)
            return

        if node not in self.connections:
            connected_node = None
            for con in self.connections:
                if node in con.connections:
                    node.store_message(encMessage)
                    con.store_message(encMessage)
                    return

        self.create_channel(node)
        node.store_message(encMessage)
        return




        

