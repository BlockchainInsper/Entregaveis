import React, { useEffect, useState } from 'react';
import Head from './Header';
import './main.css';

import {
    loadWeb3,
    loadAccount,
    loadCoin,
    loadTokenGovernance
} from "../helpers/web3Functions";

const LandingPage = () => {
    const [account, setAccount] = useState("")

    const [address, setAddress] = useState("")
    const [ammount, setAmmount] = useState("")

    const [coinBalance, setCoinBalance] = useState(0)

    const [web3, setWeb3] = useState()

    //Contracts
    const [governance, setGovernance] = useState("")
    const [coin, setCoin] = useState("")

    const [hasVoted, setVoted] = useState(false)

    const transfer = async(receiver, ammount) => {
      coin.methods.transfer(receiver, web3.utils.toBN(ammount * 10 ** 18)).send({from: account});
    }

    const vote = async() => {
      governance.methods.vote().send({from : account});
    }

    const endVote = async() => {
      governance.methods.endVote().send({from : account});
    }

    const loadBlockchainData = async () => {
        var web3 = await loadWeb3();
        setWeb3(web3);
        const networkId = await web3.eth.net.getId()
        const acc = await loadAccount(web3);

        const coinContract = await loadCoin(web3, networkId);
        if(!coinContract) {
          window.alert('Smart contract not detected on the current network. Please select another network with Metamask.')
          return;
        }

        const tokenGovernance = await loadTokenGovernance(web3, networkId);
        if(!tokenGovernance) {
          window.alert('aSmart contract not detected on the current network. Please select another network with Metamask.')
          return;
        }

        const voted = await tokenGovernance.methods.hasVoted(acc).call()
        setVoted(voted)
        
        const bal = await coinContract.methods.balanceOf(acc).call()
        setCoinBalance(bal)

        setAccount(acc);
        setCoin(coinContract);
        setGovernance(tokenGovernance)
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
                  <p className='title'>Coin Balance</p>
                  <div>{parseInt(coinBalance)/10**18}</div>
                </div>
              </div>
                <div className="row">
                  <p className='title'>Transfer</p>
                  <input placeholder='receiver' value={address} onChange = {(e) => setAddress(e.target.value)} />
                  <input placeholder='ammount' value={ammount} onChange = {(e) => setAmmount(e.target.value)} />
                  <button className='btn' type="button" onClick={() => transfer(address, ammount)}> transfer</button>
                </div>
                <div className="row">
                  <p className='title'> vote</p>
                  <div>{hasVoted ? "already voted" : "has not voted"}</div>
                  <button className='btn' type="button" onClick={vote}> vote</button>
                </div>
                <div className="row">
                  <p className='title'> end vote</p>
                  <button className='btn' type="button" onClick={endVote}>END</button>
                </div>
            </div>
          </div>
        </body>
      </div>
    )
}

export default LandingPage;

export default LandingPage;
