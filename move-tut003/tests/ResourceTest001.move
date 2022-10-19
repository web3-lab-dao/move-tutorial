
#[test_only]
module web3lab::Test001 {
    use std::debug;
    use web3lab::Resource;
    use std::signer;

    #[test(account = @0xC0FFEE)]
    fun case01(account: signer) {
        let addr = signer::address_of(&account);
        Resource::init(&account);
        let contains = Resource::check(&addr);
        assert!(contains, 1000);

        let len = Resource::getSize(addr);
        assert!(Resource::getSize(addr) == 0, 1000);

        Resource::push(addr, 800u64);
        assert!(Resource::getSize(addr) == 1, 1000);
    }
}
