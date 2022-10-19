module web3lab::Resource {
    use std::debug;
    use std::vector;

    struct Item has store, copy {
        age: u64
    }

    struct UserStore has key, copy {
        items: vector<Item>
    }

    public fun init(account: &signer) {
        move_to<UserStore>(account, UserStore {
            items: vector::empty<Item>()
        });
        debug::print(&b"done init module!");
    }

    public fun getSize(account: address): u64 acquires UserStore{
        let store = borrow_global_mut<UserStore>(account);
        vector::length(&store.items)
    }

    public fun check(addr: &address): bool {
        exists<UserStore>(*addr)
    }

    public fun push(account: address, cap: u64): u64 acquires UserStore{
        let store = borrow_global_mut<UserStore>(account);
        let item = Item { age: cap};
        vector::push_back(&mut store.items, item);
        vector::length(&store.items)
    }
}
