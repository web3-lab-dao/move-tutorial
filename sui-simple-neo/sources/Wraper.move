module sui_simple::trust_swap {
    use sui::object::UID;
    use sui::tx_context::TxContext;
    use sui::object;
    use sui::transfer;
    use sui::tx_context;
    use sui::balance::Balance;
    use sui::sui::SUI;
    use sui::coin::{Coin};
    use sui::coin;
    use sui::balance;

    const MIN_FEE: u64 = 1;

    struct Foo has key {
        id: UID,
        bar: Bar
    }

    struct Bar has store {
        id: UID,
        value: u64
    }

    struct Object has key, store {
        id: UID,
        scarcity: u8,
        style: u8
    }

    struct ObjectWraper has key {
        id: UID,
        original_owner: address,
        to_swap: Object,
        fee: Balance<SUI>
    }

    public entry fun create_object(scarcity: u8, style: u8, ctx: &mut TxContext){
        let object = Object{
            id: object::new(ctx),
            scarcity,
            style
        };
        transfer::transfer(object, tx_context::sender(ctx));
    }

    public entry fun transfer_object(object: Object, recipient: address){
        transfer::transfer(object, recipient);
    }

    public entry fun request_swap(object: Object, fee: Coin<SUI>, service_addresas: address, ctx: &mut TxContext){
        assert!(coin::value(&fee) >= MIN_FEE, 0);
        let wrapper = ObjectWraper{
            id: object::new(ctx),
            original_owner: tx_context::sender(ctx),
            to_swap: object,
            fee: coin::into_balance(fee)
        };
        transfer::transfer(wrapper, service_addresas);
    }

    public entry fun execute_swap(wrapper1: ObjectWraper, wrapper2: ObjectWraper, ctx: &mut TxContext){
        assert!(wrapper1.to_swap.scarcity == wrapper2.to_swap.scarcity, 0);
        assert!(wrapper1.to_swap.style != wrapper2.to_swap.style, 0);

        let ObjectWraper{
            id: id1,
            original_owner: original_owner1,
            to_swap: object1,
            fee: fee1
        } = wrapper1;

        let ObjectWraper{
            id: id2,
            original_owner: original_owner2,
            to_swap: object2,
            fee: fee2
        } = wrapper2;

        transfer::transfer(object1, original_owner2);
        transfer::transfer(object2, original_owner1);

        let service_address = tx_context::sender(ctx);
        balance::join(&mut fee1, fee2);
        transfer::transfer(coin::from_balance(fee1, ctx), service_address);

        object::delete(id1);
        object::delete(id2);
    }
}
