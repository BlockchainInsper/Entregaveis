import React, { useEffect, useState } from 'react';
import Head from './Header';
import './main.css';
import Capped from '../abis/ERC721Capped.json'
import { utils } from 'web3';
import {
    loadWeb3,
    loadAccount,
    loadCapped
} from "../helpers/web3Functions";

const LandingPage = () => {
    const [account, setAccount] = useState("");
    const [capped, setCapped] = useState("");
    const [balance, setBalance] = useState(0);
    const [mintPrice, setMintPrice] = useState(0);
    const [totalSupply, setTotalSupply] = useState(0);

    const callGetBalance = async () => {
      const b = await capped.methods.getBalance().call();
      setBalance(utils.fromWei(b));
    }

    const callTotalSupply = async () => {
      const ts = await capped.methods.getTotalSupply().call();
      setTotalSupply(ts);
    }

    const callOwnerMint = async () => {
      await capped.methods.ownerMint().send({from: account});
    }

    const callPublicMint = async (_mintPrice) => {
      _mintPrice = utils.toWei(_mintPrice);
      await capped.methods.publicMint().send({from: account, value: _mintPrice});
    }

    const callSetMintPrice = async (_mintPrice) => {
      await capped.methods.setMintPrice(_mintPrice).send({from: account});
    }

    const callOpenSales = async (_mintPrice) => {
      await capped.methods.openSales(_mintPrice).send({from: account});
    }
    const callCloseSales = async () => {
      await capped.methods.closeSales().send({from: account});
    }
    const callWithdraw = async () => {
      await capped.methods.withdraw().send({from: account});
    }


    const loadBlockchainData = async () => {
        var web3 = await loadWeb3();
        const networkId = await web3.eth.net.getId()
        const acc = await loadAccount(web3);
        const cappedContract = await loadCapped(web3, networkId);
        if(!cappedContract) {
          window.alert('Smart contract not detected on the current network. Please select another network with Metamask.')
          return;
        }
        setAccount(acc);
        setCapped(cappedContract);
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
                  <div>{account && `${account.slice(0, 6)}...${account.slice(account.length - 4, account.length)}`}
                </div>
                </div>
              </div>

                <div className="row">
                  <div>
                    <p className='title'>BALANCE:</p> 
                    <div>{balance}</div>
                  </div>
                  <button className='btnGet' type='button' onClick={callGetBalance}> Get </button>
                </div>

                <div className="row">
                  <div>
                    <p className='title'>TOTAL SUPPLY:</p> 
                    <div>{totalSupply}</div>
                  </div>
                  <button className='btnGet' type='button' onClick={callTotalSupply}> Get </button>
                </div>

                <div className="row">
                  <div>
                    <p className='title'>SET MINT PRICE:</p>
                    <input placeholder="New mint prince" className='inp' onChange={(e) => setMintPrice(e.target.value)}/>
                  </div>
                    <button className='btn' type="button" onClick={() => callSetMintPrice(mintPrice)}>ENTER</button>
                </div>

                <div className="row">
                <div>
                  <p className='title'>OWNER MINT</p> 
                </div>
                <button className='btn' type="button" onClick={callOwnerMint}>MINT</button>
              </div>

                <div className="row">
                <div>
                  <p className='title'>PUBLIC MINT</p>
                </div>
                  <button className='btn' type="button" onClick={() => callPublicMint(mintPrice)}>MINT</button>
                </div>

                <div className="row">
                <div>
                  <p className='title'>SALES</p> 
                </div>
                <button className='btn' type='button' onClick={callOpenSales}>OPEN</button>
                <button className='btn' type='button' onClick={callCloseSales}>CLOSE</button>
                </div>

                <div className="row">
                  <div>
                    <p className='title'>WITHDRAW</p> 
                  </div>
                  <button className='btnGet' type='button' onClick={callWithdraw}>WD</button>
                </div>

                

            </div>
          </div>
        </body>
      </div>
    )
}

export default LandingPage;