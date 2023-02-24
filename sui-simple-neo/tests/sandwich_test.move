#[test_only]
module sui_simple::sandwich_test {

    use sui::test_scenario;
    use sui_simple::sanwich;
    use sui_simple::sanwich::{Grocery, Ham, Bread, GroceryOwnerCapbability};
    use sui::coin;
    use sui::sui::SUI;

    #[test]
    fun test_make_cake(){
        let owner = @0x1;
        let the_guy = @0x2;

        let scenario_val = test_scenario::begin(owner);
        let scenario = &mut scenario_val;

        test_scenario::next_tx(scenario, owner);
        {
          sanwich::init_for_testing(test_scenario::ctx(scenario));
        };

        test_scenario::next_tx(scenario, the_guy);
        {
            let grocery_val = test_scenario::take_shared<Grocery>(scenario);
            let grocery = &mut grocery_val;
            let ctx = test_scenario::ctx(scenario);

            sanwich::buy_ham(grocery, coin::mint_for_testing<SUI>(10, ctx), ctx);
            sanwich::buy_bread(grocery, coin::mint_for_testing<SUI>(2, ctx), ctx);

            test_scenario::return_shared(grocery_val);
        };

        test_scenario::next_tx(scenario, the_guy);
        {
            let ham = test_scenario::take_from_sender<Ham>(scenario);
            let bread = test_scenario::take_from_sender<Bread>(scenario);

            sanwich::make_sanwich(ham, bread, test_scenario::ctx(scenario));
        };

        test_scenario::next_tx(scenario, owner);
        {
            let grocery_val = test_scenario::take_shared<Grocery>(scenario);
            let grocery = &mut grocery_val;
            let cap = test_scenario::take_from_sender<GroceryOwnerCapbability>(scenario);
            assert!(sanwich::profits(grocery) == 12, 0);
            sanwich::collect_profits(&cap, grocery, test_scenario::ctx(scenario));
            assert!(sanwich::profits(grocery) == 0, 0);

            test_scenario::return_to_sender(scenario, cap);
            test_scenario::return_shared(grocery_val);
        };
        test_scenario::end(scenario_val);
    }
}
