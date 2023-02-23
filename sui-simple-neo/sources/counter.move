module sui_simple::counter {

    use sui::object::UID;
    use sui::tx_context::TxContext;
    use sui::object;
    use sui::tx_context;
    use sui::transfer;

    struct Counter has key {
        id: UID,
        owner: address,
        value: u64
    }

    public fun owner(counter: &Counter): address {
        counter.owner
    }

    public fun value(counter: &Counter): u64 {
        counter.value
    }

    public entry fun create(ctx: &mut TxContext) {
        let counter = Counter {
            id: object::new(ctx),
            owner: tx_context::sender(ctx),
            value: 0
        };
        transfer::share_object(counter);
    }

    public entry fun increase(counter: &mut Counter){
        counter.value = counter.value + 1;
    }

    public entry fun set_value(counter: &mut Counter, value: u64, ctx: &mut TxContext){
        assert!(counter.owner == tx_context::sender(ctx), 0);
        counter.value = value;
    }

    public entry fun assert_value(counter: &Counter, value: u64){
        assert!(counter.value == value, 0);
    }
}
