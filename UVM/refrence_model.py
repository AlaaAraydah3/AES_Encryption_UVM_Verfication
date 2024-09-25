

from Crypto.Cipher import AES

with open('data_key.txt', 'r') as file:
    data_hex = file.readline().strip()
    key_hex  = file.readline().strip()  
    
data = bytes.fromhex(data_hex)
key  = bytes.fromhex(key_hex)

cipher = AES.new(key, AES.MODE_ECB)
ciphertext = cipher.encrypt(data)

with open('output.txt', 'w') as file:
    file.write(ciphertext.hex())
