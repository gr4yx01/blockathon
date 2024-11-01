require("@nomicfoundation/hardhat-toolbox")

require('dotenv').config();

const config = {
  solidity: "0.8.23",
  networks: {
    // for testnet
    'lisk-sepolia': {
      url: 'https://rpc.sepolia-api.lisk.com',
      accounts: [process.env.WALLET_KEY],
      gasPrice: 1000000000,
    },
  },
};

module.exports = config;