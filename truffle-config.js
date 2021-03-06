let HDWalletProvider = require("truffle-hdwallet-provider");

//let mnemonic ="crater close lunar fitness uphold glue morning resemble suspect cigar front roast";
let mnemonic = "room slow toddler allow accuse jelly left portion muscle pigeon post powder";
let account = "0x7311bd9c8e5a3d46f3d36d8e99820682335fb949";

// console.log(providerk);
// See <http://truffleframework.com/docs/advanced/configuration>
// to customize your Truffle configuration!
module.exports = {
    networks: {
        development: {
            host: "127.0.0.1",
            port: 7545,
            network_id: "*", // Match any network id
            gas: 4712388,
            gasPrice: 100000000000
        },
        rinkeby: {
            provider: function() {
                return new HDWalletProvider(mnemonic,"https://rinkeby.infura.io/v3/440f2d02e2cd41dea342eeccd9fd811e")
            },
            network_id: '4',
            gas: 4500000,
            gasPrice: 10000000000,
        }
    },
    compilers: {
        solc: {
          version: "^0.5.0"
        }
      }
};

