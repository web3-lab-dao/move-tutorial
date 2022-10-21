 #[test_only]
 module MYADDR::Test01 {    
    use MYADDR::MyModule;
    use std::debug;

    #[test]    
    public fun test_main(){        
        let val: u8 = 100;
        debug::print<u8>(&val);

        let con = MyModule::new_country(10, 250);
        let id = MyModule::get_country_id(&con);
        let pop = MyModule::get_country_pop(&con);

        debug::print(&id);
        debug::print<u64>(&pop);

        let _ = MyModule::create_box(34);        
        debug::print(&b"hello print text");
    }
 }