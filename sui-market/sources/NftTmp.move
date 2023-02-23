module sui_poc::nft_tmp {
    use sui::url::{Self, Url};
    use sui::object::{Self, ID, UID};
    use sui::event;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    const  ERR_ONLY_OWNER: u64 = 401;

    struct TempNFT has key, store {
        id: UID,
        url: Url,
        nft_id: u64
    }

    // ===== Events =====

    struct NFTMinted has copy, drop {
        object_id: ID,
        creator: address,
        url: Url,
        nft_id: u64
    }

    // ===== Public view functions =====

    /// Get the NFT's `url`
    public fun url(nft: &TempNFT): &Url {
        &nft.url
    }

    // ===== Entrypoints =====

    /// Create a new seapad avatar nft
    public entry fun mint_to_sender(
        url: vector<u8>,
        nft_id: u64,
        ctx: &mut TxContext
    ) {
        let sender = tx_context::sender(ctx);

        let nft = TempNFT {
            id: object::new(ctx),
            url: url::new_unsafe_from_bytes(url),
            nft_id: nft_id
        };

        event::emit(NFTMinted {
            object_id: object::id(&nft),
            creator: sender,
            url: nft.url,
            nft_id: nft.nft_id
        });

        transfer::transfer(nft, sender);
    }

    /// Transfer `nft` to `recipient`
    public entry fun transfer(
        nft: TempNFT, recipient: address, _: &mut TxContext
    ) {
        transfer::transfer(nft, recipient)
    }

    /// Permanently delete `nft`
    public entry fun burn(nft: TempNFT, _: &mut TxContext) {
        let TempNFT { id, url: _, nft_id: _ } = nft;
        object::delete(id)
    }
}