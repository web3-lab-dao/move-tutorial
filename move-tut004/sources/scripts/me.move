script {
    use std::debug;
    use MYADDR::MyModule;
    
    fun main(){
        let val: u8 = 10;
        debug::print<u8>(&val);

        let _ = MyModule::new_country(10, 250);

        let con = MyModule::new_country(10, 250);
        let id = MyModule::get_country_id(&con);
        let pop = MyModule::get_country_pop(&con);

        debug::print<u8>(&id);
        debug::print<u64>(&pop);
    }
}