#!/bin/sh
export PATH=/jffs/bin:$PATH
echo '<!DOCTYPE html>'
echo '<head>'
echo '<title>Network Control</title>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<meta name="viewport" content="width=device-width, initial-scale=1">'
echo '<style>'
echo '  #iptables-output {'
echo '    background: rgb(230, 230, 230);'
echo '    overflow-x: auto;'
echo '  }'
echo '</style>'
echo '</head>'
echo '<body>'
# Reminder: where is this script?
echo "<p>"
echo -n "Script host: "
hostname
echo "<p>"
echo -n "Script location: "
echo $0
echo "<p>"

echo "<form method=GET action=\"${SCRIPT}\">"
#echo '<input type="radio" name="network_mode" value="1" checked> Open Network<br>'
#echo '<input type="radio" name="network_mode" value="2"> Restrict Network<br>'
# echo '<br><input type="submit" value="Submit">'
echo '<button type="submit" value=1 name="network_mode" formmethod="get" formaction="">Open Network</button>'
echo '<button type="submit" value=2 name="network_mode" formmethod="get" formaction="">Restrict Network</button>'
echo "</form>"
  # Make sure we have been invoked properly.

  if [ "$REQUEST_METHOD" != "GET" ]; then
        echo "<hr>Script Error:"\
             "<br>Usage error, cannot complete request, REQUEST_METHOD!=GET."\
             "<br>Check your FORM declaration and be sure to use METHOD=\"GET\".<hr>"
        exit 1
  fi

  echo '<br>'
  if [ ! -z "$QUERY_STRING" ]; then
     MODE=`echo "$QUERY_STRING" | sed -n 's/^.*network_mode=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
     if [ $MODE -eq 1 ]; then
       /jffs/bin/guest_on > /dev/null
       /jffs/bin/dial_control 100
       echo "network on from '$REMOTE_ADDR':" `date` >> /tmp/network_control.log
     elif [ $MODE -eq 2 ]; then
       /jffs/bin/guest_restrict > /dev/null
       /jffs/bin/dial_control 0
       echo "network off from '$REMOTE_ADDR':" `date` >> /tmp/network_control.log
     else
       echo "error: MODE: \" $MODE \""
     fi
  fi
# Note: /tmp/network_control_* are managed by /jffs/bin/guest_*.
if [ -f /tmp/network_control_restricted ] ; then
  echo "The network is restricted.<br>"
elif  [ -f /tmp/network_control_unrestricted ] ; then
  echo "The network is unrestricted.<br>"
fi
echo '<div id="iptables-output">'
echo '<pre>'
iptables -nvL FORWARD
echo '</pre>'
echo '</div>'
echo '</body>'
echo '</html>'

exit 0

