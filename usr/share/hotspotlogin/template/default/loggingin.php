<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
  <title>Mutiara-Wrt</title>
  <script type="text/javascript" language="Javascript">
  //<!--
  function getURLParam(name) {
    var params = new URLSearchParams(window.location.search);
    return params.get(name);
  }

  var loginUrl = 'http://10.10.10.1:3990/prelogin';
  function redirect() { 
    if (loginUrl) {
      window.location = loginUrl; 
    } else {
      console.error('Login URL is not defined.');
    }
    return false; 
  }

  window.onload = function() {
    var paramUrl = getURLParam("loginurl");
    if (paramUrl) {
      loginUrl = paramUrl;
    }
    setTimeout(redirect, 5000); 
  }
  //-->
  </script>
</head>
<body style="margin: 0pt auto; height:100%;">
  <div style="width:100%;height:80%;position:fixed;display:table;">
    <p style="display: table-cell; line-height: 2.5em; vertical-align:middle; text-align:center; color:grey;">
      <a href="#" onclick="javascript:return redirect();">
        <img src="assets/images/coova.jpg" alt="" border="0" height="39" width="123"/>
      </a><br>
      <small><img src="assets/images/wait.gif"/> redirecting...</small>
    </p>
    <br><br>
  </div>
</body>
</html>
