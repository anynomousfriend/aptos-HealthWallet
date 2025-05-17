# Decentralized Health Wallet with Spending Rules

[![Deploy to Aptos](https://explorer.aptoslabs.com/favicon.ico)](https://explorer.aptoslabs.com/txn/0x5b379dced432a377b5cfd036762ae981eab139a8c36d29525f76ee88870d970f?network=devnet)

A Move smart contract for Aptos blockchain that implements a decentralized health wallet with controlled spending rules.

## Overview

This smart contract allows users to create dedicated health wallets with spending restrictions that ensure funds are only used for healthcare purposes. The wallet can only disburse funds to pre-authorized healthcare service providers, creating an effective mechanism for healthcare savings and spending control.

## Features

- **Dedicated Health Wallet**: Users can create a specialized wallet specifically for healthcare expenses.
- **Authorized Spending**: Funds can only be spent on pre-approved healthcare service providers.
- **Funding Mechanism**: Anyone can contribute funds to a user's health wallet.
- **Provider Management**: Wallet owners can add new authorized healthcare providers as needed.

## Smart Contract Structure

The contract consists of a single module (`HealthWallet::DecentralizedHealthWallet`) with four main functions:

1. `create_wallet`: Creates a new health wallet for the caller.
2. `fund_wallet`: Allows anyone to fund a user's health wallet.
3. `add_authorized_service`: Enables wallet owners to add authorized healthcare providers.
4. `spend_on_healthcare`: Processes payments to authorized healthcare providers.

## Usage Guide

### Creating a Health Wallet

```bash
aptos move run --function-id 0x<MODULE_ADDRESS>::DecentralizedHealthWallet::create_wallet
```

### Funding a Health Wallet

```bash
aptos move run --function-id 0x<MODULE_ADDRESS>::DecentralizedHealthWallet::fund_wallet \
  --args address:<WALLET_OWNER_ADDRESS> u64:<FUNDING_AMOUNT>
```

### Adding an Authorized Healthcare Provider

```bash
aptos move run --function-id 0x<MODULE_ADDRESS>::DecentralizedHealthWallet::add_authorized_service \
  --args address:<SERVICE_PROVIDER_ADDRESS>
```

### Spending Funds on Healthcare

```bash
aptos move run --function-id 0x<MODULE_ADDRESS>::DecentralizedHealthWallet::spend_on_healthcare \
  --args address:<SERVICE_PROVIDER_ADDRESS> u64:<PAYMENT_AMOUNT>
```

## Use Cases

- **Health Savings**: Create a dedicated wallet for healthcare savings with controlled spending.
- **Family Healthcare Management**: Parents can create wallets for children with restrictions on how funds are spent.
- **Corporate Health Benefits**: Companies can provide employee health benefits with spending controls.
- **Insurance Deductible Management**: Set aside funds specifically for insurance deductibles.
- **Managed Healthcare Disbursements**: Third parties can fund wallets for specific healthcare needs.

## Security Considerations

- Only the wallet owner can authorize new healthcare service providers.
- The contract enforces spending restrictions, ensuring funds can only go to authorized providers.
- Balance checks prevent overspending.

## Development and Testing

To compile the module:

```bash
aptos move compile --named-addresses HealthWallet=0x<YOUR_ADDRESS>
```

To test the module:

```bash
aptos move test --named-addresses HealthWallet=0x<YOUR_ADDRESS>
```

## License

[MIT License](LICENSE)

## Contributors

- [Your Name/Organization]

## Disclaimer

This smart contract is provided as-is without any guarantees. It has not been audited and should be thoroughly tested before being used in production.
