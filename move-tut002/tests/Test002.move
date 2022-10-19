#[test_only]
module web3lab::Test002 {
    use std::debug;
    use web3lab::OrderBook;

    #[test]
    fun case01() {
        let order1 = OrderBook::genOrder();
        let order2 = OrderBook::genOrder();
        OrderBook::transfer(&mut order1, &mut order2);
        debug::print(&b"hello rustling friends!");
    }
}
