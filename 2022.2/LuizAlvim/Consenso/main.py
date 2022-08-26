import requests
from Crypto.Hash import SHA256
import time



class BitcoinMiner:
    def __init__(self, txs: list):
        """Bitcoin Miner simulation for Blockchain Insper"""
        self.base_url = "https://blockchainsper.herokuapp.com"
        self.txs = txs
        self.const_txs = txs
        self.hash_list = []
        self.merkle_root = None
        
    def _get_info(self):
        """Gets previous block information"""
        return requests.get(self.base_url+"/info").json()
    
    def _post_block(self, data):
        """Posts a block to the blockchain heroku app"""
        return requests.post(self.base_url + "/mine", json=data)

    def _double_sha(self, tx):
        """Returns the double hashed value of an input"""
        return SHA256.new(SHA256.new(tx.encode()).hexdigest().encode()).hexdigest()
    
    def _calculate_root(self):
        """Calculates the merkle root from a list of transactions"""
        if len(self.txs) % 2 != 0:
            self.txs.append(self.txs[-1])
        
        self.hash_list = sorted([self._double_sha(tx) for tx in self.txs])
        
        while len(self.hash_list) > 1:
            new_list = []
            for h0, h1 in zip(self.hash_list[::2], self.hash_list[1::2]):
                new_list.append(self._double_sha(h0 + h1))
            self.hash_list = sorted(new_list)

        return self.hash_list[0]
    
    def _find_nonce(self):
        """Finds the nonce using the difficulty value provided"""
        nonce = 0 
        difficulty_zeroes = "0"*self.info['difficulty']
        while True:
            header_string = f"{self.info['height']}{self.info['last_hash']}{self.merkle_root}{self.time}{self.info['difficulty']}{nonce}"
            sha_header = self._double_sha(header_string)
            if sha_header[0:self.info['difficulty']] == difficulty_zeroes:
                self.nonce = nonce
                return
            else:
                nonce += 1



    def build_block(self):
        """Builds the block with class BitcoinMiner information"""
        self.info = self._get_info()
        self.merkle_root = self._calculate_root()
        self.time = time.time()
        self._find_nonce()
        data = {
            "height": self.info['height'],
            "previous_hash": self.info['last_hash'],
            "merkle_root": self.merkle_root,
            "timestamp": self.time,
            "difficulty": self.info['difficulty'],
            "nonce": self.nonce,
            "tx": self.const_txs,
        }
        r = self._post_block(data)
        print(r.content)


def main():
    transactions = ["Blockchain", "Insper"]
    btc = BitcoinMiner(transactions)
    btc.build_block()

if __name__ == '__main__':
    main()
