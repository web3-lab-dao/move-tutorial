#[test_only]
module sui_simple::counter_test {

    use sui::test_scenario;
    use sui_simple::counter;

    #[test]
    fun test_counter(){
        let owner = @0xC0FFEE;
        let user1 = @0x1;

        let scenario_val = test_scenario::begin(user1);
        let scenario = &mut scenario_val;

        test_scenario::next_tx(scenario, owner);
        {
            counter::create(test_scenario::ctx(scenario))
        };

        test_scenario::next_tx(scenario, user1);
        {
            let counter_val = test_scenario::take_shared<counter::Counter>(scenario);
            let counter = &mut counter_val;

            assert!(counter::owner(counter) == owner, 0);
            assert!(counter::value(counter) == 0, 1);

            counter::increase(counter);
            counter::increase(counter);
            counter::increase(counter);

            test_scenario::return_shared(counter_val);
        };

        test_scenario::next_tx(scenario, owner);
        {
            let counter_val = test_scenario::take_shared<counter::Counter>(scenario);
            let counter = &mut counter_val;

            assert!(counter::owner(counter) == owner, 0);
            assert!(counter::value(counter) == 3, 1);

            counter::set_value(counter, 100, test_scenario::ctx(scenario));
            test_scenario::return_shared(counter_val);
        };

        test_scenario::next_tx(scenario, user1);
        {
            let counter_val = test_scenario::take_shared<counter::Counter>(scenario);
            let counter = &mut counter_val;

            assert!(counter::owner(counter) == owner, 0);
            assert!(counter::value(counter) == 100, 1);

            counter::increase(counter);

            assert!(counter::value(counter) == 101, 2);

            test_scenario::return_shared(counter_val);
        };
        test_scenario::end(scenario_val);
    }
}
