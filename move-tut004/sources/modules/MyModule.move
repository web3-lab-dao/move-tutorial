module MYADDR::MyModule{        
    struct Country has drop{
        id: u8,
        population: u64
    }

    struct Box<T> has drop{
        value: T
    }

    struct Squard<phantom T> has drop{
        value: u64
    }

    public fun new_country(c_id: u8, c_population: u64): Country {
        let country = Country{
            id: c_id,
            population: c_population
        };
        country
    }

    public fun get_country_id(country: &Country): u8{
        country.id
    }

    public fun get_country_pop(country: &Country) : u64{
        country.population
    }    

    public fun create_box(value: u64) : Box<u64>{
        Box<u64>{ value }
    }    
}