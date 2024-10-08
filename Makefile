deploy: ;
	source .env && \
	export FOUNDRY_PROFILE=deploy && \
	forge script script/DeployFactory.s.sol \
		--rpc-url $${RPC_URL} \
		--private-key $${PRIVATE_KEY} \
		--broadcast
