import React, { useEffect, useState } from 'react';
import Head from './Header';
import './main.css';
import Web3 from 'web3';

import {
    loadWeb3,
    loadAccount,
    loadTutorial,
    loadCapped
} from "../helpers/web3Functions";


const LandingPage = () => {
    const [account, setAccount] = useState("");
    const [tutorial, setTutorial] = useState("");
    const [newFrase, setNewFrase] = useState("");
    const [frase, setFrase] = useState("");

    // hooks do ERC721Capped
    const [capped, setCapped] = useState(""); // objeto do contrato
    const [supply, setSupply] = useState(""); // armazena current supply
    const [price, setPrice] = useState(""); // armazena admin mint price


    const callGetFrase = async () => {
      const f = await tutorial.methods.get().call();
      setFrase(f);
    }

    const callSetFrase = async (f) => {
     await tutorial.methods.set(f).send({from: account});
    }

    // interface com functions do ERC721Capped 
    const callGetTotalSupply = async () => {
      const f = await capped.methods.getTotalSupply().call();
      setSupply(f);
    }
    const callOwnerMint = async () => {
      await capped.methods.ownerMint().send({from: account});
    }
    const callSetMintPrice = async (f) => {
      await capped.methods.setMintPrice(f).send({from: account});
    }
    const callOpenSales = async (f) => {
      await capped.methods.openSales(f).send({from: account});
    }
    const callCloseSales = async () => {
      await capped.methods.closeSales().send({from: account});
    }
    const callWithdraw = async () => {
      await capped.methods.withdraw().send({from: account});
    }
    const callPublicMint = async () => {
      const f = await capped.methods.getMintPrice().call()
      await capped.methods.publicMint().send({from: account, value: f});
    }






    const loadBlockchainData = async () => {
        var web3 = await loadWeb3();
        const networkId = await web3.eth.net.getId()
        const acc = await loadAccount(web3);
        const tutorialContract = await loadTutorial(web3, networkId);
        const contractERC = await loadCapped(web3, networkId);
        if(!tutorialContract || !contractERC) {
          window.alert('Smart contract not detected on the current network. Please select another network with Metamask.')
          return;
        }
        setAccount(acc);
        setTutorial(tutorialContract);
        setCapped(contractERC)
      }
    useEffect(() => {
      loadBlockchainData(); 
    },[])

    

    return (
      <div>
        <Head />
        <body className='body'>
          <div className="center col-1">
            <div className="col">
            <h2>Admin Panel</h2>
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
                    <p className='title'>Owner Mint (bypasses checks):</p> 
     

                  </div>
                  <button className='btn' type='button' onClick={callOwnerMint} >Mint</button>
                </div>
                <div className="row">
                  <div>
                    <p className='title'>Open sales:</p>
                    <input placeholder="Mint price" className='inp' onChange={(e) => setPrice(Web3.utils.toWei(e.target.value, "ether"))}/>
                  </div>
                  <button className='btn' type='button' onClick={() => callOpenSales(price)} >Open</button>
                </div>
                <div className="row">
                  <div>
                    <p className='title'>Alter mint price:</p> 
                    <input placeholder="Mint price" className='inp' onChange={(e) => setPrice(Web3.utils.toWei(e.target.value, "ether"))}/>
                  </div>
                  <button className='btn' type='button' onClick={() => callSetMintPrice(price)} >Submit</button>
                </div>
                <div className="row">
                  <div>
                    <p className='title'>Close sales:</p> 
                  </div>
                  <button className='btn' type='button' onClick={callCloseSales} >Close</button>

                </div>
                <div className="row">
                  <div>
                    <p className='title'>Withdraw ETH from contract:</p> 
                  </div>
                  <button className='btn' type='button' onClick={callWithdraw} >W/D</button>
                </div>
            </div>
          </div>
          <div className="center col-2">
            <div className="col">
            <h2>User Panel</h2>
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
                    <p className='title'>View total supply:</p>
                    <div>
                      {supply}
                    </div>
                  </div>
                  <button className='btnGet' type='button' onClick={callGetTotalSupply} >Submit</button>
                </div>
                <div className="row">
                  <div>
                    <p className='title'>Public Mint:</p> 
                  </div>
                  <button className='btn' type='button' onClick={callPublicMint} >Mint</button>
                </div>
            </div>
          </div>
        </body>
      </div>
    )
}

export default LandingPage;