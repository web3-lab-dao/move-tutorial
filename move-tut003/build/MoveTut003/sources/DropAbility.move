module web3lab::DropAbility {
    use std::signer;

    struct Free has drop, copy {
        owner: address,
        amt: u128
    }

    #[test(account = @0xC0FFEE)]
    fun testDrop(account: &signer){
        let f1 = Free {
            owner: signer::address_of(account),
            amt: 1024u128
        };
        let f2 = f1; //copy
    }
}
