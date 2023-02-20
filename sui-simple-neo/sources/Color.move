module sui_simple::color_object {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    struct Color {
        red: u8,
        green: u8,
        blue: u8
    }

    struct ColorObject has key {
        id: UID,
        red: u8,
        green: u8,
        blue: u8
    }

    fun new(red: u8, green: u8, blue: u8, ctx: &mut TxContext): ColorObject {
        ColorObject {
            id: object::new(ctx),
            red,
            green,
            blue
        }
    }

    public entry fun create(red: u8, green: u8, blue: u8, ctx: &mut TxContext) {
        let color = new(red, green, blue, ctx);
        transfer::transfer(color, tx_context::sender(ctx));
    }

    public fun get_color(selft: &ColorObject): (u8, u8, u8) {
        (selft.red, selft.green, selft.blue)
    }

    public entry fun copy_info(from: &ColorObject, into: &mut ColorObject) {
        into.red = from.red;
        into.blue = from.blue;
        into.green = from.green;
    }

    public entry fun delete(color: ColorObject) {
        let ColorObject { id, red: _, green: _, blue: _ } = color;
        object::delete(id);
    }

    public entry fun freeze_color(color: ColorObject) {
        transfer::freeze_object(color);
    }

    public entry fun create_immutable(red: u8, green: u8, blue: u8, ctx: &mut TxContext) {
        let color = new(red, green, blue, ctx);
        transfer::freeze_object(color);
    }

    public entry fun update(color: &mut ColorObject, red: u8, green: u8, blue: u8) {
        color.red = red;
        color.green = green;
        color.blue = blue;
    }
}