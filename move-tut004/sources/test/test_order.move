#[test_only]
module MYADDR::Test_Order{
    use std::debug;
    use MYADDR::OrderBook;

    #[test]
    fun main(){
        let order1 = OrderBook::genOrder();
        let order2 = OrderBook::genOrder();

        OrderBook::transfer(&mut order1, &mut order2);

        debug::print(&b"test done");
    }
}