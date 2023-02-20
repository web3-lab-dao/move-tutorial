/// Module that defines a generic type `Guardian<T>` which can only be
/// instantiated with a witness.
module basic2::pattern_witness {
    use sui::object::{Self, UID};
    use sui::tx_context::TxContext;

    /// Phantom parameter T can only be initialized in the `create_guardian`
    /// function. But the types passed here must have `drop`.
    struct Guardian<phantom T: drop> has key, store {
        id: UID
    }

    /// The first argument of this function is an actual instance of the
    /// type T with `drop` ability. It is dropped as soon as received.
    public fun create_guardian<T: drop>(_witness: T, ctx: &mut TxContext): Guardian<T> {
        Guardian { id: object::new(ctx) }
    }
}
