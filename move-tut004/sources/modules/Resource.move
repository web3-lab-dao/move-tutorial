module MYADDR::Resource {
    use std::debug;
    use std::vector;
    use std::signer;        

    struct Item has store, drop {

    }

    struct Collection has key, store {
        items: vector<Item>
    }

    // navtive function move_to<T: key> (account: &signer, value: T)
    public fun start_colletion(account: &signer){
        debug::print(&b"start collection");
        move_to<Collection>(account, Collection{
            items: vector::empty<Item>()
        });
    }

    // navtive function exists<T: key>(addr: address): bool;
    public fun exists_at(addr: address): bool {
        exists<Collection>(addr)
    }

    public fun exists_at_imu(addr: &address): bool{
        exists<Collection>(*addr)
    }

    // native fun borrow_global<T: key>(addr: address): &T -> return imutable of T
    public fun size(account: &signer): u64 acquires Collection {
        let owner = signer::address_of(account);

        // have to check the exist resource, if not will got error
        if(exists_at(owner)){
            let collection = borrow_global<Collection>(owner);        
            vector::length(&collection.items)
        } else {
            debug::print(&owner);
            0
        }        
    }

    // test with borrow_global_mut -> get mutable resource from global store
    public fun add_item(account: &signer) acquires Collection {
        let owner = signer::address_of(account);

        // check exist resource
        if(exists_at(owner)){
            let collection = borrow_global_mut<Collection>(owner);
            vector::push_back(&mut collection.items, Item{});            
        } else {
            debug::print(&owner);
        }
    }

    // take and destroy resource
    // take let collection = move_from<Collection>(signer::address_of(account))
    // navtive fun move_from<T: Key>(addr: address): T
    // destroy let Collection {items: _} = collection
    public fun destroy(account: &signer) acquires Collection{
        let owner = signer::address_of(account);

        // check exist
        if( exists_at(owner)){
            let collection = move_from<Collection>(owner);
            let Collection{items: _} = collection;
        } else {
            debug::print(&owner);
        }
    }
}