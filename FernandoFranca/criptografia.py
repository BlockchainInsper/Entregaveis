import starkbank

def generate_keys(directory=None):
    """Function that generate private and public keys using ECDSA algorithm

    Args:
        directory (string): directory to generate the key files

    Returns:
        string: privateKey
        string: publicKey
    """    
    privateKey, publicKey = starkbank.key.create(directory)
    return privateKey, publicKey


privateKey, publicKey = generate_keys()

print(privateKey)
print(publicKey)
