import React, { useEffect, useState } from 'react';
import Head from './Header';
import './main.css';
import {utils} from 'web3';

import {
    loadWeb3,
    loadAccount,
    loadERC721
} from "../helpers/web3Functions";

const LandingPage = () => {
    const [account, setAccount] = useState("")
    const [erc721Contract, setERC721Contract] = useState("")
    const [supply, setSupply] = useState("")
    const [balance, setBalance] = useState("")
    const [ownerMint] = useState("")
    const [publicMint, setPublicMint] = useState("")
    const [mintPrice, setMintPrice] = useState("")
    const [openSales, setOpenSales] = useState("")
    const [closeSales, setCloseSales] = useState("")
    const [withdraw] = useState("")
    const [price, setPrice] = useState("")

    const callGetBalance = async () => {
      const bal = await erc721Contract.methods.getBalance().call();
      setBalance(utils.fromWei(bal));
    }

    const callGetTotalSupply = async () => {
      const sup = await erc721Contract.methods.getTotalSupply().call();
      setSupply(sup);
    }

    const callOwnerMint = async () => {
      await erc721Contract.methods.ownerMint().send({from: account});
    }

    const callPublicMint = async (_value) => {
      _value = utils.toWei(_value);
      const trans = await erc721Contract.methods.publicMint().send({from: account, value: _value});
      setPublicMint(trans);
    }

    const callMintPrice = async (_price) => {
      _price = utils.toWei(_price);
      await erc721Contract.methods.setMintPrice(_price).send({from: account});
    }

    const callGetOpenSales = async (_price) => {
      _price = utils.toWei(_price);
      await erc721Contract.methods.openSales(_price).send({from: account});
    }

    const callGetCloseSales = async (_price) => {
      _price = utils.toWei(_price);
      await erc721Contract.methods.closeSales(_price).send({from: account});
    }

    const callCanWithdraw = async () => {
      await erc721Contract.methods.withdraw().send({from: account});
    }

    const callGetPrice = async () => {
      const price = await erc721Contract.methods.getPrice().call();
      setPrice(utils.fromWei(price));
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
        setERC721Contract(erc721Contract);
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
                  <button className='btnGet' type='button' onClick={callGetTotalSupply} >Submit</button>
                </div>
                <div className="row">
                <div>
                  <p className='title'>Balance:</p> 
                  <div>{balance}</div>
                </div>
                <button className='btnGet' type='button' onClick={callGetBalance} >Submit</button>
              </div>
              <div className="row">
                <div>
                  <p className='title'>Public Mint:</p>
                  <input placeholder="Deposit value" className='inp' onChange={(x) => setPublicMint(x.target.value)}/>
                </div>
                  <button className='btnGet' type="button" onClick={() => callPublicMint(publicMint)}>Submit</button>
              </div>
              <div className="row">
                <div>
                  <p className='title'>Price:</p> 
                  <div>{price}</div>
                </div>
                <button className='btnGet' type='button' onClick={callGetPrice} >Submit</button>
              </div>
              <div className="row">
                <div>
                  <p className='title'>Open sales</p>
                  <input placeholder="Open sales" className='inp' onChange={(x) => setOpenSales(x.target.value)}/>
                </div>
                  <button className='btnGet' type="button" onClick={() => callGetOpenSales(openSales)}>Submit</button>
              </div>
              <div className="row">
                <div>
                  <p className='title'>Close sales</p> 
                  <div>{closeSales}</div>
                </div>
                <button className='btnGet' type='button' onClick={callGetCloseSales} >Submit</button>
              </div>
              <div className="row">
                <div>
                  <p className='title'>New price</p>
                  <input placeholder="New price" className='inp' onChange={(x) => setMintPrice(x.target.value)}/>
                </div>
                  <button className='btnGet' type="button" onClick={() => callMintPrice(mintPrice)}>Submit</button>
              </div>
              <div className="row">
                <div>
                  <p className='title'>Withdraw</p> 
                  <div>{withdraw}</div>
                </div>
                <button className='btnGet' type='button' onClick={callCanWithdraw} >Submit</button>
              </div>
            </div>
          </div>
        </body>
      </div>
    )
}

export default LandingPage;