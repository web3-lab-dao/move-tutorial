module web3lab::PatternWitnessGuardian {
    ///this resource created only with createResouce, but the type must be dropable
    struct Resource<phantom T: drop> has key, store {
        val: u128
    }

    ///witness droped right after received!
    ///when we receive this witness: this function called only one because:
    /// - _witness created only in Peace module
    /// - _witness is dropable, unable to copy, and this params is not reference!
    public fun createResource<T: drop>(_witness: T): Resource<T>{
        Resource<T>{ val: 128u128}
    }

    ///only this module allowed to use Resouce
    public fun store<T: drop>(account: &signer, resource: Resource<T>){
        move_to(account, resource);
    }
}
