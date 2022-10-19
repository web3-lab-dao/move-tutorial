script {
    use web3lab::tut_cash;
    use std::debug;
    fun cash() {
        //mint cash
        let genesis = tut_cash::mint(10^7);
        let userCash1 = tut_cash::mint(0);
        let userCash2 = tut_cash::mint(0);
        debug::print(&genesis);

        //then split
        let (sub1, sub2) = tut_cash::split(genesis, 10^6);
        debug::print(&sub1);
        debug::print(&sub2);

        tut_cash::deposit(&mut userCash1, sub1);
        tut_cash::deposit(&mut userCash2, sub2);

        tut_cash::burn(userCash1);
        tut_cash::burn(userCash2);
    }
}
