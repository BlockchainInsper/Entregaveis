from json import dumps
from ellipticcurve.ecdsa import Ecdsa
from ellipticcurve.privateKey import PrivateKey

print("\n-------------------------------------")
print("       Master crypto - ECDSA")

privateKey = None
publicKey = None
message = None
signature = None

finish = False
while(finish == False):
    print("-------------------------------------")
    print("\nOPTIONS \n")
    print("1 - Generate new keys")
    print("2 - Write message")
    print("3 - Sign message")
    print("4 - Verify signature")
    print("5 - Finish")
    print("-------------------------------------\n")
    
    option = int(input("Option:"))
    print(' ')

    if option == 1:
        privateKey = PrivateKey()
        publicKey = privateKey.publicKey()
        
        f_privateKey = open("privateKey.txt", "w")
        f_privateKey.write(privateKey.toString())
        f_privateKey.close()

        f_publicKey = open("publicKey.txt", "w")
        f_publicKey.write(publicKey.toString())
        f_publicKey.close()

        print('Private Key: ' + privateKey.toString())
        print('Public Key: ' + publicKey.toString())
    elif option == 2:
        message = str(input("Message: "))
    
    elif option == 3:
        if message != None:
            print('Select key to sign the message')
            print("1 - private key")
            print("2 - public key")
            selectKey = int(input("\ninput: "))
            if selectKey == 1:
                signature = Ecdsa.sign(message, privateKey)
                print('\nSigned message:')
                print(signature.toBase64())
                f_signature = open("signature.txt", "w")
                f_signature.write(signature.toBase64())
                f_signature.close()
            elif selectKey == 2:
                signature = Ecdsa.sign(message, publicKey)
                print('\nSigned message:')
                print(signature.toBase64())
                f_signature = open("signature.txt", "w")
                f_signature.write(signature.toBase64())
                f_signature.close()
            else:
                print("select key error")
        else:
            print('No message')
    elif option == 4:
        if message != None and signature != None:
            print('Select key to verify the signature')
            print("1 - public key")
            print("2 - private key")
            selectKey = int(input("\ninput: "))
            status = False
            
            try:
                if selectKey == 1:
                    status = Ecdsa.verify(message, signature, publicKey)
                elif selectKey == 2:
                    status = Ecdsa.verify(message, signature, privateKey)
                else:
                    print("select key error")
            except:
                status = False

            print('\nSignature status: ', status)
        else:
            print('No signature or message')
    elif option == 5:   
        finish = True
    else:
        print('Option erro')
        finish = True
