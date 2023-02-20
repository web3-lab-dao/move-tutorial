module basic2::object_wrapping {
    use sui::object::UID;
    use std::option::Option;
    use sui::tx_context::TxContext;
    use sui::object;
    use std::option;
    use sui::transfer;
    use sui::tx_context;

    struct Sword has key, store {
        id: UID,
        strength: u8,
    }

    struct Shield has key, store {
        id: UID,
        armor: u8,
    }

    struct SimpleWarrior has key {
        id: UID,
        sword: Option<Sword>,
        shield: Option<Shield>,
    }

    //empty warrior
    public entry fun create_warrior(ctx: &mut TxContext) {
        let warrior = SimpleWarrior {
            id: object::new(ctx),
            sword: option::none(),
            shield: option::none(),
        };
        transfer::transfer(warrior, tx_context::sender(ctx))
    }

    //equip warrior with sword
    public entry fun equip_sword(warrior: &mut SimpleWarrior, sword: Sword, ctx: &mut TxContext) {
        if (option::is_some(&warrior.sword)) {
            let old_sword = option::extract(&mut warrior.sword);
            transfer::transfer(old_sword, tx_context::sender(ctx));
        };
        option::fill(&mut warrior.sword, sword);
    }

    //equip warrior with sword
    public entry fun equip_shield(warrior: &mut SimpleWarrior, shield: Shield, ctx: &mut TxContext) {
        if (option::is_some(&warrior.shield)) {
            let old_shield = option::extract(&mut warrior.shield);
            transfer::transfer(old_shield, tx_context::sender(ctx));
        };
        option::fill(&mut warrior.shield, shield);
    }
}
