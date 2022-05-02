import React, { useEffect, useState } from 'react';
import Head from './Header';
import './main.css';

import {
    loadWeb3,
    loadAccount,
    loadGovernance,
    loadCoin,
    loadToken
} from "../helpers/web3Functions";

const formatAddress = (address) => {
  return (address &&
    `${address.slice(0, 6)}...${address.slice(
      address.length - 4,
      address.length
    )}`)
}

const LandingPage = () => {
    const [account, setAccount] = useState("")
    const [gov, setGov] = useState("")
    const [coin,setCoin]= useState("")
    const [web3, setWeb3] = useState()
    const [coinBalance, setCoinBalance] = useState(0)
    const [address, setAddress] = useState("")
    const [ammount, setAmmount] = useState("")
    const [status, setStatus] = useState(false)
    const [hasVoted, setVoted] = useState(false)


   


    const transfer = async(receiver, ammount) => {
      coin.methods.transfer(receiver, web3.utils.toBN(ammount * 10 ** 18)).send({from: account});
    }

    const vote = async() => {
      const govern = await gov.methods.getGovernance().call();;
      const tokengovernance = await loadToken(web3, web3.eth.net.getId(), govern)
      tokengovernance.methods.vote().send({from : account});
    }

    const getStatus = async() => {
      const st = await gov.methods.getGovernanceStatus().call();
      setStatus(st)
      alert(st);
    }

    const endVote = async() => {
      const govern = await gov.methods.getGovernance().call();;
      const governance = await loadGovernance(web3, web3.eth.net.getId(), govern)
      governance.methods.endVote().send({from : account});
    }

    const Status = (status) =>{
      if(status===false){
        return "Aguardando votos"
      }
      else{
        return "Encerrado"
      }
    } 

    const HasVoted = (hasVoted) =>{
      if(hasVoted===true){
        return "Já votou"
      }
      else{
        return "Ainda não votou"
      }
    }


    const loadBlockchainData = async () => {
        var web3 = await loadWeb3();
        setWeb3(web3);
        const networkId = await web3.eth.net.getId()
        const acc = await loadAccount(web3);
        const govContract = await loadGovernance(web3, networkId);
        if(!govContract) {
          window.alert('gov Contarct not detected on the current network. Please select another network with Metamask.')
          return;
        }
        const governContractAddress = await govContract.methods.getGovernance().call();
        const governContract = await loadToken(web3, web3.eth.net.getId(), governContractAddress)

        if(!governContract) {
          window.alert('govern contarct not detected on the current network. Please select another network with Metamask.')
          return;
        }

        const voted = await governContract.methods.hasVoted(acc).call()
        setVoted(voted)

        const coinContractAddress = await govContract.methods.getToken().call();
        const currCointContract = await loadCoin(web3, web3.eth.net.getId(), coinContractAddress)
        if(!currCointContract) {
          window.alert('cur coin Contarct not detected on the current network. Please select another network with Metamask.')
          return;
        }
        const bal = await currCointContract.methods.balanceOf(acc).call()
        console.log(bal)
        setCoinBalance(bal)
       
        setAccount(acc);
        setGov(govContract);
        setCoin(currCointContract);
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
                  <p className='title'>Conta:</p>
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
                  <p className='title'>Balanço</p>
                  <div>{parseInt(coinBalance)/10**18}</div>
                </div>
              </div>
            <div className="row">
                  <p className='title'>Transferir</p>
                  <input placeholder='Destinatário' value={address} onChange = {(e) => setAddress(e.target.value)} />
                  <input placeholder='Amostra' value={ammount} onChange = {(e) => setAmmount(e.target.value)} />
                  <button className='btn' type="button" onClick={() => transfer(address, ammount)}> transfer</button>
            </div>
            <div className="row">
                  <p className='title'> Votar</p>
                  <div>{HasVoted(hasVoted)}</div>
                  <button className='btn' type="button" onClick={vote}> vote</button>
                </div>
            <div className="row">
                  <p className='title'> Estado da Votacao</p>
                  <p>{Status(status)}</p>
                  <button className='btn' type="button" onClick={getStatus}>Status</button>
            </div>

            <div className="row">
                  <p className='title'> Encerrar Votação</p>
                  <button className='btn' type="button" onClick={endVote}>Terminar</button>
            </div>
            </div>
            
          </div>
        </body>
      </div>
    )
}

export default LandingPage;