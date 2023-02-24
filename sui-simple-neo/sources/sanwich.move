module sui_simple::sanwich {

    use sui::object::UID;
    use sui::balance::Balance;
    use sui::sui::{SUI, transfer};
    use sui::tx_context::TxContext;
    use sui::transfer;
    use sui::object;
    use sui::balance;
    use sui::tx_context;
    use sui::coin::Coin;
    use sui::coin;

    struct Ham has key {
        id: UID
    }

    struct Bread has key {
        id: UID
    }

    struct Sanwich has key {
        id: UID
    }

    struct GroceryOwnerCapbability has key {
        id: UID
    }

    struct Grocery has key {
        id: UID,
        profits: Balance<SUI>
    }

    const HAM_PRICE: u64 = 10;
    const BREAD_PRICE: u64 = 2;
    const EInsufficicientFunds: u64 = 0;
    const ENoProfits: u64 = 1;


    //constructor
    fun init(ctx: &mut TxContext) {
        transfer::share_object(Grocery {
            id: object::new(ctx),
            profits: balance::zero<SUI>()
        });

        transfer::transfer(GroceryOwnerCapbability {
            id: object::new(ctx)
        }, tx_context::sender(ctx));
    }

    public entry fun buy_ham(grocery: &mut Grocery, c: Coin<SUI>, ctx: &mut TxContext) {
        let b = coin::into_balance<SUI>(c);
        assert!(balance::value(&b) >= HAM_PRICE, EInsufficicientFunds);
        balance::join(&mut grocery.profits, b);
        transfer::transfer(Ham { id: object::new(ctx) }, tx_context::sender(ctx));
    }

    public entry fun buy_bread(grocery: &mut Grocery, c: Coin<SUI>, ctx: &mut TxContext) {
        let b = coin::into_balance<SUI>(c);
        assert!(balance::value(&b) >= BREAD_PRICE, EInsufficicientFunds);
        balance::join(&mut grocery.profits, b);
        transfer::transfer(Bread { id: object::new(ctx) }, tx_context::sender(ctx));
    }

    public entry fun make_sanwich(ham: Ham, bread: Bread, ctx: &mut TxContext) {
        let Ham { id: ham_id } = ham;
        let Bread { id: bread_id } = bread;
        object::delete(ham_id);
        object::delete(bread_id);
        transfer::transfer(Sanwich { id: object::new(ctx) }, tx_context::sender(ctx));
    }

    public fun profits(grocery: &Grocery): u64 {
        balance::value(&grocery.profits)
    }

    public entry fun collect_profits(_cap: &GroceryOwnerCapbability, grocery: &mut Grocery, ctx: &mut TxContext) {
        let amount = profits(grocery);
        assert!(amount > 0, ENoProfits);

        let coin = coin::take(&mut grocery.profits, amount, ctx);
        transfer(coin, tx_context::sender(ctx));
    }

    #[test_only]
    public fun init_for_testing(ctx: &mut TxContext) {
        init(ctx);
    }

}
