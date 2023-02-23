#!/bin/bash
CONTRACT='0x4247110ad8a97ee048756065975e592732ab746af2a757f285a9966da381d90b'
ACCOUNT='0x78e22e000988664b454111b59c80945f12e096892953a1b57f514854906bc1c2'
PROFILE="testnet3"

aptos move run --profile "$PROFILE" --function-id "$CONTRACT::Tut007Events::go"
aptos move run --profile "$PROFILE" --function-id "$CONTRACT::Tut007Events::event"

curl "https://fullnode.testnet.aptoslabs.com/v1/accounts/$ACCOUNT/events/$CONTRACT::Tut007Events::MessageSwitch/transfer_event"