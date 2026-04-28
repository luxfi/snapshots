RELEASE := snapshots-2026-04-28
BASE_URL := https://github.com/luxfi/snapshots/releases/download/$(RELEASE)
NETWORKS := mainnet testnet pq-final

.PHONY: all mainnet testnet pq-final verify clean

all: $(NETWORKS)

mainnet:
	@scripts/download-snapshot.sh mainnet

testnet:
	@scripts/download-snapshot.sh testnet

pq-final:
	@scripts/download-snapshot.sh pq-final

verify:
	@for n in $(NETWORKS); do \
	  scripts/download-snapshot.sh $$n; \
	done

clean:
	@rm -f mainnet/*.tar.zst.part* testnet/*.tar.zst.part* pq-final/*.tar.zst.part*
