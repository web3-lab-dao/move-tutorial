module marsland::dogcoin {
    use aptos_framework::managed_coin;
    use aptos_framework::coin;
    use aptos_framework::resource_account;

    struct DogCoin {}

    fun init_module(sender: &signer) {
        //init this coin: ok
        managed_coin::initialize<DogCoin>(sender, b"Dog Coin", b"Mars", 6, true, );
        //then retrive caps
        //create other resource account
        //then transfer/move all that
    }

    public entry fun register(account: &signer){
        managed_coin::register<DogCoin>(account);
    }

    public entry fun mint(owner: &signer, to: address, amount: u64){
        managed_coin::mint<DogCoin>(owner, to, amount);
    }

    public entry fun burn(owner: &signer, amount: u64){
        managed_coin::burn<DogCoin>(owner, amount);
    }

    public entry fun transfer(from: &signer, to: address, amount: u64){
        coin::transfer<DogCoin>(from, to, amount);
    }

    public entry fun getBalance(owner: address): u64 {
        let balance = coin::balance<DogCoin>(owner);
        balance
    }
}
