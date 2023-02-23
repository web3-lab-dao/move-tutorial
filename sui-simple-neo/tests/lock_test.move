#[test_only]
module sui_simple::lock_test {
    use sui::object::{Self, UID};
    use sui::test_scenario;
    use sui::transfer;
    use sui_simple::lock;

    struct Treasure has key, store {
        id: UID
    }
    #[test]
    fun test_lock(){
        let user1 = @0x1;
        let user2 = @0x2;

        let scenario_val = test_scenario::begin(user1);
        let scenario = &mut scenario_val;

        test_scenario::next_tx(scenario, user1);
        {
            let ctx = test_scenario::ctx(scenario);
            let id = object::new(ctx);

            lock::create(Treasure{id}, ctx);
        };

        test_scenario::next_tx(scenario, user1);
        {
            let key = test_scenario::take_from_sender<lock::Key<Treasure>>(scenario);

            transfer::transfer(key, user2);
        };

        test_scenario::next_tx(scenario, user2);
        {
            let lock_val = test_scenario::take_shared<lock::Lock<Treasure>>(scenario);
            let lock = &mut lock_val;
            let key = test_scenario::take_from_sender<lock::Key<Treasure>>(scenario);
            let ctx = test_scenario::ctx(scenario);

            lock::take<Treasure>(lock, &key, ctx);

            test_scenario::return_shared(lock_val);
            test_scenario::return_to_sender(scenario, key);
        };

        test_scenario::end(scenario_val);

    }
}
