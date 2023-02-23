// sui client call --function transfer --module sui --package 0x2 --args $OBJECT_ID $RECIPIENT --gas-budget 1000
// sui client call --function mint_to --module avatar_nft --package 0x4a2f33d68c642c8e950d045af47db447ba25d1e5 --args https://images.pexels.com/photos/13739093/pexels-photo-13739093.jpeg 0xa62925633e4366eb1e78e72c4edbe4491f218cc0 --gas-budget 1000


//update sui 
// cargo install --locked --git https://github.com/MystenLabs/sui.git --branch devnet sui

//publish
//sui client publish '/Users/huyvu/Project/sui/avatar-nft/special_avatar_nft' --gas 0x292a5b1bff91525a54fe7967ab480324eae577d0 --gas-budget 30000 --verify-dependencies
// sui client publish '/Users/huyvu/Project/sui/market/nft_tmp' --gas 0x0ae1f2c3b0df0b2324807462db8fff2a408f6dc4 --gas-budget 30000
//sui client publish '/Users/huyvu/Project/sui/market/nft_tmp' --gas 0x22948dee8943f9d0b695b13c71e2605e7e6ced75 --gas-budget 30000



// sui client call --function buy_and_take --module marketplace --package 0xa0bcbbe26b56d56f2c354b8e6b0fc7c124aa49ae --type-args 0xa0bcbbe26b56d56f2c354b8e6b0fc7c124aa49ae::nft_tmp::TempNFT 0x2::sui::SUI --args 0x1355c6979534dcf23746849bcef68c1bcb56636e 0xb66ea80df32f1ccb11ebff3b00eebc9dd54548d0 1 --gas-budget 1000
