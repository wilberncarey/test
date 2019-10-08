<%@ page language="java" import="java.util.*,java.lang.Thread.*" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>

<%@page import="java.util.*,
                java.net.*,
                java.text.*,
                java.util.zip.*,
                java.io.*"
%>
<%@page import="java.lang.management.ClassLoadingMXBean"%>
<%@page import="java.lang.management.RuntimeMXBean"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.lang.management.ThreadInfo"%>
<%@page import="java.lang.management.ManagementFactory"%>
<%@page import="java.lang.management.ThreadMXBean"%>
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
  <h3 style="text-align: center">Thread Dump</h3>
      
      
<br><br>
<table>
<tr>
<td bgcolor="#E7E7EF" bordercolor="#000000" align="center" nowrap>
<font face="Verdana" size="+1">Thread Dumps&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
</td>
</tr>

<tr>
<td bgcolor="#E7E7EF" bordercolor="#000000">
<%


final String VERSION = "2.0";

ThreadMXBean txBean = ManagementFactory.getThreadMXBean();
RuntimeMXBean runBean = ManagementFactory.getRuntimeMXBean();
ClassLoadingMXBean classBean = ManagementFactory.getClassLoadingMXBean();
txBean.setThreadContentionMonitoringEnabled(true);
//out.print("<h1>JMX Thread Dump (v"+ VERSION + ")</h1><hr>");
out.print("<h2>JVM Summary</h2>");
out.print("&nbsp;&nbsp;&nbsp;<b>JVM bootclasspath: </b>" + runBean.getBootClassPath() + "<br>");
out.print("<br>&nbsp;&nbsp;&nbsp;<b>JVM classpath: </b>" + runBean.getClassPath() + "<br>");
out.print("<br>&nbsp;&nbsp;&nbsp;<b>JVM lib path: </b>" + runBean.getLibraryPath() + "<br>");
out.print("<br>&nbsp;&nbsp;&nbsp;<b>JVM start time: </b>" + new java.util.Date(runBean.getStartTime()) + "<br>");
out.print("<br>&nbsp;&nbsp;&nbsp;<b>JVM uptime: </b>" + (runBean.getUptime()/1000)/60 + " min<br>");
List<String> args = runBean.getInputArguments();
out.print("<br>&nbsp;&nbsp;&nbsp;<b>JVM arguments: </b><br>");
for (int i=0; i< args.size(); i++){
	out.print("<pre>      " + args.get(i) + "</pre>");
}



out.print("<hr><h2>Thread Summary</h2>&nbsp;&nbsp;&nbsp;<b>Peak Thread Count:</b>" + txBean.getPeakThreadCount());
out.print("&nbsp;&nbsp;&nbsp;<b>Current Thread Count:</b>" + txBean.getThreadCount());
out.print("&nbsp;&nbsp;&nbsp;<b>Deadlocked threads:</b> " + txBean.findDeadlockedThreads());
out.print("&nbsp;&nbsp;&nbsp;<b>Monitor deadlocked threads:</b> " + txBean.findMonitorDeadlockedThreads() + "<br>");

out.print("<hr><h2>Classloading Summary</h2>&nbsp;&nbsp;&nbsp;<b># of classes loaded now:</b>" + classBean.getLoadedClassCount());
out.print("&nbsp;&nbsp;&nbsp;<b>Total # of class loaded since start:</b>" + classBean.getTotalLoadedClassCount());
out.print("&nbsp;&nbsp;&nbsp;<b># of unloaded classes:</b> " + classBean.getUnloadedClassCount() + "<br><hr>");




out.print("<h2>Thread details</h2>");


%>
<%!
//private static ThreadMXBean thMxBean =
//ManagementFactory.getThreadMXBean();
//private static String getTaskName(long id, String name)
//{
  //  if (name == null) {
    //    return Long.toString(id);
   // }
   // return id + " (" + name + ")<br>";
//}
%>
<%
out.print("---------------------------START-----------------------------------------<br>");
out.print("Generating Thread-Dump At:" + (new java.util.Date()).toString() + "<BR>");
out.println("---------------------------------------------------------------------<br>");

//Map map = Thread.getAllStackTraces();

//Iterator itr = map.keySet().iterator();
//while (itr.hasNext()) {
//Thread t = (Thread)itr.next();
//StackTraceElement[] elem = (StackTraceElement[])map.get(t);
/////////////////////
Map<Thread, StackTraceElement[]> map = Thread.getAllStackTraces();

Iterator<Thread> itr = map.keySet().iterator();

while (itr.hasNext()) {
   Thread t = itr.next();
StackTraceElement[] elem = map.get(t);
out.print("\"" + t.getName() + "\"");
out.print(" Priority=" + t.getPriority());
out.print(" Thread Id=" + t.getId());
State s = t.getState();
String state = null;
String color = "000000";
String GREEN = "00FF00";
String RED = "FF0000";
String ORANGE = "FCA742";
switch(s) {
case NEW: state ="NEW"; color = GREEN; break;
case BLOCKED: state = "BLOCKED"; color = RED; break;
case RUNNABLE: state = "RUNNABLE"; color = GREEN; break;
case TERMINATED: state = "TERMINATED"; break;
case TIMED_WAITING: state = "TIME WAITING"; color = ORANGE; break;
case WAITING: state = "WAITING"; color = RED; break;
}
out.print("<font color=\"" + color + "\"> In State :</font>");
out.println(" " + state + "<BR>");
for (int i=0; i < elem.length; i++) {
out.println("  at ");
out.print(elem[i].toString());
out.println("<BR>");
}
out.println("--------------------------------------------------------------------------<br>");
}
out.print("----------------------------FINISH--------------------------------------<br>");
out.print("Generated Thread-Dump At:" + (new java.util.Date()).toString() + "<BR>");
out.println("---------------------------------------------------------------------<br>");
%>
</td>
</tr>
</table>
<br><br>

   

	</div>

	</body>
</html>