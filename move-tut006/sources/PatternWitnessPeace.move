module web3lab::PatternWitnessPeace {
    use web3lab::PatternWitnessGuardian;
    use std::signer;

    //this struct inteded to be used only one in this module!
    struct FLAG has drop {}

    //make sure this function is called only one!
    //so flag is witness
    fun init(account: &signer){
        let flag = FLAG{};
        let resource = PatternWitnessGuardian::createResource(flag);
        PatternWitnessGuardian::store(account, resource);
    }
}
