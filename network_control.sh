#!/bin/sh

export PATH=/jffs/bin:$PATH
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<meta name="viewport" content="width=device-width, initial-scale=1">'
echo '<title>Network Control</title>'
echo '</head>'
echo '<body>'

  echo "<form method=GET action=\"${SCRIPT}\">"\

  echo '<input type="radio" name="network_mode" value="1" checked> Open Network<br>'\
       '<input type="radio" name="network_mode" value="2"> Restrict Network<br>'

  echo '<br><input type="submit" value="Submit">'
       
  # Make sure we have been invoked properly.

  if [ "$REQUEST_METHOD" != "GET" ]; then
        echo "<hr>Script Error:"\
             "<br>Usage error, cannot complete request, REQUEST_METHOD!=GET."\
             "<br>Check your FORM declaration and be sure to use METHOD=\"GET\".<hr>"
        exit 1
  fi

  # If no search arguments, exit gracefully now.

  if [ ! -z "$QUERY_STRING" ]; then
     # No looping this time, just extract the data you are looking for with sed:
     MODE=`echo "$QUERY_STRING" | sed -n 's/^.*network_mode=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
     echo '<br>'
     if [ $MODE -eq 1 ]; then
       /jffs/bin/guest_on > /dev/null
       echo "<br>The network is unrestricted.<br>"
     elif [ $MODE -eq 2 ]; then
       /jffs/bin/guest_restrict > /dev/null
       echo "<br>The network is restricted.<br>"
     else
       echo "<br>error: MODE: " $MODE "<br>"
     fi
  fi
# echo "<pre>"
# iptables -nvL FORWARD
# echo "</pre>"
echo '</body>'
echo '</html>'

exit 0

