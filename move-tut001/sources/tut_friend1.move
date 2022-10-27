module web3lab::tut_friend1 {
    use std::debug;

    friend web3lab::tut_friend2;

    public fun hello1(){
        debug::print(&b"hello boy!");
    }
}

module web3lab::tut_friend2 {
    use std::debug;
    use web3lab::tut_friend1;

    public fun hello2(){
        tut_friend1::hello1();
    }
}
