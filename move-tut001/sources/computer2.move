module web3lab::computer2 {
    public fun fibo(a: u128, b: u128): u128{
        let sum = a + b;
        let sum = sum + 1024u128;
        sum
    }
}
