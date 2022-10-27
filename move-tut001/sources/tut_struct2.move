module web3lab::tut_struct02 {
    use web3lab::tut_struct;
    use web3lab::tut_struct::User;
    use std::debug;

    struct Pilot has drop { x: u64, master: User }

    public fun hello(): Pilot{
        let pilot = Pilot {x: 128u64, master: tut_struct::makeUser()};
        debug::print(&pilot);
        pilot
    }

    public fun goodbye(x: Pilot) {
        debug::print(&x.master);
        let v = x.master; //moved
        debug::print(&v);
        debug::print(&x.master);
    }
}