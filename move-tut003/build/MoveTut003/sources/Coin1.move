module web3lab::Coin1 {
    use std::debug;
    use std::signer;

    const ERR_ALREADY_EXIST: u64 = 1000;
    const ERR_NOT_EXIST: u64 = 1001;
    const ERR_DUP_ADDR: u64 = 1002;
    const ERR_NOT_ENOUGH: u64 = 1003;

    struct Coin<phantom  CoinType> has store, key {
        balance: u128
    }


    public fun initBalance<CoinType>(account: &signer){
        let coin = Coin<CoinType> { balance: 0u128};
        assert!(!exists<Coin<CoinType>>(signer::address_of(account)), ERR_ALREADY_EXIST);

        //then move to ...
        move_to(account, coin);
    }

    public fun balanceOf<CoinType>(owner: address): u128 acquires Coin{
        borrow_global<Coin<CoinType>>(owner).balance
    }

    public fun mint<CoinType>(to: address, amt: u128) acquires Coin{
        assert!(exists<Coin<CoinType>>(to), ERR_NOT_EXIST);
        let coin = borrow_global_mut<Coin<CoinType>>(to);
        coin.balance = coin.balance + amt;
    }

    public fun transfer<CoinType: drop>(from: &signer, to: address, val: u128, _witness: CoinType) acquires Coin{
        let fromAddr = signer::address_of(from);
        assert!(fromAddr != to, ERR_DUP_ADDR);
        let out = withdraw<CoinType>(signer::address_of(from), val);
        deposit(to, out);
    }

    public fun withdraw<CoinType>(from: address, val: u128): Coin<CoinType> acquires Coin{
        let currentBalance = balanceOf<CoinType>(from);
        assert!(currentBalance >= val, ERR_NOT_ENOUGH);
        let ref = borrow_global_mut<Coin<CoinType>>(from);
        ref.balance = ref.balance - val;
        Coin<CoinType> {balance: val}
    }

    public fun deposit<CoinType>(to: address, coin: Coin<CoinType>) acquires Coin{
        let target = borrow_global_mut<Coin<CoinType>>(to);
        let Coin {balance: amt} = coin;
        target.balance = target.balance + amt;
    }
}
