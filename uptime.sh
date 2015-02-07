#!/bin/sh
echo "Content-type: text/html"
echo ""
 
echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<link rel="SHORTCUT ICON" href="http://www.megacorp.com/favicon.ico">'
echo '<link rel="stylesheet" href="http://www.megacorp.com/style.css" type="text/css">'
 
export PATH="/bin:/usr/bin:/usr/ucb:/usr/opt/bin"
 
echo '<title>System Uptime</title>'
echo '</head>'
echo '<body>'
 
echo '<h3>'
hostname
echo '</h3>'
 
uptime
 
echo '</body>'
echo '</html>'
 
exit 0

