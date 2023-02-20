module basic2::nfter{
    use sui::url::{Self, Url};
    use std::string;
    use sui::object::{Self, ID, UID};
    use sui::event;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use std::option::Option;
    use std::option;
    use sui::coin;

    /// An example NFT that can be minted by anybody
    struct Pokemon has key, store {
        id: UID,
        /// Name for the token
        name: string::String,
        /// Description of the token
        description: string::String,
        /// URL for the token
        url: Url,
        // TODO: allow custom attributes
        power: u64
    }

    // ===== Events =====

    struct NFTMinted has copy, drop {
        // The Object ID of the NFT
        object_id: ID,
        // The creator of the NFT
        creator: address,
        // The name of the NFT
        name: string::String,
    }

    // ===== Public view functions =====

    /// Get the NFT's `name`
    public fun name(nft: &Pokemon): &string::String {
        &nft.name
    }

    /// Get the NFT's `description`
    public fun description(nft: &Pokemon): &string::String {
        &nft.description
    }

    /// Get the NFT's `url`
    public fun url(nft: &Pokemon): &Url {
        &nft.url
    }

    // ===== Entrypoints =====

    /// Create a new devnet_nft
    public entry fun mint_to_sender(
        name: vector<u8>,
        description: vector<u8>,
        url: vector<u8>,
        ctx: &mut TxContext
    ) {
        let sender = tx_context::sender(ctx);
        let nft = Pokemon {
            id: object::new(ctx),
            name: string::utf8(name),
            description: string::utf8(description),
            url: url::new_unsafe_from_bytes(url),
            power: 1000
        };

        event::emit(NFTMinted {
            object_id: object::id(&nft),
            creator: sender,
            name: nft.name,
        });

        transfer::transfer(nft, sender);
    }

    /// Transfer `nft` to `recipient`
    public entry fun transfer(
        nft: Pokemon, recipient: address, _: &mut TxContext
    ) {
        transfer::transfer(nft, recipient)
    }

    /// Update the `description` of `nft` to `new_description`
    public entry fun update_description(
        nft: &mut Pokemon,
        new_description: vector<u8>,
        _: &mut TxContext
    ) {
        nft.description = string::utf8(new_description)
    }

    /// Permanently delete `nft`
    public entry fun burn(nft: Pokemon, _: &mut TxContext) {
        let Pokemon { id, name: _, description: _, url: _ , power: _} = nft;
        object::delete(id);
        coin::balance()
    }
}
