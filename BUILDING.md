## Building

just run the commands below

```powershell
PS> git clone https://github.com/wathhr/QuickSCSS --recurse-submodules

PS> cd QuickSCSS

PS> npm i

PS> .\build pc                             # for a PowerCord build (Default)

PS> .\build bd                             # for a BetterDiscord build

PS> .\build web                            # for a web build
```

that should output a file in ``./dist/``
