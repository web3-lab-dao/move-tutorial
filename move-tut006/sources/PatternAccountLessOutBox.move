module web3lab::PatternAccountLessOutBox {
    use std::signer;
    use std::vector;

    /// outbox item
    struct Item<Content: key + store> has key, store {
        from: address,
        to: address,
        content: Content
    }

    ///outbox
    struct Outbox<Content: key + store> has key, store {
        content: vector<Item<Content>>
    }

    ///create outbox
    public fun create<Content: key + store>(account: &signer) {
        move_to<Outbox<Content>>(account, Outbox<Content> { content: vector::empty<Item<Content>>() });
    }

    ///put new content to outbox
    public fun put<Content: key + store>(account: &signer, from: address, to: address, content: Content) acquires  Outbox {
        let outbox_owner = signer::address_of(account);
        let outbox = borrow_global_mut<Outbox<Content>>(outbox_owner);
        assert!(to != @0x0, 123);
        vector::push_back<Item<Content>>(&mut outbox.content, Item<Content>{ from, to, content });
    }

    //get item in mail box
    public fun get<Content: key + store>(account: &signer, outbox_owner: address, index: u64): Content acquires Outbox {
        let account_addr = signer::address_of(account);
        let outbox = borrow_global_mut<Outbox<Content>>(outbox_owner);
        let Item<Content>{from, to, content} = vector::swap_remove<Item<Content>>(&mut outbox.content, index);
        assert!(from == account_addr || to == account_addr, 123);
        content
    }
}
