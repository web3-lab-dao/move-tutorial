module web3lab::OrderBook {
    use std::debug;

    struct Order has key, store, drop {
        timestamp: u128,
        vol: u128
    }

    public fun init(){
        debug::print(&b"hello rustling friends!");
    }

    public fun transfer(from: &mut Order, to: &mut Order){
        debug::print(from);
        debug::print(to);
    }

    public fun genOrder(): Order{
        let order = Order{
            timestamp: 1010101,
            vol: 1000
        };

        order
    }
}
