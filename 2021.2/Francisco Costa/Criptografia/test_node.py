from node import Node
import unittest

class TestNode(unittest.TestCase):

    def setUp(self):
        self.A = Node("Fernando")
        self.B = Node("Paulo")
        self.C = Node("Matheus")
        self.D = Node("Lucas Lima")

    def test_encryption_decryption(self):
        
        encrypted_message = self.B.encrypt("lightning", self.A)
        decrypted_message = self.A.decrypt(encrypted_message)

        self.assertEqual(decrypted_message, "lightning", "Falha no teste 1")

    def test_encrypted_not_connected_one(self):
        
        self.B.pass_message("BI", self.A)

        decrypted_message = self.A.decrypt(self.A.messages[0])

        self.assertEqual(decrypted_message, "BI", "Falha no teste 2")

    def test_encrypted_not_connected_two(self):

        self.A.create_channel(self.C)
        self.B.create_channel(self.C)

        self.B.pass_message("BI", self.A)
        self.B.pass_message("Insper", self.A)

        decrypted_messages = self.A.decrypt_all_messages()
        
        self.assertEqual(decrypted_messages, ["BI", "Insper"], "Falha no teste 3")
    
    def test_encrypted_not_connected_connections(self):

        self.A.create_channel(self.C)
        self.B.pass_message("BI", self.A)
        self.B.pass_message("Insper", self.A)
        
        self.assertEqual(self.A.connections, [self.C, self.B], "Falha no teste 4")
    
    def test_encrypted_connected(self):

        self.A.create_channel(self.B)
        self.A.pass_message("Insper", self.B)

        decrypted_message = self.B.decrypt_all_messages()[0]

        self.assertEqual(decrypted_message, "Insper", "Falha no teste 5")

    def test_encryption_bridge_network(self):

        self.A.create_channel(self.D)
        self.A.create_channel(self.B)
        self.B.create_channel(self.D)
        self.B.create_channel(self.C)
        self.A.pass_message("blockchain", self.C)

        decrypt_message = self.C.decrypt_all_messages()[0]

        self.assertEqual(decrypt_message, "blockchain", "Falha no teste 7")

    def test_encryption_bridge_network_messages(self):

        message1 = "blockchain"

        self.A.create_channel(self.D)
        self.A.create_channel(self.B)
        self.B.create_channel(self.D)
        self.B.create_channel(self.C)

        self.A.pass_message(message1, self.C)

        message2 = "blockchain_Insper"

        self.A.create_channel(self.B)
        self.B.create_channel(self.C)

        self.A.pass_message(message2, self.C)

        self.assertEqual(self.A.messages == self.B.messages == self.C.messages, True, "Falha no teste 7")
        self.assertEqual(self.D.messages, [], "Falha no teste 7")

if __name__ == '__main__':
    unittest.main()