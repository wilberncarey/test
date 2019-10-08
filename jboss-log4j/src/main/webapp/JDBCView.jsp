<%@page import="java.sql.*, java.io.*, javax.sql.DataSource, javax.naming.*"%> 
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
    <a href="sysinf.jsp" target="_blank" data-role="button"  data-position-to="window"  data-icon="heart">System Health</a>
    <a href="JVMinf.jsp" target="_blank" data-role="button"  data-position-to="window"  data-icon="heart">JVM Health</a>
    <a href="#" data-role="button"   data-position="right" data-position-fixed="true"><%=request.getServerName()%> - (<%=request.getLocalName()%>) </a>
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
  <h3 style="text-align: center">DataSource Tester</h3>


<%! 
String dsName = "jboss/datasources/ExampleDS"; 
%> 
<% 
String req = request.getParameter ("dsName"); 
if (req != null) { 
dsName = req; 
} 
%> 
<div style="display: table;padding-left: 10px;">
<form method="post" action="<%=request.getRequestURI()%>"> 
<div style="display: table-cell;float: left;">
<label style="padding-right: 10px;" for="inp">Enter Datasource Name:&nbsp;&nbsp;&nbsp;  </label>
</div>

<div style="padding-left: 15px;display: table-cell;float: left;">
<input id="inp" size="40" type="text" value="<%=dsName%>" name="dsName"/>

<div style="padding-left: 15px;float: right;"  class="ui-input-btn ui-btn ui-icon-arrow-u-r ui-btn-icon-right 
            ui-mini ui-btn-inline ui-corner-all">Submit
<input data-enhanced="true" type="submit" name="Submit" value="submit"/> 
</div>
</div>


</form> 
</div>
<br/>

<% 
try { 
String driver = ""; 
String db = ""; 


if (!dsName.equals("")) { 
InitialContext ctx = new InitialContext(); 
DataSource dataSource = (DataSource) ctx.lookup (dsName); 
Connection con = dataSource.getConnection(); 
DatabaseMetaData dmd = con.getMetaData(); 
db = dmd.getDatabaseProductName() + " " + dmd.getDatabaseProductVersion(); 
driver = dmd.getDriverName() + " " + dmd.getDriverVersion(); 

%> 
Success! We looked up and got a connection to <%=dsName%><br> 
Database: <%=db%> <br> 
Driver version: <%=driver%><br> 
<% 
} 
} 
catch (Exception e) { 
PrintWriter pw = new PrintWriter (out); 
%> 
There was an exeption getting a connection to or looking up the datasource:<%=dsName%><br> 
        <%
        e.printStackTrace (pw);
        %>
    

<% 

} 
%> 
   <br><br>
    
    

    </div>
 
    

	

	</body>
</html>