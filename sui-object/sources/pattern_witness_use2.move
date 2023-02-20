/// Module that defines a generic type `Guardian<T>` which can only be
/// instantiated with a witness.
module basic2::pattern_witness_use2 {
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use basic2::pattern_witness;
    /// This type is intended to be used only once.
    struct PEACE has drop {}
    /// Module initializer is the best way to ensure that the
    /// code is called only once. With `Witness` pattern it is
    /// often the best practice.
    fun init(ctx: &mut TxContext) {
        transfer::transfer(pattern_witness::create_guardian(PEACE {}, ctx), tx_context::sender(ctx)
        )
    }
}