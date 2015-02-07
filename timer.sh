#!/bin/sh
cat << EOT

<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
var Timer;
var TotalSeconds;

function CreateTimer(TimerID, Time) {
  Timer = document.getElementById(TimerID);
  TotalSeconds = Time;

  UpdateTimer();
  window.setTimeout("Tick()", 1000);
}

function Tick() {
  TotalSeconds -= 1;
  UpdateTimer();
  window.setTimeout("Tick()", 1000);
}

function UpdateTimer() {
  Timer.innerHTML = TotalSeconds;
}

</script>
</head>

<body>
<div id='timer' />
<script type="text/javascript">window.onload = CreateTimer("timer", 30);</script>
</body>
</html>

EOT

function GetData() {
  // 1. Instantiate XHR - Start
  var xhr;
  if (window.XMLHttpRequest) 
    xhr = new XMLHttpRequest();
  else if (window.ActiveXObject) 
    xhr = new ActiveXObject("Msxml2.XMLHTTP");
  else 
    throw new Error("Ajax is not supported by your browser");
  // 1. Instantiate XHR - End

  // 2. Handle Response from Server - Start
  xhr.onreadystatechange = function () {
    if (xhr.readyState < 4)
      document.getElementById('timer').innerHTML = "Loading...";
    else if (xhr.readyState === 4) {
      if (xhr.status == 200 && xhr.status < 300) 
        document.getElementById('timer').innerHTML = xhr.responseText;
    }
  }
  // 2. Handle Response from Server - End

  // 3. Specify your action, location and Send to the server - Start    
  xhr.open('GET', 'data1.html'); 
  xhr.send(null);
  // 3. Specify your action, location and Send to the server - End
}

