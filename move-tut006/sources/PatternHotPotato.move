module web3lab::PatternHotPotato {
    use std::signer;
    use std::debug;

    /// no: drop, copy, key, store
    /// just create --> unpack within module, can't be stored!

    struct USDT {}

    struct ETH {}

    struct Receipt<phantom T> {
        amount: u128,
        owner: address
    }

    /// make bill
    public fun makeReceipt<T>(account: &signer, amt: u128): Receipt<T>{
        Receipt<T>{amount: amt, owner: signer::address_of(account)}
    }

    ///can't be stored in global, or copied or droped!
    /// the only way is to consume it!
    public fun payReceipt<T>(bill: Receipt<T>){
        let Receipt<T> {amount, owner} = bill;
    }

    #[test(account = @0xC0FFEE)]
    fun test(account: &signer){
        let bill = makeReceipt<USDT>(account, 128u128);
        payReceipt(bill);
    }
}
