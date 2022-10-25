# Run example in Aptos

## Install Aptos

- Download the binary file https://github.com/aptos-labs/aptos-core/releases
- Extract to a folder
- Add to path file
- Test aptos -h


Example in macos
- Download and extract to the folder $HOME/.local/bin/aptos
- Add $HOME/.local/bin/aptos to profile file ~/.bash_profile 
```
export PATH="/Applications/CMake.app/Contents/bin":"$HOME/.local/bin":"$HOME/.local/bin/aptos":"$PATH"
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
