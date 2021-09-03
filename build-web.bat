@echo off
echo /* ==UserStyle== > temp
echo @name QuickSCSS >> temp
echo @namespace QuickSCSS >> temp
echo @author walter >> temp
echo @version 2.8.3 >> temp
echo @license GNU GPLv3 >> tem
echo @preprocessor default >> temp
echo ==/UserStyle== */ >> temp
echo @-moz-document domain("discord.com") { >> temp
type QuickSCSS.user.css >> temp
type temp > QuickSCSS.user.css
echo } >> QuickSCSS.user.css
del temp
