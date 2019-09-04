<%@ page import="java.util.*,java.io.*,java.net.*,java.nio.file.Files,java.nio.file.Paths"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    
   
      <meta http-equiv="cache-control" content="no-cache, must-revalidate, post-check=0, pre-check=0" />
  <meta http-equiv="cache-control" content="max-age=0" />
  <meta http-equiv="expires" content="0" />
  <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
  <meta http-equiv="pragma" content="no-cache" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
	<link rel="stylesheet" href="css/main1.css" />
	<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<%
int dataSize = 1024 * 1024;

String jvmName = java.lang.management.ManagementFactory.getRuntimeMXBean().getName();
long pid = Long.valueOf(jvmName.split("@")[0]);

%>

 

<meta charset="UTF-8">
<title>Java Tools</title>

 <style>
  .panel-content {
    padding: 1em;
  }
 iframe {

    margin: 0px;
    padding: 0px;
    background: black;
    border: 0px;
    display: block;

}
 

#toptab {
 padding-left: 12px;
  border-collapse: collapse;
  border: none!important;
  width: 90%;
   background-color: transparent;
  color: lightgrey;
}
#toptab td, #toptab th {
  border: none;
  padding: 2px;
   background-color: transparent;
  color: black;
  font-size: 12px;
}

  </style>
<script>
// Preventing whiteflash in loading iframes.     
(function () {
    var div = document.createElement('div'),
        ref = document.getElementsByTagName('base')[0] || 
              document.getElementsByTagName('script')[0];
    div.innerHTML = '&shy;<style> iframe { visibility: hidden; } </style>';
    ref.parentNode.insertBefore(div, ref);
    window.onload = function() {
        div.parentNode.removeChild(div);
    }
})();
</script>


<body >


 
<div data-role="page" id="page1">
   
<div data-role="header">
 <h1 style="font-size: 48px">Java Tools</h1>
 


<div id="show" class="ui-btn-left" style="z-index: 9999;position:fixed" data-role="controlgroup" id="buttons-sys" data-type="horizontal">

</div>

<div class="ui-btn-right" style="z-index: 9998;position:fixed" data-role="controlgroup" id="buttons-1" data-type="horizontal">

    <a href="#defaultpanel" data-role="button" data-position="right" data-position-fixed="true" data-icon="bars">Menu</a>
    <a href="Logout.jsp"  data-role="button" data-position="right" data-position-fixed="true" data-icon="delete">Log Out</a>
    <a href="#popupLogA" data-role="button" data-rel="popup" data-position-to="window"  data-icon="heart">System Health</a>
    <a href="#popupLogB" data-role="button" data-rel="popup" data-position-to="window"  data-icon="heart">JVM Health</a>
    <a href="#" data-role="button"   data-position="right" data-position-fixed="true"><%=request.getServerName()%> - (<%=request.getLocalName()%>) </a>
</div>


<div data-history="false" data-role="popup" id="popupLogA" data-arrow="true" data-theme="b"  data-overlay-theme="b">
<a href="#"  data-rel="back" data-role="button" data-theme="a" class="ui-btn ui-btn-b ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
<iframe id="sysframe" src="sysinf.jsp"  width="800" height="450"></iframe></div>

<div data-history="false" data-role="popup" id="popupLogB" data-arrow="true" data-theme="b"  data-overlay-theme="b">
<a href="#"  data-rel="back" data-role="button" data-theme="a" class="ui-btn ui-btn-b ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
<iframe id="JVMframe" src="JVMinf.jsp"  width="600" height="450"></iframe>
</div>




<div  role="main" class="ui-content">

  

</div>






</div>



  
  
  
<div style="font-size: 18px!important;z-index: 9999;" data-role="panel" id="defaultpanel" data-theme="b" data-position="right" data-position-fixed="true" data-display="overlay">
<div class="panel-content">
 	  <ul data-role="listview" id="listview-1">
 	  
