module counter::counter {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    /// A counter object that can be incremented and read
    struct Counter has key {
        id: UID,
        value: u64,
    }

    /// Create a new counter with initial value 0
    public fun create(ctx: &mut TxContext) {
        let counter = Counter {
            id: object::new(ctx),
            value: 0,
        };
        transfer::share_object(counter);
    }

    /// Increment the counter by 1
    public entry fun increment(counter: &mut Counter) {
        counter.value = counter.value + 1;
    }

    /// Get the current value of the counter
    public fun value(counter: &Counter): u64 {
        counter.value
    }
} 