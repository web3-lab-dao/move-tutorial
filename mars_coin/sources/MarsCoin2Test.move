#[test_only]
module marsland::MarsCoin2Test {
    use marsland::dogcoin::DogCoin;
    use aptos_framework::coin;
    use aptos_framework::managed_coin;
    use marsland::dogcoin;
    use aptos_framework::account;
    use std::signer;
    use aptos_std::debug;
    use std::string;

    const ERROR_INITED: u64 = 1000;
    const ERROR_NOT_INITED: u64 = 1002;
    const ERROR_NOT_REGISTERED: u64 = 1003;
    const ERROR_BALANCE_UNMATCHED: u64 = 1004;



    #[test(owner = @marsland)]
    fun testInit(owner: &signer) {
        let msg = string::utf8(b"testInit");
        debug::print(&msg);
        assert!(!coin::is_coin_initialized<DogCoin>(), ERROR_INITED);
        managed_coin::initialize<DogCoin>(owner, b"Mars Coin", b"MarsCoin", 6, true);
        assert!(coin::is_coin_initialized<DogCoin>(), ERROR_NOT_INITED);
        debug::print(&msg);
    }

    #[test(owner = @marsland, _register = @TestMint)]
    fun testRegister(owner: &signer, _register: &signer) {
        managed_coin::initialize<DogCoin>(owner, b"Mars Coin", b"MarsCoin", 6, true);
        account::create_account_for_test(signer::address_of(_register));
        dogcoin::register(_register);
        assert!(coin::is_account_registered<DogCoin>(signer::address_of(_register)), ERROR_NOT_REGISTERED);
    }

    #[test(owner = @marsland, to = @TestMint)]
    fun testMint(owner: &signer, to: &signer) {
        managed_coin::initialize<DogCoin>(owner, b"Mars Coin", b"MarsCoin", 6, true);
        account::create_account_for_test(signer::address_of(to));
        dogcoin::register(to);
        dogcoin::mint(owner, signer::address_of(to), 1000);
        assert!(dogcoin::getBalance(signer::address_of(to)) == 1000, ERROR_BALANCE_UNMATCHED);
    }

}
