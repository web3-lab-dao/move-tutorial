module web3lab::BasicCoin {
    use std::signer;

    /// Error codes
    const ENOT_MODULE_OWNER: u64 = 0;
    const EINSUFFICIENT_BALANCE: u64 = 1;
    const EALREADY_HAS_BALANCE: u64 = 2;
    const EALREADY_INITIALIZED: u64 = 3;
    const EEQUAL_ADDR: u64 = 4;


    struct Coin<phantom CoinType> has store {
        value: u64
    }

    struct Balance<phantom CoinType> has key {
        coin: Coin<CoinType>
    }

    //logic generate asset
    public fun generate<CoinType>(account: &signer) {
        let empty_coin = Coin<CoinType> { value: 0 };
        let exist_balance = exists<Balance<CoinType>>(signer::address_of(account));
        assert!(!exist_balance, EALREADY_HAS_BALANCE);
        move_to(account, Balance<CoinType> { coin: empty_coin });
    }

    spec generate {
        include GenerateSchema<CoinType> { addrr: signer::address_of(account), amount: 0 };
    }

    spec schema GenerateSchema<CoinType> {
        addrr: address;
        amount: u64;

        aborts_if exists<Balance<CoinType>>(addrr);
        ensures exists<Balance<CoinType>>(addrr);
        let post balance_port = global<Balance<CoinType>>(addrr).coin.value;
        ensures balance_port == amount;
    }

    //logic get balance
    public fun balance_of<CoinType>(owner: address): u64 acquires Balance {
        borrow_global<Balance<CoinType>>(owner).coin.value
    }

    spec balance_of {
        pragma aborts_if_is_stric;
        aborts_if !exists<Balance<CoinType>>(owner);
    }

    //logic mint
    public fun mint<CoinType: drop>(mint_addrr: address, amount: u64, coin_type: CoinType) acquires Balance {
        deposit(mint_addrr, Coin<CoinType> { value: amount });
    }

    spec mint {
        include DepositSchema<CoinType> { addrr: mint_addrr, amount };
    }

    //logic transfer
    public fun transfer<CoinType: drop>(from: &signer, to: address, amount: u64, coin_type: CoinType) acquires Balance {
        let from_address = signer::address_of(from);
        assert!(from_address != to, EEQUAL_ADDR);
        let check = withdraw<CoinType>(from_address, amount);
        deposit<CoinType>(to, check);
    }

    spec transfer {
        let addrr_from = signer::address_of(from);

        let balance_from = global<Balance<CoinType>>(addrr_from).coin.value;
        let balance_to = global<Balance<CoinType>>(to).coin.value;

        let post balance_from_post = global<Balance<CoinType>>(addrr_from).coin.value;
        let post balance_to_post = global<Balance<CoinType>>(to).coin.value;

        aborts_if !exists<Balance<CoinType>>(addrr_from);
        aborts_if !exists<Balance<CoinType>>(to);
        aborts_if balance_from < amount;
        aborts_if balance_to + amount > MAX_U64;
        aborts_if addrr_from == to;

        ensures balance_from_post == balance_from - amount;
        ensures balance_to_post == balance_to + amount;
    }

    //logic deposit
    public fun deposit<CoinType>(addrr: address, check: Coin<CoinType>) acquires Balance {
        let balance = balance_of<CoinType>(addrr);
        let balance_ref = &mut borrow_global_mut<Balance<CoinType>>(addrr).coin.value;
        let Coin { value } = check;
        *balance_ref = balance + value;
    }

    spec deposit {
        let balance = global<Balance<CoinType>>(addrr).coin.value;
        let check_value = check.value;

        aborts_if !exists<Balance<CoinType>>(addrr);
        aborts_if balance + check_value > MAX_U64;

        let post balance_post = global<Balance<CoinType>>(addrr).coin.value;
        ensures balance_post = balance + check_value;
    }

    spec schema DepositSchema<CoinType> {
        addrr: address;
        amount: u64;

        let balance = global<Balance<CoinType>>(addrr).coin.value;

        aborts_if !exists<Balance<CoinType>>(addrr);
        aborts_if balance + amount > MAX_U64;

        let post balance_post = global<Balance<CoinType>>(addrr).coin.value;

        ensures balance_post == balance + amount;
    }


    //logic withdraw
    fun withdraw<CoinType>(addrr: address, amount: u64): Coin<CoinType> acquires Balance {
        let balance = balance_of<CoinType>(addrr);
        assert!(balance > amount, EINSUFFICIENT_BALANCE);
        let balance_ref = &mut borrow_global_mut<Balance<CoinType>>(addrr).coin.value;
        *balance_ref = balance - amount;
        Coin<CoinType> { value: amount }
    }

    spec withdraw {
        let balance = global<Balance<CoinType>>(addrr).coin.value;
        aborts_if !exists<Balance<CoinType>>(addrr);
        aborts_if balance < amount;

        let post balance_post = global<Balance<CoinType>>(addrr).coin.value;
        ensures result == Coin<CoinType> { value: amount };

        ensures balance_post == balance - amount;
    }
}
