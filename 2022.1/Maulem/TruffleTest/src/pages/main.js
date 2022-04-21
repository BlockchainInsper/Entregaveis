import React, { useEffect, useState } from 'react';
import Head from './Header';
import './main.css';

import {
    loadWeb3,
    loadAccount,
    loadCoin,
    loadGovernance
} from "../helpers/web3Functions";

const LandingPage = () => {
    const [account, setAccount] = useState("")
    const [coin, setCoin] = useState("")
    const [governance, setGovernance] = useState("")
    const [poolGoing, setPoolGoing] = useState("")
    const [voted, setIfVoted] = useState("")
    const [voteNum, setVoteNum] = useState("")
    const [tokensNum, setTokenSNum] = useState("")

    const callGetIfEnded = async () => {
      var f = "Error";
      if (!await governance.methods.getStatus().call()) {
        f = "Yes";
      }
      else {
        f = "No";
      }
      setPoolGoing(f);
    }

    const callGetIfVoted = async () => {
      var f = "Error";
      if (await governance.methods.hasVoted(account).call()) {
        f = "Yes";
      }
      else {
        f = "No";
      }
      setIfVoted(f);
    }

    // const callGetVotedNumber = async () => {
    //   var f = String(await governance.methods.getVoters().call());
    //   setVoteNum(f);
    // }

    // const callGetTokensNumber = async () => {
    //   var f = String(await governance.methods.getTokens().call());
    //   setTokenSNum(f);
    // }

    const callToVote = async () => {
      await governance.methods.vote().send({from: account})
    }

    const callToEnd = async () => {
      await governance.methods.endVote().send({from: account})
    }

    const callGetTokens = async () => {
      await coin.methods.getTokensForTest().send({from: account});
    }

    const loadBlockchainData = async () => {
        var web3 = await loadWeb3();
        const networkId = await web3.eth.net.getId()
        const acc = await loadAccount(web3);
        const coinContract = await loadCoin(web3, networkId);
        const governanceContract = await loadGovernance(web3, networkId);
        if(!coinContract || !governanceContract) {
          window.alert('One of Smart contracts or both was not detected on the current network. Please select another network with Metamask.')
          return;
        }
        setAccount(acc);
        setCoin(coinContract);
        setGovernance(governanceContract);
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
                  <p className='title'>Your account:</p>
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
                    <p className='title'> Get free tokens for tests</p>
                    <div>(will be removed)</div>
                  </div>
                    <button className='btnGet' type="button" onClick={callGetTokens}>Get</button>
                </div>
                <div className="row">
                  <div>
                    <p className='title'>The pool is still going?</p> 
                    <div>{poolGoing}</div>
                  </div>
                  <button className='btnGet' type='button' onClick={callGetIfEnded}>Check</button>
                </div>
                <div className="row">
                  <div>
                    <p className='title'>You already voted?</p> 
                    <div>{voted}</div>
                  </div>
                  <button className='btnGet' type='button' onClick={callGetIfVoted}>Check</button>
                </div>
                {/* <div className="row">
                  <div>
                    <p className='title'>How many voted?</p> 
                    <div>{voteNum}</div>
                  </div>
                  <button className='btnGet' type='button' onClick={callGetVotedNumber}>Check</button>
                </div>
                <div className="row">
                  <div>
                    <p className='title'>How much tokens?</p> 
                    <div>{tokensNum}</div>
                  </div>
                  <button className='btnGet' type='button' onClick={callGetTokensNumber}>Check</button>
                </div> */}
                <div className="row">
                  <div>
                  </div>
                  <button className='btnGet' type='button' onClick={callToVote}>Vote</button>
                </div>
                <div className="row">
                  <div>
                  </div>
                  <button className='btnGet' type='button' onClick={callToEnd}>End pool</button>
                </div>
            </div>
          </div>
        </body>
      </div>
    )
}

export default LandingPage;