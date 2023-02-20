module web3lab::tele {
    use std::debug;

    public fun hello(){
        debug::print(&b"hello!");
    }
}
