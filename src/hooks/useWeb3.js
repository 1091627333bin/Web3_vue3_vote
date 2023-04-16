import Web3 from 'web3'
import Vote from '../build/Vote.json'

const useWeb3 = async () =>{
    var web3 = new Web3(Web3.givenProvider || "http://localhost:8545");
    const accounts = await web3.eth.requestAccounts()
    const currentAccount = accounts[0]
    const networkId =await web3.eth.net.getId()
    const voteContract = await new web3.eth.Contract(Vote.abi,Vote.networks[networkId].address)

    return {
        web3,voteContract,currentAccount
    }
}
export default useWeb3;

