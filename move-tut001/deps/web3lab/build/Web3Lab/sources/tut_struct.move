module web3lab::tut_struct {
    struct Star has copy{
        x: u64,
        y: u64
    }

    struct Space {
        mom: Star,
        dad: Star,
        son: Star
    }

    struct User has copy, drop {
        age: u128,
        mass: u128
    }

    struct Profile has copy, drop {
        user: User
    }



    use std::debug;

    public fun makeUser(): User {
        User {age: 100, mass: 200}
    }

    public fun hello(){
        debug::print(&b"hello destroyer!")
    }

    //be aware of move|copy action
    //be aware of atribute has: drop | copy | store
    public fun ex_destroy(){
        //declare un-drop, un-copy
        let sun = Star { x: 1000, y: 2000};

        //try to make reference before moved
        let sunRef = &sun;

        //this assigment meaning : copy reference
        //now we have 2 ref to 2 fields
        let Star { x: xdistance, y: ydistance } = sunRef;
        debug::print(xdistance);
        debug::print(ydistance);

        debug::print(&sunRef.x); //make use of struct reference
        debug::print(&sunRef.y); //make use of struct reference

        //borrow struct field ref before it moved
        let borrowX = &mut sun.x;
        //then modify via ...
        *borrowX = 100;

        //move to sun2
        let sun2 = sun; //sun moved to sun2

        //if use sun, it will be error: origin moved
//        let tmp1 = sun.x;
//        let tmp2 = sun.y;

        //but with sun2 is okay
        let tmp3 = sun2.x;

        //if return here: error because sun2 still exist --> undrop resource!
//        return;

        //sun2 moved to dropable fields!
        let Star { x: distance3, y: _ } = sun2;
        debug::print(&distance3);

        /**
        2. borrow
        **/
        let planet1 = Star{x: 100, y: 200};
        let solar = Space{dad: copy planet1, mom: copy planet1, son: copy planet1};

        //transfer
        let Star{x: distance4, y: _} = planet1; //planet 1 moved to dropable ...
        let Space{dad: Star {x: distance6, y: _}, mom: Star {x: distance7, y: _}, son: Star {x: distance5, y: _}} = solar; //moved to nowhere

        debug::print(&distance5);

        //copy of resource

        let user1 = User {age: 20, mass: 80};

        let user2 = copy user1;

        //then update field to prove that: object is trully copied!
        user1.age = 30;
        user2.age = 40;

        debug::print(&user1.age);
        debug::print(&user2.age);

        //check referencial transparency violation
        let user1Ref = &mut user1;
//        let user1Ref2 = &mut user1;
        debug::print(&user1Ref.age);
        debug::print(&user1.age);

        //chain access with primitive vs struct
        let profile1 = Profile{ user: User{age: 100, mass: 100}};

        let age = profile1.user.age;

        //make a copy by dereference!
        let user = *&profile1.user;

        debug::print(&user.age);


        //wrapper


    }
}
