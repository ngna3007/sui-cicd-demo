#[test_only]
module counter::counter_tests {
    use sui::test_scenario;
    use counter::counter::{Self, Counter};

    #[test]
    fun test_counter_create() {
        let owner = @0xA;
        let scenario_val = test_scenario::begin(owner);
        let scenario = &mut scenario_val;
        
        test_scenario::next_tx(scenario, owner);
        {
            counter::create(test_scenario::ctx(scenario));
        };

        test_scenario::next_tx(scenario, owner);
        {
            let counter_val = test_scenario::take_shared<Counter>(scenario);
            let counter = &counter_val;
            assert!(counter::value(counter) == 0, 0);
            test_scenario::return_shared(counter_val);
        };
        
        test_scenario::end(scenario_val);
    }

    #[test]
    fun test_counter_increment() {
        let owner = @0xA;
        let scenario_val = test_scenario::begin(owner);
        let scenario = &mut scenario_val;
        
        test_scenario::next_tx(scenario, owner);
        {
            counter::create(test_scenario::ctx(scenario));
        };

        test_scenario::next_tx(scenario, owner);
        {
            let counter_val = test_scenario::take_shared<Counter>(scenario);
            let counter = &mut counter_val;
            counter::increment(counter);
            assert!(counter::value(counter) == 1, 0);
            test_scenario::return_shared(counter_val);
        };
        
        test_scenario::end(scenario_val);
    }
} 