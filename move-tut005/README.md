# Run example in Aptos

## Install Aptos

- Download the binary file https://github.com/aptos-labs/aptos-core/releases
- Extract to a folder
- Add to path file
- Test aptos -h


Example in macos
- Download and extract to the folder /Users/tuencns/.local/bin/aptos
- Add /Users/tuencns/.local/bin/aptos to profile file ~/.bash_profile 
```
export PATH="/Applications/CMake.app/Contents/bin":"/Users/tuencns/.local/bin":"/Users/tuencns/.local/bin/aptos":"$PATH"
. "$HOME/.cargo/env"
```

## Step run
```
./create_local_account.sh
./build.sh
./test.sh
./publish.sh
./interact.sh
```
  
 Refers:
 - https://aptos.dev/tutorials/first-move-module
