import web3 from './web3';
//Your contract address
const address = '0x7311bd9c8e5a3d46f3d36d8e99820682335fb949';
//Your contract ABI
const abi = [

	{
		"constant": false,
		"inputs": [
			{
				"name": "x",
				"type": "string"
			}
		],
		"name": "setHash",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "getHash",
		"outputs": [
			{
				"name": "x",
				"type": "string"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	}
];


export default new web3.eth.Contract(abi, address);