@echo off
echo "" > temp
echo /** > temp
echo  * @name QuickSCSS >> temp
echo  * @description yeah >> temp
echo  * @discord wYdxqw5gHB >> temp
echo  * @author walter >> temp
echo  * @version 2.8.2 >> temp
echo  */ >> temp
type QuickSCSS.theme.css >> temp
type temp > QuickSCSS.theme.css
del temp
