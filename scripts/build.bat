:: Imagine Using JavaScript For Build Scripts Instead Of A Really Dumb Batch Script :joy: :joy: :joy: :joy: :joy:
@echo off
setlocal
set version=3-beta

if not [%1]==[] (
  set build=%1
) else (
  set build=all
)
mkdir dist 2>nul
cd dist
set build=%build:"=%
goto :build

:scss
call sass ../index.scss:dist.css --style=compressed --no-source-map -q && (
  echo Compiled SCSS successfully.
) || (
  goto :eof
)
call npx postcss dist.css -u postcss-csso --no-map -r
goto :eof

:build-pc
set build=PC
goto :eof

:build-bd
set build=BD
copy dist.css QuickSCSS.theme.css >nul
>> temp echo /**
>> temp echo  * @name QuickSCSS
>> temp echo  * @description yeah
>> temp echo  * @discord wYdxqw5gHB
>> temp echo  * @author walter
>> temp echo  * @version %version%
>> temp echo  */
>> temp type QuickSCSS.theme.css
>  QuickSCSS.theme.css type temp
del temp 2>nul
goto :eof

:build-web
set build=Web
call npx postcss dist.css -u autoprefixer --no-map -o QuickSCSS.user.css
if errorlevel 1 goto :fuck
>> temp echo /* ==UserStyle==
>> temp echo @name QuickSCSS
>> temp echo @namespace QuickSCSS
>> temp echo @author walter
>> temp echo @version %version%
>> temp echo @license GNU GPLv3
>> temp echo @preprocessor default
>> temp echo ==/UserStyle== */
>> temp echo @-moz-document regexp("https?:\/\/.*discord\.com\/(?!developers|app).*\S") {
>> temp type QuickSCSS.user.css
>  QuickSCSS.user.css type temp
>> QuickSCSS.user.css echo }
del temp 2>nul
goto :eof

:build-all
call :build-bd && call :success
call :build-web && call :success
set build=All
goto :end

:build
call :scss
if errorlevel 1 goto :fuck
call :build-%build%
if errorlevel 1 goto :fuck
call :success
goto :end

:end
cd ..
goto :eof

:success
echo Built %build% successfully.
goto :eof

:fuck
echo Failed to build %build%.
goto :end
