#[test_only]
module web3lab::BasicCoinTest {
    use web3lab::BasicCoin;
    use std::signer;
    struct Web3Coin has drop {}

    #[test]
    #[expected_failure]
    fun generate1() {
        assert!(BasicCoin::balance_of<Web3Coin>(@9) == 0, 0);
    }

    #[test(account = @0xC0FFEE)]
    fun generate2(account: &signer) {
        let addrr = signer::address_of(account);
        BasicCoin::generate<Web3Coin>(account);
        assert!(BasicCoin::balance_of<Web3Coin>(addrr) == 0, 0);
    }

    #[test(account = @0xC0FFEE)]
    fun mint(account: &signer) {
        let addrr = signer::address_of(account);
        let amount = 10u64;

        BasicCoin::generate<Web3Coin>(account);
        BasicCoin::mint<Web3Coin>(addrr, amount, Web3Coin{});
        assert!(BasicCoin::balance_of<Web3Coin>(addrr) == amount, 0);
    }
}
