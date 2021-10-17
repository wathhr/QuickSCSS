@echo off

for /f "tokens=* usebackq" %%F in (`powershell -noprofile -c "[Console]::Title.Replace(' - %0','') -replace '(.+) - .+'"`) do set "initialTitle=%%F"
set "title=PowerCord Installer"
title %title%

echo This installer is not affiliated or endorsed by PowerCord.
echo.
powershell write-host -foregroundcolor Red ! WARNING !
echo Canceling the batch script using [CTRL + C] while on a question will set the answer as "Y".
pause

goto :winget

:winget
set "program=Winget"
call winget -v >nul 2>nul && (
  echo %program% was found, skipping.
) || (
  choice /c YN /m "%program% was not found, would you like to install it (Required)" %1
  if not errorlevel 2 (
    echo I do not want to go insane automating this, do it yourself.
    start https://github.com/microsoft/winget-cli/releases/latest
    pause
  ) else if errorlevel 1 (
    echo Exiting.
    goto :end
  )
)
goto :canary

:canary
set "program=Discord Canary"
if exist "%localappdata%\DiscordCanary\Update.exe" (
  echo %program% was found, skipping.
) else (
  choice /c YN /m "%program% was not found, would you like to install it (Required)" %1
   if not errorlevel 2 (
    call winget install --id Discord.DiscordCanary
  ) else if errorlevel 1 (
    echo Exiting.
    goto :end
  )
)
goto :git

:git
set "program=Git"
call git --version >nul 2>nul && (
  echo %program% was found, skipping.
) || (
  set "git=0"
  choice /c YN /m "%program% was not found, would you like to install it (Required)" %1
  if not errorlevel 2 (
    call winget install --id Git.Git
  ) else if errorlevel 1 (
    echo Exiting.
    goto :end
  )
)
goto :node

:node
set "program=NodeJS"
call node -v >nul 2>nul && (
  echo %program% was found, skipping.
) || (
  set "node=0"
  choice /c YN /m "%program% was not found, would you like to install it (Required)" %1
  if not errorlevel 2 (
    call winget install --id OpenJS.NodeJS.LTS
  ) else if errorlevel 1 (
    echo Exiting.
    goto :end
  )
)
goto :powercord

:powercord
set "program=PowerCord"
set "initialDirectory=%cd%"
cd %userprofile%

if exist "%userprofile%\powercord" (
  echo %program% was found, skipping.
) else (
  choice /c YN /m "%program% was not found, would you like to install it (Required)" %1
  if not errorlevel 2 (
    if "%git%"=="0" (
      call "%programfiles%\git\bin\git" clone https://github.com/powercord-org/powercord
    ) else (
      call git clone https://github.com/powercord-org/powercord
    )
    cd powercord
    call %localappdata%\DiscordCanary\Update.exe -processStart DiscordCanary.exe
    if "%node%"=="0" (
      call "%programfiles%\nodejs\npm" i
      call "%programfiles%\nodejs\npm" audit fix >nul
      call "%programfiles%\nodejs\node" injectors/index.js inject --no-exit-codes >nul
    ) else (
      call npm i
      call npm audit fix >nul
      call npm run inject >nul
    )
    echo Press any button when Discord Canary is done launching.
    pause >nul
    taskkill /f /im DiscordCanary.exe >nul
    call %localappdata%\DiscordCanary\Update.exe -processStart DiscordCanary.exe
  ) else if errorlevel 1 (
    echo Exiting.
    goto :end
  )
)
goto :finished

:finished
set "title=%title% - Finished"
title %title%
echo.
echo Finished.
pause >nul
goto :end

:end
cd %initialDirectory%
title %initialTitle%
