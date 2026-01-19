# Lux Network Snapshots

Daily snapshots for Lux blockchain networks with all native chains.

## Networks

| Network | ID | C-Chain ID | Description |
|---------|------|------------|-------------|
| mainnet | 1 | 96369 | Production network |
| testnet | 2 | 96368 | Test network |
| devnet | 12345 | 200201 | Development network |

## Included Chains

All snapshots include the complete multi-chain state:

| Chain | Purpose | VM |
|-------|---------|-----|
| **P-Chain** | Platform, staking, validators | PlatformVM |
| **X-Chain** | Asset exchange, UTXO transfers | ExchangeVM |
| **C-Chain** | EVM smart contracts, DeFi | EVM |
| **Q-Chain** | Post-quantum cryptography | QuantumVM |
| **A-Chain** | AI/ML workloads | AIVM |
| **B-Chain** | Cross-chain bridge | BridgeVM |
| **T-Chain** | Threshold FHE operations | ThresholdVM |
| **Z-Chain** | Zero-knowledge proofs | ZKVM |
| **G-Chain** | Graph/indexing | GraphVM |
| **K-Chain** | Key management | KeyVM |
| **D-Chain** | DEX (order book, perpetuals) | DexVM |

## Native Token

- **LUX** - Native gas token (6 decimals on P/X-Chain, 18 decimals on C-Chain)

## L1 Subnet Chains (Available)

Genesis configurations for additional L1 chains in [luxfi/genesis](https://github.com/luxfi/genesis):

| Chain | Chain ID | Purpose |
|-------|----------|---------|
| **SPC** | 36911 | Space Protocol governance |
| **ZOO** | 200200 | Zoo Labs research network |
| **HNZ** | 36963 | Hanzo AI utility chain |

Deploy with: `lux subnet deploy <name> --mainnet`

## Snapshot Format

Snapshots use zstd compression split into 99MB chunks (GitHub LFS):

```
<network>/
├── manifest.json              # Checksums and metadata
└── <name>.tar.zst.part*       # 99MB chunks
```

## Usage

### Download and Restore

```bash
# Clone with LFS
git clone https://github.com/luxfi/snapshots.git
cd snapshots

# Restore mainnet snapshot
cd mainnet
cat mainnet-2026-01-16.tar.zst.part* | zstd -d | tar xf - -C ~/.lux/snapshots/

# Start network from snapshot
lux network start --mainnet --snapshot-name mainnet-full-2026-01-16
```

### Verify Integrity

Each `manifest.json` contains SHA256 checksums:

```bash
sha256sum -c manifest.json
```

## RPC Endpoints (Local)

After starting from snapshot:

```
P-Chain:     http://localhost:9630/ext/bc/P
X-Chain:     http://localhost:9630/ext/bc/X
C-Chain:     http://localhost:9630/ext/bc/C/rpc
Q-Chain:     http://localhost:9630/ext/bc/Q/rpc
A-Chain:     http://localhost:9630/ext/bc/A/rpc
B-Chain:     http://localhost:9630/ext/bc/B/rpc
T-Chain:     http://localhost:9630/ext/bc/T/rpc
Z-Chain:     http://localhost:9630/ext/bc/Z/rpc
G-Chain:     http://localhost:9630/ext/bc/G/rpc
K-Chain:     http://localhost:9630/ext/bc/K/rpc
D-Chain:     http://localhost:9630/ext/bc/D/rpc
```

## Available Snapshots

| Snapshot | Network | Date | Size | Description |
|----------|---------|------|------|-------------|
| mainnet-2026-01-16 | mainnet | 2026-01-16 | ~755MB | Full mainnet state |
| testnet-2026-01-16 | testnet | 2026-01-16 | ~115MB | Full testnet state |
| pq-final | local | 2026-01-12 | ~12MB | Post-quantum test |

## CI/CD

Snapshots updated automatically via GitHub Actions from validator nodes.

## Related

- [luxfi/node](https://github.com/luxfi/node) - Node implementation
- [luxfi/genesis](https://github.com/luxfi/genesis) - Genesis configurations
- [luxfi/cli](https://github.com/luxfi/cli) - Command-line tools
