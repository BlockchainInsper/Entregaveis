import React, { useEffect, useState } from 'react';
import Head from './Header';
import './main.css';
import {utils} from 'web3';
import {loadWeb3,loadAccount,loadERC721} from "../helpers/web3Functions";

const LandingPage = () => {
    const [account, setAccount] = useState("")
    const [ERC721, setERC721] = useState("")
    const [totalSupply, setTotalSupply] = useState("")
    const [balance, setBalance] = useState("")
    const [mintPrice, setMintPrice] = useState(0)
    const [_value, setValue] = useState(0)
    



    const callGetSupply = async () => {
      const ts = await ERC721.methods.getTotalSupply().call();
      setTotalSupply(ts);
    }

    const callGetBalance= async () => {
      let b = await ERC721.methods.getBalance().call();
      b = utils.fromWei(b);
      setBalance(b);
    }

    const callOwnermMint = async () => {
      await ERC721.methods.ownerMint().send({from: account});
    }
    const callPublicMint = async (Value) => {
      Value = utils.toWei(Value);
      await ERC721.methods.publicMint().send({from: account,value: Value});
    }
    const callSetMintPrice = async (mintPrice) => {
      mintPrice = utils.toWei(mintPrice);
      await ERC721.methods.setMintPrice(mintPrice).send({from: account});
    }
    const callOpenSales = async (mintPrice) => {
      mintPrice = utils.toWei(mintPrice);
      await ERC721.methods.openSales(mintPrice).send({from: account});
    }
    const callCloseSales = async () => {
      await ERC721.methods.closeSales().send({from: account});
    }
    const callWithdraw = async () => {
      await ERC721.methods.withdraw().send({from: account});
    }

 

    const loadBlockchainData = async () => {
        var web3 = await loadWeb3();
        const networkId = await web3.eth.net.getId()
        const acc = await loadAccount(web3);
        const erc721Contract = await loadERC721(web3, networkId);
        if(!erc721Contract) {
          window.alert('Smart contract not detected on the current network. Please select another network with Metamask.')
          return;
        }
        setAccount(acc);
        setERC721(erc721Contract);
      }
    useEffect(() => {
      loadBlockchainData();
      callGetSupply();
      callGetBalance();
    })

    return (
      <div>
        <Head />
        <body className='body'>
          <div className="center">
            <div className="col">
            <div>
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
                      <p className='title'>Total Supply:</p> 
                      <div>{totalSupply}</div>
                    </div>
                  </div>
                  <div className="row">
                    <div>
                      <p className='title'>Balance:</p> 
                      <div>{balance}</div>
                    </div>
                  </div>
                  <div className="row">
                      <div>
                        <p className='title'> Value sent for mint:</p>
                        <input placeholder="in Wei" className='inp' onChange={(x) => setValue(x.target.value)}/>
                      </div>
                      <button className='btn' type="button" onClick={() => callPublicMint(_value)}>public Mint</button>
                  </div>
              </div>
              <div>
                  <div className="row">
                    <div>
                      <p className='title'> Set Mint Price:</p>
                      <input placeholder="in Wei" className='inp' onChange={(e) => setMintPrice(e.target.value)}/>
                    </div>
                      <button className='btn' type="button" onClick={() => callSetMintPrice(mintPrice)}>Submit</button>
                  </div>
                  <div className="row">
                      <button className='btn' type="button" onClick={() => callOwnermMint()}>Owner Mint</button>
                      <button className='btn' type="button" onClick={() => callOpenSales(mintPrice)}>Open Sales</button>
                      <button className='btn' type="button" onClick={() => callCloseSales()}>Close Sales</button>
                      <button className='btn' type="button" onClick={() => callWithdraw()}>Withdraw</button>
                  </div>
                </div>
            </div>
          </div>
        </body>
      </div>
    )
}

export default LandingPage;