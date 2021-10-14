:: Imagine Using JavaScript For Build Scripts Instead Of A Really Dumb Batch Script :joy: :joy: :joy: :joy: :joy:
@echo off
set version=3-beta

set build=%1
if [%1]==[] set build=pc
for /f "usebackq delims=" %%I in (`powershell "\"%build%\".toUpper()"`) do set "build=%%~I" & REM I Love Using PowerShell For Such Trivial Such As This Making My Scripts Unnecessarily Badly Performant

call sass index.scss:dist/temp.css --style=compressed --no-source-map -q
echo Compiled SCSS successfully.
cd dist

goto %build%

:pc
rename dist\temp.css dist.css 2>nul
goto :end

:bd
call npx postcss temp.css -u postcss-csso --no-map -o QuickSCSS.theme.css
echo /** > temp
echo  * @name QuickSCSS >> temp
echo  * @description yeah >> temp
echo  * @discord wYdxqw5gHB >> temp
echo  * @author walter >> temp
echo  * @version %version% >> temp
echo  */ >> temp
type QuickSCSS.theme.css >> temp
type temp > QuickSCSS.theme.css
goto :end

:web
call npx postcss temp.css -u postcss-unprefix autoprefixer postcss-csso --no-map -o QuickSCSS.user.css
echo /* ==UserStyle== > temp
echo @name QuickSCSS >> temp
echo @namespace QuickSCSS >> temp
echo @author walter >> temp
echo @version %version% >> temp
echo @license GNU GPLv3 >> temp
echo @preprocessor default >> temp
echo ==/UserStyle== */ >> temp
echo @-moz-document domain("discord.com") { >> temp
type QuickSCSS.user.css >> temp
type temp > QuickSCSS.user.css
type } > QuickSCSS.user.css
goto :end

:end
del temp 2>nul
del temp.css 2>nul
echo Compiled %build% successfully.
cd..
REM npm run clear