<%
			//Output message
			if (System.getProperty("BatchUser") != null) {

				
				out.println("<li data-icon=\"home\"><a href=\"Home.jsp\">HOME</a></li>");
				out.println("<li><a href=\"LogView.jsp\">Log Viewer</a></li>");
				out.println("<li><a href=\"LogAdmin.jsp\">Log level Configurator</a></li>");
				out.println("<li><a href=\"PropsView.jsp\">Properties Viewer</a></li>");
				out.println("<li><a href=\"BatchAdmin.jsp\">Batch Administration</a></li>");
				out.println("<li><a href=\"CommTest.jsp\">Communication Tester</a></li>");
				out.println("<li><a href=\"ThreadView.jsp\">JVM Thread Dump</a></li>");
				out.println("<li><a href=\"MemView.jsp\">JVM Memory Usage</a></li>");
				out.println("<li><a href=\"JDBCView.jsp\">JDBC Tester</a></li>");
				out.println("<li><a href=\"SysView.jsp\">System Resources</a></li>");
				
				out.println("<li><a href=\"DumpGen.jsp\">Dump Generator</a></li>");
			
		
				
			}
			else
			{
				
				out.println("<li data-icon=\"home\"><a href=\"Home.jsp\">HOME</a></li>");
			
				
				out.println("<li><a href=\"LogView.jsp\">Log Viewer</a></li>");
				out.println("<li><a href=\"LogAdmin.jsp\">Log level Configurator</a></li>");
				out.println("<li><a href=\"PropsView.jsp\">Properties Viewer</a></li>");
				out.println("<li><a href=\"CommTest.jsp\">Communication Tester</a></li>");
				out.println("<li><a href=\"ThreadView.jsp\">JVM Thread Dump</a></li>");
				out.println("<li><a href=\"MemView.jsp\">JVM Memory Usage</a></li>");
				out.println("<li><a href=\"JDBCView.jsp\">JDBC Tester</a></li>");
				out.println("<li><a href=\"SysView.jsp\">System Resources</a></li>");
				
				out.println("<li><a href=\"DumpGen.jsp\">Dump Generator</a></li>");
			}
	
%>

 	  

	  </ul>
	<br/>
	<br/>
     
    </div>
   <!-- /content wrapper for padding -->

   
  </div>

 <br/>
 <br/>
  
  <h3 style="text-align: center">Communications Tester</h3>
      


<table id="myTable" class="alt">
<thead>
<tr>
<th style="font-size: 2rem;">Host / Port</th>
<th style="font-size: 2rem;">Result</th>
<th style="font-size: 2rem;">Status</th>
<th style="font-size: 2rem;">Exit Code</th>
</tr>
</thead>
<tbody>


<%

String webInfPath = getServletConfig().getServletContext().getRealPath("WEB-INF/classes");
List<String> allLines = Files.readAllLines(Paths.get(webInfPath + "/CommTestData.txt"));
for (String line1 : allLines) {
	//System.out.println(line1);


 
 
StringBuilder sbcomm = new StringBuilder();

sbcomm.append("if nc -w 3 -z " + line1 +"; then echo \"<tr><td>" + line1 +"</td><td> Success</td><td><center><img src=\"img/green.png\" height=\"20\"/></center></td><td>Exit code from Netcat was ($?).</td></tr>\"; else echo \"<tr><td>" + line1 +"</td><td> Failed</td><td><center><img src=\"img/red.png\" height=\"20\"/></center></td><td>Exit code from Netcat was ($?).</td></tr>\"; fi \n");

ProcessBuilder pbcomm = new ProcessBuilder("/bin/bash");
Process bashcomm = pbcomm.start();

// Pass commands to the shell
PrintStream pscomm = new PrintStream(bashcomm.getOutputStream());
pscomm.println(sbcomm);
System.out.println(sbcomm);
pscomm.close();

// Get an InputStream for the stdout of the shell
BufferedReader brcomm = new BufferedReader(
    new InputStreamReader(bashcomm.getInputStream()));

// Retrieve and print output

while (null != (line1 = brcomm.readLine())) {
  out.println(line1);
}

}





        %>
</tbody>
</table>

  
 </div>

	

	</body>
</html>