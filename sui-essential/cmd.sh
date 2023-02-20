#!/bin/bash
#sui move build
#sui move test

##publish
#sui client publish --force --gas-budget 1000000

##trigger
export PACKAGE=0x9533503b36e61fe28f170e209084afca397fd0df
sui client call --gas-budget 1000 --package $PACKAGE --module "doll" --function "mint_doll2" --args 100
