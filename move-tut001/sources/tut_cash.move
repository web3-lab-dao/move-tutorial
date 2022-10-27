module web3lab::tut_cash {
    use web3lab::tut_struct;
    use web3lab::tut_struct::User;
    use std::debug;

    struct Cash {
        value: u128
    }

    //implement cash
    public fun mint(amt: u128): Cash {
        //mint coin
        //make sure to gate to prevent cash inflation, not unlimited
        assert!(amt <= 10^10, 0x42);
        Cash {value: amt}
    }

    public fun withdraw(from: &mut Cash, amount: u128): Cash {
        assert!(from.value >= amount, 0x001);
        from.value = from.value - amount;
        //create new resource
        //with sub amount
        Cash {value: amount}
    }

    public fun deposit(to: &mut Cash, from: Cash){
        //unpack from --> moved
        let Cash{value: val} = from;

        //then credit
        to.value = to.value + val;
    }

    public fun split(source: Cash, amt: u128) : (Cash, Cash) {
        let other = withdraw(&mut source, amt);
        (source, other)
    }

    public fun merge(source: Cash, from: Cash): Cash {
        deposit(&mut source, from);
        source
    }

    public fun destroy_zero(source: Cash){
        let Cash{value: v} = source;
        assert!(v == 0, 0x42)
    }

    public fun burn(source: Cash){
        //just unpack
        let Cash{ value: val} = source;
        debug::print(&val);
    }
}