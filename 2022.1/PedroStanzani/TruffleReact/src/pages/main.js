import React, {
  useEffect,
  useState
} from 'react';
import Head from './Header';
import './main.css';

import {
  utils
} from 'web3';

import {
  loadWeb3,
  loadAccount,
  loadERC721Capped
} from "../helpers/web3Functions";

const LandingPage = () => {
    const [account, setAccount] = useState("")

    const [meuContrato, setMeuContrato] = useState("")

    const [balance, setBalance] = useState("")
    const [issued, setIssued] = useState("")
    const [newMintPrice, setNewMintPrice] = useState(0)
    const [newOpenSalesPrice, setNewOpenSalesPrice] = useState(0)
    const [publicMintValue, setPublicMintValue] = useState(0)

    const callGetBalance = async () => {
      let b = await meuContrato.methods.getBalance().call();
      setBalance(utils.fromWei(b) + ' eth');
    }

    const callGetIssued = async () => {
      let i = await meuContrato.methods.getTotalSupply().call();
      setIssued(i);
    }

    const callOwnerMint = async () => {
      await meuContrato.methods.ownerMint().send({
        from: account
      });
    }

    const callPublicMint = async (value) => {
      value = utils.toWei(value);
      await meuContrato.methods.publicMint().send({
        from: account,
        value: value
      });
    }

    const callSetMintPrice = async (price) => {
      price = utils.toWei(price);
      await meuContrato.methods.setMintPrice(price).send({
        from: account
      });
    }

    const callOpenSales = async (price) => {
      price = utils.toWei(price);
      await meuContrato.methods.openSales(price).send({
        from: account
      });
    }

    const callCloseSales = async () => {
      await meuContrato.methods.closeSales().send({
        from: account
      });
    }

    const callWithdraw = async () => {
      await meuContrato.methods.withdraw().send({
        from: account
      });
    }

    const loadBlockchainData = async () => {
      var web3 = await loadWeb3();
      const networkId = await web3.eth.net.getId()
      const acc = await loadAccount(web3);

      const ERC721CappedContract = await loadERC721Capped(web3, networkId);
      if (!ERC721CappedContract) {
        window.alert('Smart contract not detected on the current network. Please select another network with Metamask.')
        return;
      }

      setAccount(acc);
      setMeuContrato(ERC721CappedContract);
    }
    useEffect(() => {
      loadBlockchainData();
    }, [])

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

              {/* getTotalSupply() */}
              <div className="row">
                  <div>
                    <p className='title'>Current Supply:</p> 
                    <div>{issued}</div>
                  </div>
                  <button className='btnGet' type='button' onClick={callGetIssued} >Get</button>
              </div>

              {/* Get Balance */}
              <div className="row">
                <div>
                  <p className='title'>Balance:</p> 
                  <div>{balance}</div>
                </div>
                <button className='btnGet' type='button' onClick={callGetBalance} >Get</button>
              </div>

                {/* Public Mint */}
                <div className="row">
                <div>
                  <p className='title'> Public Mint:</p>
                  <input placeholder="Mint price" className='inp' onChange={(e) => setPublicMintValue(e.target.value)}/>
                </div>
                  <button className='btn' type="button" onClick={() => callPublicMint(publicMintValue)}>Submit</button>
              </div>

              {/* Only owner highlight */}
              <div className="row">
                <div>
                  <p className='title red'>Only owner:</p> 
                </div>
              </div>

              {/* Owner Mint */}
              {/* TODO: conditional display (only show if owner account is connected) */}
              <div className="row">
                <div>
                  <p className='title'>Owner Mint:</p> 
                </div>
                <button className='btn' type="button" onClick={callOwnerMint}>Submit</button>
              </div>

              {/* Set mint price */}
              <div className="row">
                  <div>
                    <p className='title'> Set mint price:</p>
                    <input placeholder="Mint price" className='inp' onChange={(e) => setNewMintPrice(e.target.value)}/>
                  </div>
                    <button className='btn' type="button" onClick={() => callSetMintPrice(newMintPrice)}>Submit</button>
                </div>

              {/* Open sales */}
              <div className="row">
                  <div>
                    <p className='title'> Open Sales:</p>
                    <input placeholder="Mint price" className='inp' onChange={(e) => setNewOpenSalesPrice(e.target.value)}/>
                  </div>
                    <button className='btn' type="button" onClick={() => callOpenSales(newOpenSalesPrice)}>Submit</button>
                </div>

                {/* Close sales */}
              <div className="row">
                <div>
                  <p className='title'>Close sales:</p> 
                </div>
                <button className='btn' type="button" onClick={callCloseSales}>Submit</button>
              </div>

              {/* Withdraw */}
              <div className="row">
                <div>
                  <p className='title'>Withdraw:</p> 
                </div>
                <button className='btn' type="button" onClick={callWithdraw}>Submit</button>
              </div>
            </div>
          </div>
        </body>
      </div>
    )
}

export default LandingPage;