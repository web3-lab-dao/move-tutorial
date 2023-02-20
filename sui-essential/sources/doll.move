module basic2::doll {
    //use
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::object::UID;
    use sui::object;

    struct Doll has key, store {
        id: UID,
        score: u64
    }

    struct  Forge has key, store {
        id: UID,
        produced: u64
    }

    fun init(ctx: &mut TxContext){
        let genesis = Doll{
            id: object::new(ctx),
            score: 1000
        };

        let forge = Forge{
            id: object::new(ctx),
            produced: 1
        };

        transfer::transfer(genesis, tx_context::sender(ctx));
        transfer::transfer(forge, tx_context::sender(ctx));
    }

    public fun total_produced(forge: &mut Forge): u64{
        return forge.produced
    }

    entry fun mint_doll(score: u64, recepent: address, ctx: &mut TxContext){
        let doll = Doll{
            id: object::new(ctx),
            score
        };

        transfer::transfer(doll, recepent);
    }

    entry fun mint_doll2(score: u64, ctx: &mut TxContext){
        let doll = Doll{
            id: object::new(ctx),
            score
        };

        transfer::transfer(doll, tx_context::sender(ctx));
    }

    entry fun transfer_doll(doll: Doll, recepent: address, _ctx: &mut TxContext){
        transfer::transfer(doll, recepent);
    }

    #[test]
    public fun test_doll_create() {
        use sui::tx_context;

        // create a dummy TxContext for testing
        let ctx = tx_context::dummy();

        // create a doll
        let doll = Doll {
            id: object::new(&mut ctx),
            score: 1000
        };

        //consume resource
        let dummyAddr = @0xEFEF;
        transfer::transfer(doll, dummyAddr);
    }

    #[test]

    public fun test_init(){
        use sui::test_scenario;

        //admin ?
        let admin = @0xBABE;

        //init scenario
        let scenario = test_scenario::begin(admin);
        let scenario_mut = &mut scenario;

        //tx1
        {
            init(test_scenario::ctx(scenario_mut));
        };

        //tx2
        test_scenario::next_tx(scenario_mut, admin);

        {
            //helper to extract object. real ops: runtime verify & load object
            let forge = test_scenario::take_from_sender<Forge>(scenario_mut);
            assert!(total_produced(&mut forge) == 1, 1000);

            //according to asset safe rule!
            test_scenario::return_to_sender(scenario_mut, forge);
        };

        //end
        test_scenario::end(scenario);
    }
}
