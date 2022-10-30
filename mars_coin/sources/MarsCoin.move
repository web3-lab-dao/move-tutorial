//:!:>moon
module MarsLand::mars_coin {
    use aptos_framework::managed_coin;

    struct MarsCoin {}
    struct LandCoin {}

    fun init_module(sender: &signer) {
        aptos_framework::managed_coin::initialize<MarsCoin>(sender, b"Mars Coin", b"Mars", 6, true, );
        managed_coin::initialize<LandCoin>(sender, b"Land Coin", b"Land", 6u8, true);
    }
}
//<:!:moon
