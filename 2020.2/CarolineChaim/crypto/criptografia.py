from json import dumps
from ellipticcurve.ecdsa import Ecdsa
from ellipticcurve.privateKey import PrivateKey


# Criação do private key

privateKey =  PrivateKey()

# Criação do public key a partir do private key 

publicKey = privateKey.publicKey()

# pega o arquivo da mensagem a ser decriptada
mensagem = "mensagem.txt"


#Encriptação da mensagem 
signature = Ecdsa.sign(mensagem, privateKey)

# mensagem encriptada em base 64
signature_base  = (signature.toBase64())

# Generate mensagem encriptada em txt
mensagem_encriptada = "mensagem_encriptada.txt"

file = open(mensagem_encriptada,'w')
file.write(signature_base)
file.close()



# verificacao que a mensagem nao foi alterada usando a public key:

print("------------------------------------------------------------------------------")
print("Verificação de que a mensagem decripatada usando a public key não foi alterada")
print (Ecdsa.verify(mensagem, signature, publicKey))
print("------------------------------------------------------------------------------")

