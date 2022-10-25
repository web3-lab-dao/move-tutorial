module web3lab::PatternNestedResource {
    use std::signer;

    /// Owner with content
    struct NestedResource<Content> has key, store {
        owner: address,
        content: Content
    }

    /// Build content with owner
    public fun build<Content>(owner: address, content: Content): NestedResource<Content> {
        NestedResource<Content> { owner, content }
    }

    /// Return immutatble refrence to the resouce
    public fun read<Content>(resouce: &NestedResource<Content>): (&address, &Content) {
        let NestedResource<Content> { owner, content} = resouce;
        (owner, content)
    }

    /// Extract resource only if owner!
    public fun extract<Content>(account: &signer, resource: NestedResource<Content>): Content {
        let NestedResource<Content> {owner, content} = resource;
        assert!(signer::address_of(account) == owner, 1000);
        content
    }
}
