#[test_only]
module web3lab::BasicSwapTest001 {
    use std::debug;
    use std::signer;

    #[test(account = @0xC0FFEE)]
    fun case01(account: signer) {
        let addr = signer::address_of(&account);
    }
}
