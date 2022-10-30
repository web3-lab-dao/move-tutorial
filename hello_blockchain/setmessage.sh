#!/bin/bash
aptos move run --profile testnet2 --function-id 'testnet2::message::set_message' --args 'string:hello message again!'
