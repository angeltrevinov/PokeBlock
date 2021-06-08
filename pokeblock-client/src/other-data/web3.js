import Web3 from 'web3';

if (typeof window.ethereum !== 'undefined') {
    console.log('MetaMask is installed');
} else {
    alert('Please Install MetaMask');
}

const web3 = new Web3(
    window.web3.currentProvider ||
    "ws://localhost:8545"
);

export default web3;
