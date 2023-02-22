module sui_simple::dynamic_field {
    use sui::object::UID;
    use sui::dynamic_object_field as ofileld;
    use sui::object;
    use sui::tx_context::TxContext;
    use sui::transfer;
    use sui::tx_context;

    struct Parent has key {
        id: UID
    }

    struct Child has key, store {
        id: UID,
        count: u64
    }

    public entry fun add_child(parent: &mut Parent, child: Child){
        ofileld::add(&mut parent.id, b"child", child);
    }

    public entry fun mutate_child(child: &mut Child){
        child.count = child.count + 1;
    }

    public fun mutate_child_via_parent(parent: &mut Parent){
        mutate_child(ofileld::borrow_mut<vector<u8>, Child>(
            &mut parent.id,
            b"child"
        ));
    }

    public fun delete_child(parent: &mut Parent){
        let Child{id, count: _} = ofileld::remove<vector<u8>, Child>(
            &mut parent.id,
            b"child"
        );
        object::delete(id);
    }

    public fun reclaim_child(parent: &mut Parent, ctx: &mut TxContext){
        let child = ofileld::remove<vector<u8>, Child>(
            &mut parent.id,
            b"child"
        );
        transfer::transfer(child, tx_context::sender(ctx));
    }
}