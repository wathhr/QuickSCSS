@echo off
echo "" > temp
echo /** > temp
echo  * @name QuickSCSS >> temp
echo  * @author walter >> temp
echo  * @description yeah >> temp
echo  * @version im not bothered updating a 3rd file lol >> temp
echo  */ >> temp
type QuickSCSS.theme.css >> temp
type temp > QuickSCSS.theme.css
del temp
