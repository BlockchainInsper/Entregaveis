import React, { useEffect, useState } from 'react';
import Head from './Header';
import './main.css';

import {
    loadWeb3,
    loadAccount,
    loadCoin
} from "../helpers/web3Functions";

const LandingPage = () => {
    const [account, setAccount] = useState("")
    const [coin, setCoin] = useState("")
    const [newToken, setNewToken] = useState("")

    const callSetToken = async (nome,simbolo,qntd) => {
     await coin.methods.constructor("teste","TXT",account,100000).send({from: account});
    }

    const loadBlockchainData = async () => {
        var web3 = await loadWeb3();
        const networkId = await web3.eth.net.getId()
        const acc = await loadAccount(web3);
        const coinContract = await loadCoin(web3, networkId);
        if(!coinContract) {
          window.alert('Smart contract not detected on the current network. Please select another network with Metamask.')
          return;
        }
        setAccount(acc);
        setCoin(coinContract);
      }
    useEffect(() => {
      loadBlockchainData();
    },[])

    return (
      <div>
        <Head />
        <body className='body'>
          <div className="center">
            <div className="col">
              <div className="row">
                <div>
                  <p className='title'>account:</p>
                  <div>{account &&
                    `${account.slice(0, 6)}...${account.slice(
                      account.length - 4,
                      account.length
                    )}`}
                </div>
                </div>
              </div>
                <div className="row">
                  <div>
                  </div>
                </div>
                <div className="col">
                  <div className="row">
                    <div>
                      <p className='title'> Novo nome:</p>
                      <input placeholder="Nova nome" className='inp' onChange={(nome) => setNewToken(nome.target.value)}/>
                    </div>
                  </div>
                  <div className="row">
                    <div>
                      <p className='title'> Novo simbolo:</p>
                      <input placeholder="Nova simbolo" className='inp' onChange={(simbolo) => setNewToken(simbolo.target.value)}/>
                    </div>
                  </div>
                  <div className="row">
                    <div>
                      <p className='title'> Qntd inicial:</p>
                      <input placeholder="Qntd inicial" className='inp' onChange={(qntd) => setNewToken(qntd.target.value)}/>
                    </div>
                      <button className='btn' type="button" onClick={() => callSetToken(newToken)}>Submit</button>
                  </div>
                </div>
            </div>
          </div>
        </body>
      </div>
    )
}

export default LandingPage;