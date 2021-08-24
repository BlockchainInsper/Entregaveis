import starkbank
import ecdsa
from hashlib import sha256
import hashlib, secrets

# SECP256k1 é curva elíptica usada no Bitcoin.
# Gerando uma private key para realizar a assinatura digital
# seguindo protocolo ECDSA.
sk = ecdsa.SigningKey.generate(curve=ecdsa.SECP256k1)

# Mensagem que irá ser assinada.
message = b"Entregavel 1 do Matheus Freitas"

# Gerando uma public key para verificar se a assinatura é válida.
vk = sk.get_verifying_key()

# Assinando a mensagem.
sig = sk.sign(message)
print("A assinatura digital é: ", sig)
print("")

# Utilizando a Verifying Key (public key) para validar que a mensagem
# foi realmente assinada com a Signing Key (private key) válida.
print("A mensagem foi realmente assinada com uma privKey? ", vk.verify(sig, message))