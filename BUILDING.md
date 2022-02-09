# Building

Run the following commands

```powershell
PS> git clone https://github.com/wathhr/QuickSCSS --recurse-submodules -b main # Or whichever branch you want

PS> cd QuickSCSS

PS> npm i

PS> npm run build:bd                            # For a BetterDiscord build

PS> npm run build:web                           # For a web build

PS> npm run build:all                           # For all of the above (Default)
```

If nothing went wrong, this should output a file in [`./dist/`](./dist).
