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

    /**
        using copyable resource: assigment meaning COPY
    **/
    struct Item2 has copy{
        age: u64
    }

    public fun testCopyResource(){
        //declare copy-able, undropable resource
        let r1 = Item2{
            age: 100u64
        };

        //make copy
        let r2 = r1;
        //copy again
        let r3 = r1;

        //update content
        r2.age = 200;
        r3.age = 300;

        //undropable resource: consume by unpacking
        let Item2{age: age1 } = r1;
        let Item2{age: age2 } = r2;
        let Item2{age: age3 } = r3;

        assert!(age1 != age2, 100);
        assert!(age3 != age2, 100);
    }

    /**
        using undropable resource: assigment meaning MOVE
    **/
    struct Item3 {
        age: u64
    }

    public fun testDropResource(){
        //declare undropable resource
        let r1 = Item3{
            age: 100u64
        };

        //make copy --> moved
        let r2 = r1;

        //can't be move again: r1 lost!
//        let r3 = r1; //error!

        //update content
        r2.age = 200;

        //resource must be consumed:
        // moved or unpack

        //unpack
//        let Item3{age: age1 } = r1; //error due to r1 moved: r1 lost!
//        let Item3{age: age2 } = r2;
//        assert!(200 == age2, 100);

        //or pass it to #fun

//        testDropResourcePrint(r2);

        //what happens if pass again ?
        testDropResourcePrintRef(&r2); // error due to moved!

        //must be consumed!
        testDropResourcePrint(r2);
    }

    //when passed: meaning moved!
    public fun testDropResourcePrint(x: Item3){
        debug::print(&x.age);

        //must consume: unpack or return or moved!
        let Item3{age: val} = x; //unpacked!
        debug::print(&val);
    }

    public fun testDropResourcePrintRef(x: &Item3){
        debug::print(&x.age);

        //must consume: unpack or return or moved!
        let Item3{age: val} = x; //unpacked!
    }

    struct Item4 has copy {
        age: u64
    }

    public fun testDropResourcePrintDefRef(x: &Item4){
        debug::print(&x.age);
        let y = *x; //derefrence must be used with copy!
        //must consume: unpack or return or moved!
        let Item4{age: val} = y; //unpacked!
    }
}
