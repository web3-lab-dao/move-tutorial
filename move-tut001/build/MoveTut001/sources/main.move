script {
    use std::debug;
    use web3lab::computer;
    use web3lab::computer2;
    use web3lab::tut_struct;
    use web3lab::tut_struct02;
    use web3lab::tut_struct::User;
    use web3lab::tut_struct02::Pilot;
    use web3lab::tut_struct03;

    fun main() {
        let sum = computer::fibo(256u128, 256u128);
        let sum2 = computer2::fibo(256u128, 256u128);
        debug::print(&sum);
        debug::print(&sum2);
        tut_struct::hello();
        tut_struct::ex_destroy();

        let pilot = tut_struct02::hello();
        tut_struct02::goodbye(pilot);

        tut_struct03::test_copy();
        tut_struct03::freeStyle();
    }
}
