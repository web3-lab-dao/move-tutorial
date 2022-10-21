#[test_only]
module MYADDR::Test_Resource{
    use std::debug;
    use MYADDR::Resource as Res;

    #[test(sig1 = @0xAAFF, sig2 = @0xDDFF)]    
    fun main(sig1: signer, sig2: signer) {   
        use std::signer;     
        debug::print(&sig1);
        debug::print(&sig2);
        debug::print(&signer::address_of(&sig1));
        debug::print(&signer::address_of(&sig2));

        Res::start_colletion(&sig1);        

        // 1st
        debug::print(&Res::exists_at(signer::address_of(&sig1)));
        debug::print(&Res::exists_at(signer::address_of(&sig2)));

        // 2st
        let addr1 = signer::address_of(&sig1);
        let addr2 = signer::address_of(&sig2);

        debug::print(&Res::exists_at(addr1));
        debug::print(&Res::exists_at(addr2));

        debug::print(&addr1);

        debug::print(&Res::exists_at_imu(&addr1));
        debug::print(&Res::exists_at_imu(&addr2));

        debug::print(&addr2);

        // test size
        debug::print(&Res::size(&sig1));
        debug::print(&Res::size(&sig2)); // if not exist will meet error, need fix some on size function

        // test add item
        Res::add_item(&sig1);
        Res::add_item(&sig2);

        debug::print(&Res::size(&sig1));
        debug::print(&Res::size(&sig2));

        Res::add_item(&sig1);
        Res::add_item(&sig1);
        debug::print(&Res::size(&sig1));

        // test destroy resource
        Res::destroy(&sig1);
        Res::destroy(&sig2);
        debug::print(&Res::exists_at(addr1)); // it's removed the resource from global store
    }
}