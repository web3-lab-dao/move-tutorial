
#[test_only]
module web3lab::Test001 {
    use std::debug;
    use web3lab::PatternNestedResource;
    use std::signer;

    #[test(account = @0xC0FFEE)]
    fun case01(account: signer) {
        let addr = signer::address_of(&account);
        let resource = PatternNestedResource::build(addr, 1024u64);
        let (addr2, content2) = PatternNestedResource::read(&resource);
        assert!(addr == *addr2, 1000);
        assert!(*content2 == 1024u64, 1001);
        let content2 = PatternNestedResource::extract(&account, resource);
    }
}
