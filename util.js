const Web3 = require('web3');
const fs = require('fs-extra');
let array = ['0xaddc2954a1759bd8207ba7d3e69ecf0daa1539ff','0xdc196587b59a8accbab502a642ce96ae71e017e1','0xfa937f92f8a106dcac3f3d2d8930e07e540a596d','0xbf5f1efcd38b90231d1bc6694f7eb54135c989f3','0xd69ba0709d161543fa19fa67c2e3ee95da33fb72' ];
let checkArray = [];
let file = 'addresses.txt';
array.forEach((item)=>{
  console.log(item);
checkArray.push(Web3.utils.toChecksumAddress(item));
// With a callback:
fs.outputFile(file, checkArray[item], err => {
    console.log(err) // => null
  
    fs.readFile(file, 'utf8', (err, data) => {
      if (err) return console.error(err)
      console.log(data) // => hello!
    })
  })
});



