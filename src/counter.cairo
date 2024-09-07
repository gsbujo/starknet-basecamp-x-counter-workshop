#[starknet::interface]
pub trait ICounter<TContractState> {
    fn get_counter(self: @TContractState) -> u32;
    fn increase_counter(ref self: TContractState);
}


#[starknet::contract]
pub mod counter_contract {
    use starknet::event::EventEmitter;
    use workshop::counter::ICounter;
    use starknet::ContractAddress;
    use kill_switch::{IKillSwitchDispatcher, IKillSwitchDispatcherTrait};

    #[storage]
    struct Storage {
        counter: u32,
        kill_switch: ContractAddress,
    }

    #[constructor]
    fn constructor(ref self: ContractState, initial_value: u32, kill_switch: ContractAddress) {
        self.counter.write(initial_value);
        self.kill_switch.write(kill_switch);
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        CounterIncreased: CounterIncreased,
    }

    #[derive(Drop, starknet::Event)]
    struct CounterIncreased {
        value: u32,
    }
    
    #[abi(embed_v0)]
    impl CounterImpl of ICounter<ContractState>{
        fn get_counter(self: @ContractState) -> u32 {
            self.counter.read()
        }
        fn increase_counter(ref self: ContractState) {
            let kill_switch_dispatcher = IKillSwitchDispatcher { contract_address: self.kill_switch.read() };
            // Protect the increase_counter() function by reverting the transaction if KillSwitch mechanism is enabled.
            // We want to assert that is_active returns false.
            assert!(!kill_switch_dispatcher.is_active(), "Kill Switch is active");

            self.counter.write(self.get_counter() + 1);
            self.emit(CounterIncreased {value: self.get_counter()});
        }
    }
}

