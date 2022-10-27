module web3lab::tut_struct03 {
    use web3lab::tut_struct;
    use web3lab::tut_struct::User;
    use std::debug;
    struct Cash {
        value: u128
    }

    struct Airplane { hight: u64, age: u128 }

    struct FreeWind has drop, copy {
        velocity: u128,
        dim: u128
    }

    public fun test_copy(){
        let ap1 = Airplane {hight: 100, age: 800};
        //copy lead to error
//        let ap2 = copy ap1;
        let ap1Ref = &ap1;
//        let ap3 = *ap1Ref; //copy not allowed

        //error due to resource not transfered.
//        let ap2 = Airplane {hight: 100, age: 800};
        //just debug
//        debug::print(&ap2.hight);

        //slot overwrite lead to destroy
        let ap1Ref2 = &mut ap1;

        //error: drop resource not allowed
//        *ap1Ref2 = Airplane { hight: 1000, age: 300};

        //just unpack struct, only in this module --> UNPACK!
        let Airplane{hight: h, age: _} = ap1;
        debug::print(&h);
    }

    public fun freeStyle(){
        let w1 = FreeWind{dim: 1024, velocity: 1025};
        let w2 = w1; //moved
        let w1Ref = &w1;//will be error
        debug::print(&w1Ref.velocity);
        debug::print(&w2.velocity);
    }
}