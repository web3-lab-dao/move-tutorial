#[test_only]
module sui_simple::wrapper_test {

    // use sui_simple::trust_swap;
    // use sui::object;
    // use sui::test_scenario::ctx;
    // use sui_simple::trust_swap::Object;

    // #[test]
    // fun test_request_swap(){
    //     use sui::test_scenario;
    //
    //     let owner = @0x1;
    //     let scenario_val = test_scenario::begin(owner);
    //     let scenario = &mut scenario_val;
    //
    //     {
    //         let ctx = test_scenario::ctx(scenario);
    //         let object = trust_swap::create_object(1 ,1 , ctx);
    //     };
    //
    //     let service_address = @0xCAFE;
    //     test_scenario::next_tx(scenario, owner);
    //     {
    //         let object = test_scenario::take_from_sender<Object>(scenario);
    //         trust_swap::request_swap(object, "", service_address, ctx);
    //     };
    // }
}
