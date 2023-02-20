module web3lab::Generic {
    use std::debug;

    struct Thing<T1, phantom T2> has copy {
        body: T1
    }

    struct Thing2<phantom  T1, phantom T2> has copy{
    }

    public fun print<T>(val: &T) {
        debug::print(val);
    }

    public fun tryPrint(){
        let t1 = Thing<u128, u128>{
            body: 10u128
        };

        let t2 = Thing2<u128, u128>{};

        //just use reference
        print(&t1);
        print(&t2);

        //make copy with dereference
        let t1Cpy = *(&t1);
        let t2Cpy = *(&t2);

        //unpack
        let Thing {body: _} = t1;
        let Thing2{} = t2;

        let Thing {body: _} = t1Cpy;
        let Thing2{} = t2Cpy;
    }
}
