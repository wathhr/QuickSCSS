:: Imagine Using JavaScript For Build Scripts Instead Of A Really Dumb Batch Script :joy: :joy: :joy: :joy: :joy:
@echo off
set "version=3-beta"

call sass index.scss:dist/temp.css --style=compressed --no-source-map -q
if [%1]==[] rename dist\temp.css dist.css 2>nul
echo Compiled SCSS successfully.
cd dist
if [%1]==[] goto :end

goto %1 || cd..

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
echo } >> QuickSCSS.user.css
goto :end

:end
del temp 2>nul
del temp.css 2>nul
if not [%1]==[] echo Compiled %1 successfully.
cd..
REM npm run clear
