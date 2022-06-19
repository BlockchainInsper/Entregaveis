import React, { useEffect, useState } from 'react';
import Head from './Header';
import './main.css';

import {
    loadWeb3,
    loadAccount,
    loadERC721
} from "../helpers/web3Functions";

const LandingPage = () => {
    const [account, setAccount] = useState("")
    const [ERC, setERC] = useState("")
    const [price, setNewprice] = useState()
    const [price2, setNewprice2] = useState()
    const [Supply, setsupply] = useState()
    const [balance,setbalance] =useState()

    
    
    const getbalance = async()=>{
      const g = await ERC.methods.getBalance().call();
      setbalance(g);

    }

    const supply = async()=>{
      const h = await ERC.methods.getTotalSupply().call();
      setsupply(h);

    }
    
    const NFTowner = async()=>{
      try{
      await ERC.methods.ownerMint().send({from: account});
      }
      catch (error) {
        console.log(error)
        alert('Only the contract owner has permission to create this type of Nft')
      }
      
      

    }

    const NFTpublic = async()=>{
      await ERC.methods.publicMint().send({from: account,value:price2}); 
      
      

    }
    
    const opensales = async(price_)=>{
      try{
      await ERC.methods.openSales(price_).send({from: account});
      setNewprice2(price_);
      
      }
      catch (error) {
        console.log(error)
        alert('Only the contract owner has permission to open sales')
      }


    }

    const closesales = async()=>{
      try{
        await ERC.methods.closeSales().send({from:account});
    }
    catch (error) {
      console.log(error)
      alert('Only the contract owner has permission to close sales')
    }

      



    }

    const Withdraw = async()=>{

      try{
        await ERC.methods.withdraw().send({from:account});
    }
    catch (error) {
      console.log(error)
      alert('Only the contract owner has permission to withdraw')
    }


    }







    const loadBlockchainData = async () => {
        var web3 = await loadWeb3();
        const networkId = await web3.eth.net.getId()
        const acc = await loadAccount(web3);
        const ERC721Cappedcontract=await loadERC721(web3,networkId);
        if(!ERC721Cappedcontract) {
          window.alert('Smart contract not detected on the current network. Please select another network with Metamask.')
          return;
        }
        setAccount(acc);
        setERC(ERC721Cappedcontract);
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
                  <p className='title'>Account:</p>
              
                  <div>{account &&
                    `${account.slice(0, 6)}...${account.slice(
                      account.length - 4,
                      account.length
                    )}`}
                </div>
                </div>
              </div>
              <div className="row">
                <input placeholder='new account' className='inp' onChange={(e) => setAccount(e.target.value)}></input>
              </div>
                <div className="row">
                  <div>
                    <p className='title'> Balance:</p> 
                    <div>{balance}</div>
                  </div>
                  <button className='btnGet' type='button' onClick={getbalance} >Get</button>
                </div>
                <div className="row">
                  <div>
                    <p className='title'> Total supply:</p> 
                    <div>{Supply}</div>
                  </div>
                  <button className='btnGet' type='button' onClick={supply} >Get</button>
                </div>
                <div className="row">
                  <div>
                    <p className='title'>Open sales:</p> 
                    <input placeholder="Novo mintprice" className='inp' onChange={(e) => setNewprice(e.target.value)}/>
                    
                  

                  </div>
                  <button className='btnGet' type='button' onClick={() => opensales(price)} >submit</button>
                </div>

                <div className="row">
          
                  <button className='btnGet' type='button' onClick={()=> NFTowner()} >Owner NFT</button>
                  <button className='btnGet' type='button' onClick={NFTpublic} >Public NFT</button>
                  <button className='btnGet' type='button' onClick={() => closesales()} >Close sales</button>
                  <button className='btnGet' type='button' onClick={() => Withdraw()} >With draw</button>
                  
                </div>
            </div>
          </div>
        </body>
      </div>
    )
}

export default LandingPage;