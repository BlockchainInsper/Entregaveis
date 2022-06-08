import React, { useEffect, useState } from 'react';
import Head from './Header';
import './main.css';

import {
    loadWeb3,
    loadAccount,
    loadERC721Capped
} from "../helpers/web3Functions";

import {utils} from 'web3';

const LandingPage = () => {

    const [account, setAccount] = useState("")
    const [supply, setSupply] = useState("")
    const [balance, setBalance] = useState("")
    const [erc721Contract, setContrato] = useState("")
    const [ownerMint] = useState("")
    const [publicMint, setPublicMint] = useState("")
    const [price, setPrice] = useState("")
    const [openSales, setSalesOpen] = useState("")
    const [salesClose, setSalesClose] = useState("")
    const [priceMint, setPriceMint] = useState("")
    const [withdraw] = useState("")


    const callGetBalance = async () => {
      const balance = await erc721Contract.methods.getBalance().call();
      setBalance(utils.fromWei(balance));
    }

    const callGetTotalSupply = async () => {
      const supply = await erc721Contract.methods.getTotalSupply().call();
      setSupply(supply);
    }
    
    const callOwnerMint = async () => {
      await erc721Contract.methods.ownerMint().send({from: account});
    }

    const callPublicMint = async (_value) => {
      _value = utils.toWei(_value);
      const c = await erc721Contract.methods.publicMint().send({from: account, value: _value});
      setPublicMint(c);
    }

    const callMintPrice = async (_price) => {
      _price = utils.toWei(_price);
      await erc721Contract.methods.setPriceMint(_price).send({from: account});
    }

    const callGetPrice = async () => {
      const t = await erc721Contract.methods.getPrice().call();
      setPrice(utils.fromWei(t));
    }

    const callGetOpenSales = async (_price) => {
      _price = utils.toWei(_price);
      await erc721Contract.methods.openSales(_price).send({from: account});
    }

    const callGetClosedSales = async (_price) => {
      _price = utils.toWei(_price);
      await erc721Contract.methods.closeSales(_price).send({from: account});
    }

    const callCanWithdraw = async () => {
      await erc721Contract.methods.withdraw().send({from: account});
    }  

    const loadBlockchainData = async () => {
        var web3 = await loadWeb3();
        const networkId = await web3.eth.net.getId()
        const acc = await loadAccount(web3);
        const erc721Contract = await loadERC721Capped(web3, networkId);
        if(!erc721Contract) {
          window.alert('Smart contract not detected on the current network. Please select another network with Metamask.')
          return;
        }
        setAccount(acc);
        setContrato(erc721Contract);
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
                  <p className='title'>Supply:</p> 
                  <div>{supply}</div>
                </div>
                <button className='btnSupply' type='button' onClick={callGetTotalSupply} >Submit</button>
              </div>
              <div className="row">
                <div>
                  <p className='title'>Balance:</p> 
                  <div>{balance}</div>
                </div>
                <button className='btnBalance' type='button' onClick={callGetBalance} >Submit</button>
              </div>
              <div className="row">
                <div>
                  <p className='title'> Public Mint:</p>
                  <input placeholder="Deposit value" className='inp' onChange={(x) => setPublicMint(x.target.value)}/>
                </div>
                  <button className='btnPublicMint' type="button" onClick={() => callPublicMint(publicMint)}>Submit</button>
              </div>
              <div className="row">
                <div>
                  <p className='title'>Price:</p> 
                  <div>{price}</div>
                </div>
                <button className='btnGetPrice' type='button' onClick={callGetPrice} >Submit</button>
              </div>
              <div className="row">
                <div>
                  <p className='title'> Open sales:</p>
                  <input placeholder="Open sales" className='inp' onChange={(x) => setSalesOpen(x.target.value)}/>
                </div>
                  <button className='btnOpenSales' type="button" onClick={() => callGetOpenSales(openSales)}>Submit</button>
              </div>
              <div className="row">
                <div>
                  <p className='title'>Close sales</p> 
                  <div>{salesClose}</div>
                </div>
                <button className='btnGetPrice' type='button' onClick={callGetClosedSales} >Submit</button>
              </div>
              <div className="row">
                <div>
                  <p className='title'> Change price</p>
                  <input placeholder="New price" className='inp' onChange={(x) => setPriceMint(x.target.value)}/>
                </div>
                  <button className='btnPrice' type="button" onClick={() => callMintPrice(priceMint)}>Submit</button>
              </div>
              <div className="row">
                <div>
                  <p className='title'>Withdraw</p> 
                  <div>{withdraw}</div>
                </div>
                <button className='btnWithdraw' type='button' onClick={callCanWithdraw} >Submit</button>
              </div>
            </div>
          </div>
        </body>
      </div>
    )
}

export default LandingPage;