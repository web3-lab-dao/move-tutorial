module MarsLand::mars_coin2 {
    use aptos_framework::managed_coin;
    use aptos_framework::coin;

    struct MarsCoin {}

    fun init_module(sender: &signer) {
        managed_coin::initialize<MarsCoin>(sender, b"Mars Coin", b"Mars", 6, true, );
    }

    public entry fun register(account: &signer){
        managed_coin::register<MarsCoin>(account);
    }

    public entry fun mint(owner: &signer, to: address, amount: u64){
        managed_coin::mint<MarsCoin>(owner, to, amount);
    }

    public entry fun burn(owner: &signer, amount: u64){
        managed_coin::burn<MarsCoin>(owner, amount);
    }

    public entry fun transfer(from: &signer, to: address, amount: u64){
        coin::transfer<MarsCoin>(from, to, amount);
    }

    public entry fun getBalance(owner: address): u64 {
        let balance = coin::balance<MarsCoin>(owner);
        balance
    }
}
