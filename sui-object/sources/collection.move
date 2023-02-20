module basic2::collection {

    use std::string;
    use sui::tx_context::TxContext;
    use sui::table;
    use sui::transfer;
    use sui::tx_context;
    use sui::bag;

    struct Animal has store, drop {
        score: u64
    }

    struct Tree has store {
        score: u64
    }


    fun init(ctx: &mut TxContext){
        //create 2 animal
        let a1 = Animal {
            score: 100
        };

        let t1 = Tree {
            score: 100
        };

        let t2 = Tree {
            score: 100
        };

        let all = table::new<u64, Animal>(ctx);
        table::add(&mut all, 1, a1);
        transfer::transfer(all, tx_context::sender(ctx));

        let bag1 = bag::new(ctx);
        bag::add(&mut bag1, 10, t1);
        bag::add(&mut bag1, 11, t2);

        transfer::transfer(bag1, tx_context::sender(ctx))
    }
}
