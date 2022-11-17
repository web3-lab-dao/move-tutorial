module tut007_events::Tut007Events {
    use aptos_framework::event::EventHandle;
    use aptos_framework::account;
    use aptos_framework::event;
    use std::signer;

    struct MessageEvent has copy, store, drop{
        bid: u64
    }
    struct MessageSwitch has key{
        transfer_event: EventHandle<MessageEvent>
    }

    public entry fun go(account: &signer) acquires MessageSwitch {
        move_to( account, MessageSwitch {
            transfer_event: account::new_event_handle<MessageEvent>(account),
        });
        fireEvent(signer::address_of(account));
    }

    public entry fun event(account: &signer) acquires MessageSwitch {
        fireEvent(signer::address_of(account));
    }

    fun fireEvent(account: address) acquires MessageSwitch {
        event::emit_event<MessageEvent>(&mut borrow_global_mut<MessageSwitch>(account).transfer_event, MessageEvent { bid: 1000});
    }
}
