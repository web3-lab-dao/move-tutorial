#[test_only]
module sui_simple::Color {
    use sui::object;
    use sui::tx_context;
    use sui_simple::color_object::{Self, ColorObject};

    #[test]
    fun test_color() {
        use sui::test_scenario;

        let owner = @0x1;
        let scanario_val = test_scenario::begin(owner);
        let scenario = &mut scanario_val;
        {
            let ctx = test_scenario::ctx(scenario);
            color_object::create(255, 0, 255, ctx);
        };
        let not_owner = @0x2;
        test_scenario::next_tx(scenario, not_owner);
        {
            assert!(!test_scenario::has_most_recent_for_sender<ColorObject>(scenario), 0);
        };

        test_scenario::next_tx(scenario, owner);
        {
            let color = test_scenario::take_from_sender<ColorObject>(scenario);
            let (red, green, blue) = color_object::get_color(&color);
            assert!(red == 255 && green == 0 && blue == 255, 0);
            test_scenario::return_to_sender(scenario, color);
        };
        test_scenario::end(scanario_val);
    }

    #[test]
    fun test_copy() {
        use sui::test_scenario;

        let owner = @0x1;
        let scenario_val = test_scenario::begin(owner);
        let scenario = &mut scenario_val;

        let (id1, id2) = {
            let ctx = test_scenario::ctx(scenario);
            color_object::create(255, 255, 255, ctx);
            let id1 = object::id_from_address(tx_context::last_created_object_id(ctx));

            color_object::create(0, 0, 0, ctx);
            let id2 = object::id_from_address(tx_context::last_created_object_id(ctx));

            (id1, id2)
        };

        test_scenario::next_tx(scenario, owner);
        {
            let obj1 = test_scenario::take_from_sender_by_id<ColorObject>(scenario, id1);
            let obj2 = test_scenario::take_from_sender_by_id<ColorObject>(scenario, id2);

            let (red, green, blue) = color_object::get_color(&obj1);
            assert!(red == 255 && blue == 255 && green == 255, 0);

            // let ctx = test_scenario::ctx(scenario);
            color_object::copy_info(&obj2, &mut obj1);
            test_scenario::return_to_sender(scenario, obj1);
            test_scenario::return_to_sender(scenario, obj2);
        };
        test_scenario::next_tx(scenario, owner);
        {
            let obj1 = test_scenario::take_from_sender_by_id<ColorObject>(scenario, id1);
            let (red, green, blue) = color_object::get_color(&obj1);
            assert!(red == 0 && green == 0 && blue == 0, 0);
            test_scenario::return_to_sender(scenario, obj1);
        };
        test_scenario::end(scenario_val);
    }


    #[test]
    fun test_delete() {
        use sui::test_scenario;

        let owner = @0x1;
        let scenario_val = test_scenario::begin(owner);
        let scenario = &mut scenario_val;

        {
            let ctx = test_scenario::ctx(scenario);
            color_object::create(255, 255, 0, ctx);
        };

        test_scenario::next_tx(scenario, owner);
        {
            let color = test_scenario::take_from_sender<ColorObject>(scenario);
            color_object::delete(color);
        };
        test_scenario::next_tx(scenario, owner);
        {
            assert!(!test_scenario::has_most_recent_for_sender<ColorObject>(scenario), 0);
        };
        test_scenario::end(scenario_val);
    }

    #[test]
    fun test_immutable() {
        use sui::test_scenario;

        let sender1 = @0x1;
        let scenario_val = test_scenario::begin(sender1);
        let scenario = &mut scenario_val;

        {
            let ctx = test_scenario::ctx(scenario);
            color_object::create_immutable(255, 255, 255, ctx);
        };

        test_scenario::next_tx(scenario, sender1);
        {
            assert!(!test_scenario::has_most_recent_for_sender<ColorObject>(scenario), 0);
        };

        let sender2 = @0x2;
        test_scenario::next_tx(scenario, sender2);
        {
            let color = test_scenario::take_immutable<ColorObject>(scenario);
            let (red, green, blue) = color_object::get_color(&color);
            assert!(red == 255 && blue == 255 && green == 255, 0);
            test_scenario::return_immutable(color);
        };
        test_scenario::end(scenario_val);
    }
}
