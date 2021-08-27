from typing import List
import rsa

class Node:
    def __init__(self, name: str):
        self.name = name
        self.connections = []
        self.messages = []
        self.public_key, self.private_key = rsa.newkeys(512)

    def create_connection(self, node: 'Node') -> None:
        self.connections.append(node)
    
    def create_channel(self, node: 'Node') -> None:
        self.create_connection(node)
        node.create_connection(self)

    def store_message(self, message: str) -> None:
        self.messages.append(message)
    
    def encrypt(self, message: str, node: 'Node') -> str:
        encryptedMessage = rsa.encrypt(message.encode('utf8'), node.public_key)
        return encryptedMessage

    def decrypt(self, encrypted_message: str) -> str:
        decryptedMessage = rsa.decrypt(encrypted_message, self.private_key).decode('utf8')
        return decryptedMessage

    def decrypt_all_messages(self) -> List[str]:
        allMessages = []
        for lenght in range(len(self.messages)):
            allMessages.append(self.decrypt(self.messages[lenght]))
        return allMessages    
    
    def pass_message(self, message: str, node: 'Node') -> None:
        encryptedMessage = self.encrypt(message, node)
        self.store_message(encryptedMessage)

        if node not in self.connections:
            for existingNode in self.connections:
                if node in existingNode.connections:
                    existingNode.store_message(encryptedMessage)
                    node.store_message(encryptedMessage)
                    return 
    
            self.create_channel(node)
    
        node.store_message(encryptedMessage)
    
