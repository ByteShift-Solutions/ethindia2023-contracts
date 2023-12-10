source .env
forge script script/Aave.sol --broadcast --rpc-url $1 --private-key $PRIVATE_KEY --legacy
forge script script/Core.sol --broadcast --rpc-url $1 --private-key $PRIVATE_KEY --legacy
forge script script/Connector.sol --broadcast --rpc-url $1 --private-key $PRIVATE_KEY --legacy
forge script script/Uniswap.sol --broadcast --rpc-url $1 --private-key $PRIVATE_KEY --legacy
