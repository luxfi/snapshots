# Lux Network Snapshots

Daily incremental snapshots for Lux blockchain networks.

## Networks

| Network | ID | C-Chain ID | Description |
|---------|-----|------------|-------------|
| mainnet | 1 | 96369 | Production network |
| testnet | 2 | 96368 | Test network |
| devnet | 12345 | 200201 | Development network |

## Format

Snapshots use zstd compression chunked at 99MB (GitHub file size limit) with `manifest.json` for SHA256 checksums.

```
<network>/
├── manifest.json        # Checksums and metadata
└── <network>.tar.zst.partXX  # 99MB chunks
```

## Usage

### Download and restore
```bash
# Download all chunks
gh release download <tag> -p "mainnet/*" -D mainnet/

# Verify and reassemble
cd mainnet
cat *.part?? > mainnet.tar.zst
zstd -d mainnet.tar.zst
tar xf mainnet.tar

# Or use CLI
lux network snapshot load mainnet-2026-01-16
```

## CI/CD

Updated daily via GitHub Actions syncing from running nodes.
