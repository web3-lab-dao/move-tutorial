module web3lab::PatternMultiConfig {
    use web3lab::PatternMultiConfigAgent;
    use std::signer;

    const LIQUID_ADDR: address = @0x01;

    public fun call(account: &signer, amt: u128){
        PatternMultiConfigAgent::playWhenMarketDown(LIQUID_ADDR, signer::address_of(account), amt);
    }
}
