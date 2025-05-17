module HealthWallet::DecentralizedHealthWallet {
    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;
    use std::vector;

    /// Error codes
    const E_NOT_AUTHORIZED: u64 = 1;
    const E_INSUFFICIENT_FUNDS: u64 = 2;
    const E_SERVICE_NOT_AUTHORIZED: u64 = 3;

    /// Struct representing a health wallet with spending rules
    struct HealthWallet has key, store {
        balance: u64,                  // Current balance in the wallet
        authorized_services: vector<address>,  // List of authorized healthcare service providers
    }

    /// Function to create a new health wallet
    public entry fun create_wallet(account: &signer) {
        let wallet = HealthWallet {
            balance: 0,
            authorized_services: vector::empty<address>(),
        };
        
        move_to(account, wallet);
    }

    /// Function to fund the health wallet
    public entry fun fund_wallet(
        funder: &signer, 
        wallet_owner: address, 
        amount: u64
    ) acquires HealthWallet {
        let wallet = borrow_global_mut<HealthWallet>(wallet_owner);
        
        // Transfer the funds from the funder to the wallet
        let funds = coin::withdraw<AptosCoin>(funder, amount);
        coin::deposit<AptosCoin>(wallet_owner, funds);
        
        // Update the wallet balance
        wallet.balance = wallet.balance + amount;
    }

    /// Function to add an authorized healthcare service provider
    public entry fun add_authorized_service(
        owner: &signer,
        service_provider: address
    ) acquires HealthWallet {
        let wallet = borrow_global_mut<HealthWallet>(signer::address_of(owner));
        
        // Add the service provider to the list of authorized services
        vector::push_back(&mut wallet.authorized_services, service_provider);
    }

    /// Function to spend funds on healthcare services
    public entry fun spend_on_healthcare(
        owner: &signer,
        service_provider: address,
        amount: u64
    ) acquires HealthWallet {
        let owner_addr = signer::address_of(owner);
        let wallet = borrow_global_mut<HealthWallet>(owner_addr);
        
        // Check if the wallet has sufficient funds
        assert!(wallet.balance >= amount, E_INSUFFICIENT_FUNDS);
        
        // Check if the service provider is authorized
        let is_authorized = vector::contains(&wallet.authorized_services, &service_provider);
        assert!(is_authorized, E_SERVICE_NOT_AUTHORIZED);
        
        // Update the wallet balance
        wallet.balance = wallet.balance - amount;
        
        // Transfer funds to the service provider
        let payment = coin::withdraw<AptosCoin>(owner, amount);
        coin::deposit<AptosCoin>(service_provider, payment);
    }
}
